package Service.Board;

import DTO.Board.BoardDTO;

import java.util.List;

public interface BoardService {

    int boardIn(BoardDTO bdto);

    List<BoardDTO> boardList();
    // 게시글 단순 조회 (수정/삭제용)
    BoardDTO getBoardCont(int boardId);

    void plusReadCount(int boardId);

    BoardDTO getBoardDetail(int boardId);

    // 삭제
    void deleteBoard(int boardId);

    // 수정
    void updateBoard(BoardDTO bdto);

}
