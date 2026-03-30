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

/**
 * BoardService 구현체
 * - 게시글 CRUD, 페이징, 좋아요 토글, 링크 미리보기 파싱 담당
 * - Singleton 패턴 적용
 */
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

    // =====================================================================
    // 게시글 CRUD
    // =====================================================================

    /** 게시글 등록 */
    @Override
    public int boardIn(BoardDTO bdto) {
        bdao.boardIn(bdto);
        return 1;
    }

    /** 게시글 단건 조회 (조회수 증가 없음 — 수정/삭제 전 기존 데이터 확인용) */
    @Override
    public BoardDTO getBoardCont(int boardId) {
        return bdao.getBoardCont(boardId);
    }

    /**
     * 게시글 상세 조회 + 조회수 증가
     * - 일반 게시글 상세 페이지 진입 시 호출
     */
    @Override
    public BoardDTO getBoardDetail(int boardId) {
        bdao.updateReadCount(boardId);
        return bdao.getBoardCont(boardId);
    }

    /**
     * 게시글 상세 조회 + 링크 미리보기 파싱
     * - 게시글 본문 내 URL을 추출하고 OG 태그를 파싱하여 함께 반환
     *
     * @return Map { "board": BoardDTO, "preview": LinkPreviewDTO (없으면 null) }
     */
    @Override
    public Map<String, Object> getBoardDetailWithPreview(int boardId) {
        BoardDTO board = getBoardDetail(boardId);
        String url = extractFirstUrl(board.getBoardContent());

        LinkPreviewDTO preview = (url != null) ? fetchLinkPreview(url) : null;

        Map<String, Object> result = new HashMap<>();
        result.put("board", board);
        result.put("preview", preview);
        return result;
    }

    /** 게시글 수정 */
    @Override
    public void updateBoard(BoardDTO bdto) {
        bdao.updateBoard(bdto);
    }

    /** 게시글 내용(content)만 부분 수정 */
    @Override
    public void updateBoardContent(BoardDTO bdto) {
        bdao.updateBoardContent(bdto);
    }

    /** 게시글 삭제 */
    @Override
    public void deleteBoard(int boardId) {
        bdao.deleteBoard(boardId);
    }

    // =====================================================================
    // 목록 / 페이징
    // =====================================================================

    @Override
    public int getBoardCount() {
        return bdao.getBoardCount();
    }

    @Override
    public int getBoardCountByType(int boardType) {
        return bdao.getBoardCountByType(boardType);
    }

    @Override
    public List<BoardDTO> boardListPage(int startRow, int endRow) {
        return bdao.boardListPage(startRow, endRow);
    }

    @Override
    public List<BoardDTO> boardListPageByType(int boardType, int startRow, int endRow) {
        return bdao.boardListPageByType(boardType, startRow, endRow);
    }

    @Override
    public List<BoardDTO> recentBoardList(int limit) {
        return bdao.recentBoardList(limit);
    }

    @Override
    public List<BoardDTO> hotBoardList(int limit) {
        return bdao.hotBoardList(limit);
    }

    @Override
    public List<BoardDTO> getPopularBoardList(String period, int limit) {
        return bdao.getPopularBoardList(period, limit);
    }

    @Override
    public BoardDTO latestNotice() {
        return bdao.latestNotice();
    }

    @Override
    public String getMovieTitleforBoard(int movieId) {
        return bdao.getMovieTitleforBoard(movieId);
    }

    // =====================================================================
    // 좋아요
    // =====================================================================

    /**
     * 좋아요 토글 (있으면 취소, 없으면 등록)
     *
     * @return 토글 후 최신 좋아요 총 개수
     */
    @Override
    public int toggleBoardLike(int boardId, int boardType, int memNo) {
        boolean alreadyLiked = bdao.isBoardLiked(boardId, boardType, memNo) > 0;
        if (alreadyLiked) {
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

    // =====================================================================
    // 링크 미리보기 파싱 (private)
    // =====================================================================

    /** 게시글 본문에서 첫 번째 URL 추출 */
    private String extractFirstUrl(String text) {
        if (text == null || text.isBlank()) return null;
        Matcher matcher = Pattern.compile("(https?://\\S+)").matcher(text);
        return matcher.find() ? matcher.group(1) : null;
    }

    /**
     * URL의 OG 메타 태그를 파싱하여 LinkPreviewDTO 반환
     * - title, description, image 모두 비어있으면 null 반환
     * - 네트워크 오류 등 예외 발생 시 null 반환 (미리보기 없음 처리)
     */
    private LinkPreviewDTO fetchLinkPreview(String url) {
        try {
            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla/5.0")
                    .timeout(3000)
                    .get();

            String title = doc.select("meta[property=og:title]").attr("content");
            String desc = doc.select("meta[property=og:description]").attr("content");
            String image = doc.select("meta[property=og:image]").attr("content");

            if (title.isBlank() && desc.isBlank() && image.isBlank()) return null;

            return new LinkPreviewDTO(url, title, desc, image);
        } catch (Exception e) {
            return null;
        }
    }
}
