package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.*;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.Stats.AdminMemberStatDTO;
import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopMemberDTO;
import DTO.Admin.Stats.TrendDTO;
import DTO.Movie.Recommend.MovieRecResponse;
import lombok.extern.slf4j.Slf4j;
import mybatis.DBService;

@Slf4j
public class AdminMemberStatsDAOImpl implements AdminMemberStatsDAO {

	private final SqlSession session;

	public AdminMemberStatsDAOImpl(SqlSession session) {
        this.session = session;
    }

	// 기간 내 신규 회원 수
	@Override
	public int selNewMemberCntByRange(DateRangeDTO dataRange) {
		return session.selectOne("AdminSummaryStats.selNewMemberCntByRange", dataRange);
	}

	// 기간 내 신규 게시글 수
	@Override
	public int selNewBoardCntByRange(DateRangeDTO dataRange) {
		return session.selectOne("AdminSummaryStats.selNewBoardCntByRange", dataRange);
	}

	// 기간 내 신규 투표 참여 수
	@Override
	public int selNewVoteJoinCntByRange(DateRangeDTO dataRange) {
		return session.selectOne("AdminSummaryStats.selNewVoteJoinCntByRange", dataRange);
	}

	// 기간 내 신규 문의 수
	@Override
	public int selNewInquiryCntByRange(DateRangeDTO dataRange) {
		return session.selectOne("AdminSummaryStats.selNewInquiryCntByRange", dataRange);
	}

	// 일별 방문자 추이
	@Override
	public List<TrendDTO> selDailyVisitorTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminSummaryStats.selDailyVisitorTrend", dataRange);
	}

	// 일별 신규 회원 추이
	@Override
	public List<TrendDTO> selDailyNewMemberTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminSummaryStats.selDailyNewMemberTrend", dataRange);
	}
	
	// 전체 회원 수
	@Override
	public int selMemberCnt() {
		return session.selectOne("AdminMemberStats.selMemberCnt");
	}
	
	// 특정 날짜 기준 총 회원 수
	@Override
	public int selTotalMemberCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminMemberStats.selTotalMemberCountByDate", targetDate);
	}

	// 특정 기간 내 신규 회원 수
	@Override
	public int selNewMemberCnt(DateRangeDTO dataRange) {
		return session.selectOne("AdminMemberStats.selNewMemberCnt", dataRange);
	}

	// 휴면 회원 수
	@Override
	public int selSleepMemberCnt() {
		return session.selectOne("AdminMemberStats.selSleepMemberCnt");
	}

	// 탈퇴 회원 수
	@Override
	public int selOutMemberCnt() {
		return session.selectOne("AdminMemberStats.selOutMemberCnt");
	}

	// 신규 회원 추이
	@Override
	public List<TrendDTO> selNewMemberTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminMemberStats.selNewMemberTrend", dataRange);
	}

	// 게시글 TOP 10 회원
	@Override
	public List<TopMemberDTO> selTopBoardMembers() {
		return session.selectList("AdminMemberStats.selTopBoardMembers");
	}

	// 댓글 TOP 10 회원
	@Override
	public List<TopMemberDTO> selTopCommentMembers() {
		return session.selectList("AdminMemberStats.selTopCommentMembers");
	}


}