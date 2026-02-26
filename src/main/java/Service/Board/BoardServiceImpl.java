package Service.Board;

import DAO.Board.BoardDAO;
import DAO.Board.BoardDAOImpl;
import DTO.Board.BoardDTO;
import DTO.Board.LinkPreviewDTO;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BoardServiceImpl implements BoardService {

    private static BoardServiceImpl instance;

    private final BoardDAO bdao;

    private BoardServiceImpl() {
        this.bdao = BoardDAOImpl.getInstance();
    }

    public static BoardServiceImpl getInstance() {
        if (instance == null) {
            instance = new BoardServiceImpl();
        }
        return instance;
    }

    @Override
    public int boardIn(BoardDTO bdto) {
        bdao.boardIn(bdto);
        return 1;
    }

    @Override
    public List<BoardDTO> boardList() {
        return bdao.boardList();
    }

    @Override
    public BoardDTO getBoardCont(int boardId) {
        return bdao.getBoardCont(boardId);
    }

    @Override
    public void plusReadCount(int boardId) {
        bdao.updateReadCount(boardId);
    }

    @Override
    public BoardDTO getBoardDetail(int boardId) {
        bdao.updateReadCount(boardId);
        return bdao.getBoardCont(boardId);
    }

    // 링크 첨부
    @Override
    public Map<String, Object> getBoardDetailWithPreview(int boardId) {

        BoardDTO board = getBoardDetail(boardId);

        String content = board.getBoardContent(); // 여기 getter는 너 DTO에 맞춰 수정 필요
        String url = extractUrl(content);

        LinkPreviewDTO preview = null;
        if (url != null) {
            preview = fetchPreview(url);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("board", board);
        result.put("preview", preview);

        return result;
    }

    private String extractUrl(String text) {
        if (text == null) return null;

        Pattern pattern = Pattern.compile("(https?://\\S+)");
        Matcher matcher = pattern.matcher(text);
        return matcher.find() ? matcher.group(1) : null;
    }

    private LinkPreviewDTO fetchPreview(String url) {
        try {
            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla/5.0")
                    .timeout(3000)
                    .get();

            String title = doc.select("meta[property=og:title]").attr("content");
            String desc = doc.select("meta[property=og:description]").attr("content");
            String image = doc.select("meta[property=og:image]").attr("content");

            if (isBlank(title) && isBlank(desc) && isBlank(image)) return null;

            return new LinkPreviewDTO(url, title, desc, image);

        } catch (Exception e) {
            return null;
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    @Override
    public void deleteBoard(int boardId) {
        bdao.deleteBoard(boardId);
    }

    @Override
    public void updateBoard(BoardDTO bdto) {
        bdao.updateBoard(bdto);
    }

    @Override
    public List<BoardDTO> boardListByType(int boardType) {
        return bdao.boardListByType(boardType);
    }

    @Override
    public int getBoardCount() {
        return bdao.getBoardCount();
    }

    @Override
    public List<BoardDTO> boardListPage(int startRow, int endRow) {
        return bdao.boardListPage(startRow, endRow);
    }

    @Override
    public int getBoardCountByType(int boardType) {
        return bdao.getBoardCountByType(boardType);
    }

    @Override
    public List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow) {
        return bdao.boardListPageByType(boardType, startRow, endRow);
    }

    @Override
    public int toggleBoardLike(int boardId, int boardType, int memNo) {
        int liked = bdao.isBoardLiked(boardId, boardType, memNo);
        if (liked > 0) {
            bdao.deleteBoardLike(boardId, boardType, memNo);
        } else {
            bdao.insertBoardLike(boardId, boardType, memNo);
        }
        return bdao.getBoardLikeCount(boardId, boardType);
    }

    @Override
    public int getBoardLikeCount(int boardId, int boardType) {
        return bdao.getBoardLikeCount(boardId, boardType);
    }

    @Override
    public boolean isBoardLiked(int boardId, int boardType, int memNo) {
        return bdao.isBoardLiked(boardId, boardType, memNo) > 0;
    }

    @Override
    public List<BoardDTO> hotBoardList(int limit) {
        return bdao.hotBoardList(limit);
    }

    @Override
    public List<BoardDTO> recentBoardList(int limit) {
        return bdao.recentBoardList(limit);
    }
}