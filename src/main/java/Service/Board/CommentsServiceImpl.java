package Service.Board;

import java.util.List;
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
}