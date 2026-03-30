package DTO.Board;

import lombok.Getter;
import lombok.Setter;

/**
 * 게시글 첨부파일 데이터 전달 객체 (DTO)
 */
@Getter
@Setter
public class AddFileDTO {

    private int fileNo;              // 파일 고유 번호
    private int boardId;             // 소속 게시글 번호
    private int boardType;           // 소속 게시판 타입
    private String fileName;         // 저장된 파일명 (UUID 기반)
    private String filePath;         // 서버 내 파일 경로
    private int fileSize;            // 파일 크기 (bytes)
    private String fileUploadDate;   // 업로드 일시
}
