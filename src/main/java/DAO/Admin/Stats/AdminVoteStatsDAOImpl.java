package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopVoteDTO;
import DTO.Admin.Stats.TrendDTO;

public class AdminVoteStatsDAOImpl implements AdminVoteStatsDAO {

	private final SqlSession session;

	public AdminVoteStatsDAOImpl(SqlSession session) {
        this.session = session;
    }
	
	// 총 투표 수
	@Override
	public int selVoteCnt() {
		return session.selectOne("AdminVoteStats.selVoteCnt");
	}

	// 특정 날짜 기준 총 투표 수
	@Override
	public int selTotalVoteCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminVoteStats.selTotalVoteCountByDate", targetDate);
	}

	// 총 투표 참여 수
	@Override
	public int selVoteJoinCnt() {
		return session.selectOne("AdminVoteStats.selVoteJoinCnt");
	}

	// 특정 날짜 기준 총 투표 참여 수
	@Override
	public int selTotalVoteJoinCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminVoteStats.selTotalVoteJoinCountByDate", targetDate);
	}

	// 총 투표 댓글 수
	@Override
	public int selVoteCommentCnt() {
		return session.selectOne("AdminVoteStats.selVoteCommentCnt");
	}

	// 현재 진행 중인 투표 수
	@Override
	public int selActiveVoteStat() {
		return session.selectOne("AdminVoteStats.selActiveVoteStat");
	}

	// 월별 투표 참여 추이
	@Override
	public List<TrendDTO> selMonthlyVoteTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminVoteStats.selMonthlyVoteTrend", dataRange);
	}

	// 인기 투표 TOP 10
	@Override
	public List<TopVoteDTO> selTopVotes() {
		return session.selectList("AdminVoteStats.selTopVotes");
	}

}