package Controller.Board;


import Controller.Action;
import Controller.ActionForward;
import DTO.Board.BoardDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Service.Board.BoardService;
import Service.Board.BoardServiceImpl;

import DTO.Board.AddFileDTO;
import Service.Board.AddFileService;
import Service.Board.AddFileServiceImpl;
import jakarta.servlet.http.Part;

import java.io.File;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.UUID;

import java.io.PrintWriter;

public class BoardOkController implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String contextPath = request.getContextPath();

        // 세션 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memNo") == null) {
            out.println("<script>");
            out.println("alert('글을 작성하려면 로그인을 해주세요.');");
            out.println("location='" + request.getContextPath() + "/memberLogin.do';");
            out.println("</script>");
            return null;
        }

        // 게시글 정보
        String boardTitle = request.getParameter("boardTitle");
        String boardCont = request.getParameter("boardContent");

        if (boardTitle == null || boardTitle.trim().isEmpty() ||
                boardCont == null || boardCont.trim().isEmpty()) {
            out.println("<script>");
            out.println("alert('제목과 게시글을 입력하세요.');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        // 세션에서 값 가져오기
        Integer memNo = (Integer) session.getAttribute("memNo");
        String memId = (String) session.getAttribute("memId");

        BoardDTO bdto = new BoardDTO();
        bdto.setBoardTitle(boardTitle);
        bdto.setBoardContent(boardCont);
        bdto.setMemNo(memNo);

        String typeStr = request.getParameter("boardType");

        if(typeStr == null){
            out.println("<script>");
            out.println("alert('게시판 선택하세요');");
            out.println("history.back();");
            out.println("</script>");
            return null;
        }

        int boardType = Integer.parseInt(typeStr);
        bdto.setBoardType(boardType);


        bdto.setBoardName(memId); // 세션에서 바로 사용

        try {
            BoardService boardService = BoardServiceImpl.getInstance();
            boardService.boardIn(bdto);

            // 첨부 이미지를 본문에 삽입하기 위해 업로드가 끝난 뒤 한 번에 누적 문자열을 붙인다.
            StringBuilder contentAppend = new StringBuilder();

            int newBoardId = bdto.getBoardId();
            int newBoardType = bdto.getBoardType();

            AddFileService fileService = AddFileServiceImpl.getInstance();
            /* 첨부 파일 기능 */
            Collection<Part> parts = request.getParts();
            if (parts != null) {
                String uploadDirPath = request.getServletContext().getRealPath("/upload/board");
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                for (Part part : parts) {
                     if (!"uploadFiles".equals(part.getName())) continue;
                    if (part.getSize() <= 0) continue;

                    String originalName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                    String ext = "";
                    int dot = originalName.lastIndexOf('.');
                    if (dot >= 0) ext = originalName.substring(dot);

                    String savedName = UUID.randomUUID().toString().replace("-", "") + ext;
                    File dest = new File(uploadDir, savedName);

                    part.write(dest.getAbsolutePath());

                    String savedRelativePath = "/upload/board/" + savedName;
                    String imgSrc = contextPath + savedRelativePath;

                    /* 파일 첨부 (본문에 이미지 태그 삽입) */
                    contentAppend.append("<div style='margin:14px 0;'>")
                            .append("<img src='")
                            .append(imgSrc)
                            .append("' alt='")
                            .append(originalName.replace("'", ""))
                            .append("' style='max-width:100%; border-radius:14px; border:1px solid #e5e7eb;'/>")
                            .append("</div>");

                    AddFileDTO fdto = new AddFileDTO();
                    fdto.setBoardId(newBoardId);
                    fdto.setBoardType(newBoardType);
                    fdto.setFileName(originalName);
                    fdto.setFilePath(savedRelativePath);
                    fdto.setFileSize((int) part.getSize());

                    fileService.insertFile(fdto);
                }
            }

            // 업로드된 이미지가 있다면, 기존 본문 + 이미지 태그로 본문을 갱신한다.
            if (contentAppend.length() > 0) {
                // 목록에서는 첫 이미지가 썸네일로 먼저 보이도록 이미지 태그를 본문 앞에 붙인다.
                bdto.setBoardContent(contentAppend + boardCont);
                boardService.updateBoard(bdto);
            }

            out.println("<script>");
            out.println("alert('게시글이 등록되었습니다.');");
            String filter = (boardType == 1) ? "free" : "hot";
            
            if (boardType == 10) {
				out.println("location.href='" + contextPath + "/notice.do';");
			} else if (boardType == 11) {
				out.println("location.href='" + contextPath + "/quiry.do';");
			} else {
				out.println("location.href='" + contextPath + "/freeBoard.do?filter=" + filter + "';");
			}
            out.println("</script>");
            
        }catch (Exception e){
            e.printStackTrace();
            out.println("<script>");
            out.println("alert('등록 중 오류가 발생했습니다. ( 사유: " + e.getMessage().replace("'", "") + ")');");
            out.println("history.back();");
            out.println("</script>");
        }finally {
            out.flush();
            out.close();
        }

        return null;
    }
}
