package Service.Admin;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import org.apache.ibatis.session.SqlSession;

import DAO.Admin.AdminMovieDAO;
import DAO.Admin.AdminMovieDAOImpl;
import DAO.Admin.Stats.AdminBoardStatsDAO;
import DAO.Admin.Stats.AdminBoardStatsDAOImpl;
import DAO.Admin.Stats.AdminMemberStatsDAO;
import DAO.Admin.Stats.AdminMemberStatsDAOImpl;
import DAO.Admin.Stats.AdminVoteStatsDAO;
import DAO.Admin.Stats.AdminVoteStatsDAOImpl;
import DAO.Movie.Recommend.MovieRecDAOImpl;
import DTO.Admin.Stats.AdminBoardStatDTO;
import DTO.Admin.Stats.AdminInquiryStatDTO;
import DTO.Admin.Stats.AdminMemberStatDTO;
import DTO.Admin.Stats.AdminSummaryDTO;
import DTO.Admin.Stats.AdminVoteStatDTO;
import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.PeriodStatDTO;
import mybatis.DBService;

public class AdminStatsServiceImpl implements AdminStatsService {
	
	private static AdminStatsServiceImpl instance = null;

    private AdminStatsServiceImpl() {}
        
    public static AdminStatsServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdminStatsServiceImpl();
		}
		return instance;
	}
    
    private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}

	@Override
	public AdminSummaryDTO getSummaryStat(DateRangeDTO dataRange) {
		AdminSummaryDTO summaryDTO = new AdminSummaryDTO();
		
		DateRangeDTO previousRange = getPreviousDateRange(dataRange);
		
		try(SqlSession session = getSqlSession()) {
			AdminMemberStatsDAO dao = new AdminMemberStatsDAOImpl(session);
			
			// 기간 내 신규 회원 수
			int currentNewMemCnt = dao.selNewMemberCntByRange(dataRange);
			int previousNewMemCnt = dao.selNewMemberCntByRange(previousRange);
			
			summaryDTO.setNewMemberCnt(calculatePeriodStat(currentNewMemCnt, previousNewMemCnt));
			
			// 기간 내 신규 게시글 수
			int currentNewBoardCnt = dao.selNewBoardCntByRange(dataRange);
			int previousNewBoardCnt = dao.selNewBoardCntByRange(previousRange);
			
			summaryDTO.setNewBoardCnt(calculatePeriodStat(currentNewBoardCnt, previousNewBoardCnt));
			
			// 기간 내 신규 투표 참여 수
			int currentNewVoteJoinCnt = dao.selNewVoteJoinCntByRange(dataRange);
			int previousNewVoteJoinCnt = dao.selNewVoteJoinCntByRange(previousRange);
			
			summaryDTO.setNewVoteJoinCnt(calculatePeriodStat(currentNewVoteJoinCnt, previousNewVoteJoinCnt));
			
			// 기간 내 신규 문의 수
			int currentNewInquiryCnt = dao.selNewInquiryCntByRange(dataRange);
			int previousNewInquiryCnt = dao.selNewInquiryCntByRange(previousRange);
			
			summaryDTO.setNewInquiryCnt(calculatePeriodStat(currentNewInquiryCnt, previousNewInquiryCnt));

			// 일별 방문자 추이
			summaryDTO.setDailyVisitorTrend(dao.selDailyVisitorTrend(dataRange));
			
			// 일별 신규 회원 추이
			summaryDTO.setDailyNewMemberTrend(dao.selDailyNewMemberTrend(dataRange));
		}
		
		return summaryDTO;
	}

	// 회원 통계
	@Override
	public AdminMemberStatDTO getMemberStat(DateRangeDTO dataRange) {
	    AdminMemberStatDTO memberStatDTO = new AdminMemberStatDTO();

	    try (SqlSession session = getSqlSession()) {
	    	AdminMemberStatsDAO dao = new AdminMemberStatsDAOImpl(session);
	    	DateRangeDTO previousRange = getPreviousDateRange(dataRange);
	    	
	    	// 총 회원 수 + 증가률
	    	int currentTotalMemCnt = dao.selMemberCnt();
	    	int previousTotalMemCnt = dao.selTotalMemberCountByDate(dataRange.getEndDate().minusMonths(1));
	    	
	    	memberStatDTO.setTotalMemberStat(calculatePeriodStat(currentTotalMemCnt, previousTotalMemCnt));
	    	
	    	// 신규 회원 수 + 증가률
	    	int currentNewMemCnt = dao.selNewMemberCnt(dataRange);
	    	int previousNewMemCnt = dao.selNewMemberCnt(getPreviousDateRange(dataRange));
	    	
	    	memberStatDTO.setNewMemberStat(calculatePeriodStat(currentNewMemCnt, previousNewMemCnt));
	    	
	    	// 휴면 회원 수
	    	memberStatDTO.setSleepMemberCnt(dao.selSleepMemberCnt());
	    	
	    	// 탈퇴 회원 수
	    	memberStatDTO.setOutMemberCnt(dao.selOutMemberCnt());
	    	
	    	// 신규 회원 추이
	    	memberStatDTO.setDailyNewMemberTrend(dao.selNewMemberTrend(dataRange));
	    	
	    	// 우수 회원 TOP 10(게시글)
	    	memberStatDTO.setTopBoardMembers(dao.selTopBoardMembers());
	    	// 우수 회원 TOP 10(댓글)
	    	memberStatDTO.setTopCommentMembers(dao.selTopCommentMembers());
	    }

	    return memberStatDTO;
	}

	// 게시글 통계
	@Override
	public AdminBoardStatDTO getBoardStat(DateRangeDTO dataRange) {
		AdminBoardStatDTO boardStatDTO = new AdminBoardStatDTO();
		
		try (SqlSession session = getSqlSession()) {
			AdminBoardStatsDAO dao = new AdminBoardStatsDAOImpl(session);
			
			// 총 게시글 수 + 증가률
	    	int currentTotalBoardCnt = dao.selBoardCnt();
	    	int previousTotalBoardCnt = dao.selTotalBoardCountByDate(dataRange.getEndDate().minusMonths(1));
	    	
	    	boardStatDTO.setTotalBoardStat(calculatePeriodStat(currentTotalBoardCnt, previousTotalBoardCnt));
	    	
	    	// 총 댓글 수 + 증가률
	    	int currentTotalCommentCnt = dao.selCommentCnt();
	    	int previousTotalCommentCnt = dao.selTotalCommentCountByDate(dataRange.getEndDate().minusMonths(1));
	    	
	    	boardStatDTO.setTotalCommentStat(calculatePeriodStat(currentTotalCommentCnt, previousTotalCommentCnt));
	    	
	    	// 총 좋아요 수
	    	boardStatDTO.setTotalLikeCnt(dao.selLikeCnt());
	    	
	    	// 총 조회 수
	    	boardStatDTO.setTotalViewCnt(dao.selViewCnt());
	    	
	    	// 게시글 등록 추이
	    	boardStatDTO.setDailyNewBoardTrend(dao.selDailyNewBoardTrend(dataRange));
	    	
	    	// 인기 게시글 TOP 10
	    	boardStatDTO.setTopBoards(dao.selTopBoards());
		}
		return boardStatDTO;
	}

	// 투표 통계
	@Override
	public AdminVoteStatDTO getVoteStat(DateRangeDTO dataRange) {
		AdminVoteStatDTO voteStatDTO = new AdminVoteStatDTO();
		
		try (SqlSession session = getSqlSession()) {
			AdminVoteStatsDAO dao = new AdminVoteStatsDAOImpl(session);
			
			// 총 투표 수 + 증가률
	    	int currentTotalVoteCnt = dao.selVoteCnt();
	    	int previousTotalVoteCnt = dao.selTotalVoteCountByDate(dataRange.getEndDate().minusMonths(1));
	    	
	    	voteStatDTO.setTotalVoteStat(calculatePeriodStat(currentTotalVoteCnt, previousTotalVoteCnt));

	    	// 총 투표 참여자 수 + 증가률
	    	int currentTotalVoteJoinCnt = dao.selVoteJoinCnt();
	    	int previousTotalVoteJoinCnt = dao.selTotalVoteJoinCountByDate(dataRange.getEndDate().minusMonths(1));
	    	
	    	voteStatDTO.setVoteJoinStat(calculatePeriodStat(currentTotalVoteJoinCnt, previousTotalVoteJoinCnt));
	    	
	    	// 총 투표 댓글 수
	    	voteStatDTO.setVoteCommentCnt(dao.selVoteCommentCnt());
	    	
	    	// 진행 중인 투표 수
	    	voteStatDTO.setActiveVoteStat(dao.selActiveVoteStat());
	   
	    	// 월별 투표 참여 추이
	    	voteStatDTO.setMonthlyVoteTrend(dao.selMonthlyVoteTrend(dataRange));
	    	
	    	// 인기 투표 TOP 10
	    	voteStatDTO.setTopVotes(dao.selTopVotes());
		}
		return voteStatDTO;
	}

	@Override
	public AdminInquiryStatDTO getInquiryStat(DateRangeDTO dataRange) {
		AdminInquiryStatDTO inquiryStatDTO = new AdminInquiryStatDTO();
		
		try (SqlSession session = getSqlSession()) {
			
			// 총 문의 수 + 증가률
			
			// 답변 완료된 문의 수 + 증가률
			
			// 처리 중인 문의 수
			
			// 평균 문의 처리 시간(처리일 - 문의 등록일)
			
			// 일별 문의 등록 추이
			
			// 일별 문의 접수
		}
		
		return inquiryStatDTO;
	}
	
	// 날짜 범위를 받아 증가율을 계산
	private PeriodStatDTO calculatePeriodStat(int current, int previous) {

	    PeriodStatDTO dto = new PeriodStatDTO();
	    dto.setCurrentValue(current);
	    dto.setPreviousValue(previous);

	    double rate = 0;
	    if (previous != 0) {
	        rate = ((double)(current - previous) / previous) * 100;
	    }

	    dto.setIncreaseRate(Math.round(rate * 100.0) / 100.0);

	    return dto;
	}
	
	// 현재 날짜 범위를 받아 이전 기간의 날짜 범위를 계산
	private DateRangeDTO getPreviousDateRange(DateRangeDTO current) {

	    LocalDate start = current.getStartDate();
	    LocalDate end = current.getEndDate();

	    long days = ChronoUnit.DAYS.between(start, end);

	    DateRangeDTO previous = new DateRangeDTO();

	    previous.setEndDate(start.minusDays(1));
	    previous.setStartDate(previous.getEndDate().minusDays(days));

	    return previous;
	}
}
