package Service.Board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DAO.Board.Comments;
import DAO.Board.CommentsImpl;
import DTO.Board.CommentsDTO;

public class CommentsServiceImpl implements CommentsService {

    // [싱글톤 설정]
    private static CommentsServiceImpl instance = new CommentsServiceImpl();
    private CommentsServiceImpl() {}
    public static CommentsServiceImpl getInstance() {
        return instance;
    }

    // DAO 객체 가져오기
    private Comments dao = CommentsImpl.getInstance();

    @Override
    public int commentsIn(CommentsDTO cdto) {
        // 컨트롤러에서 받은 데이터를 DAO로 전달
        return dao.commentsIn(cdto);
    }

    @Override
    public List<CommentsDTO> commentsList(int boardId) {
        // DB에서 가져온 리스트를 컨트롤러로 전달
        return dao.commentsList(boardId);
    }

    @Override
    public int commentsUpdate(CommentsDTO dto) {
        return dao.commentsUpdate(dto);
    }

    @Override
    public int commentsDelete(Map<String, Object> map) {
        return CommentsImpl.getInstance().commentsDelete(map);
    }

    @Override
    public int toggleCommentsLike(int commentsId, int memNo) {
        Map<String, Object> map = Map.of("commentsId", commentsId, "memNo", memNo);

        // 현재 좋아요 상태 확인
        int isLiked = dao.commentsLikeCheck(map);

        if (isLiked > 0) {
            // 좋아요가 있으면 삭제
            return dao.commentsLikeDelete(map);
        } else {
            // 좋아요가 없으면 추가
            return dao.commentsLikeInsert(map);
        }
    }

    @Override
    public List<CommentsDTO> commentsListWithLike(int boardId, Integer memNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("boardId", boardId);
        map.put("memNo", memNo);
        return dao.commentsListWithLike(map);
    }

    @Override
    public int getCommentsLikeCount(int commentsId) {
        return dao.commentsLikeCount(commentsId);
    }
}