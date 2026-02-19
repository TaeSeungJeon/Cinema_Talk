package Controller.Vote;

import java.util.ArrayList;
import java.util.List;

import Controller.Action;
import Controller.ActionForward;
import DTO.Vote.VoteOptionDTO;
import DTO.Vote.VoteRegisterDTO;
import Service.Vote.VoteService;
import Service.Vote.VoteServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminVoteFormOkController implements Action {

  @Override
  public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

    VoteService voteService = new VoteServiceImpl();

    String state = request.getParameter("state");
    int voteId = Integer.parseInt(request.getParameter("voteId"));

    String voteTitle = request.getParameter("voteTitle");
    String voteContent = request.getParameter("voteContent");
    String voteStartDate = request.getParameter("voteStartDate");
    String voteEndDate = request.getParameter("voteEndDate");
    String[] movieIds = request.getParameterValues("movieId");

    boolean isSuccess = false;

    List<VoteOptionDTO> voptList = new ArrayList<>();

    if (movieIds != null) {
      for (String movieId : movieIds) {
        VoteOptionDTO vopt = new VoteOptionDTO();
        vopt.setMovieId(Integer.parseInt(movieId));

        voptList.add(vopt);
      }
    }

    VoteRegisterDTO vdto = new VoteRegisterDTO();
    vdto.setVoteTitle(voteTitle);
    vdto.setVoteContent(voteContent);
    vdto.setVoteStartDate(voteStartDate);
    vdto.setVoteEndDate(voteEndDate);
    vdto.setOptionList(voptList);

    if ("insert".equals(state)) {
      isSuccess = voteService.insertVoteRegister(vdto);
    } else if ("update".equals(state)) {
     // isSuccess = voteService.updateVoteRegister(voteId, vdto);
    } else if ("delete".equals(state)) {
     // isSuccess = voteService.deleteVoteRegister(voteId);
    }

    ActionForward forward = new ActionForward();
    forward.setRedirect(false);
    forward.setPath("/WEB-INF/views/vote/adminVote.jsp");
    return forward;
  }

}
