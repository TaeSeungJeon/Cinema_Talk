package DTO.Board;

import lombok.Getter;
import lombok.Setter;

@Setter@Getter
public class AddFileDTO {

    private int fileNo;
    private int boardId;
    private int boardType;
    private String fileName;
    private String filePath;
    private int fileSize;
    private String fileUploadDate;
}



