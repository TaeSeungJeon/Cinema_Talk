package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.TopBoardDTO;
import DTO.Admin.Stats.TrendDTO;

public class AdminBoardStatsDAOImpl implements AdminBoardStatsDAO {

	private final SqlSession session;

	public AdminBoardStatsDAOImpl(SqlSession session) {
        this.session = session;
    }

	// 총 게시글 수
	@Override
	public int selBoardCnt() {
		return session.selectOne("AdminBoardStats.selBoardCnt");
	}

	// 특정 날짜 기준 총 게시글 수
	@Override
	public int selTotalBoardCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminBoardStats.selTotalBoardCountByDate", targetDate);
	}

	// 총 댓글 수
	@Override
	public int selCommentCnt() {
		return session.selectOne("AdminBoardStats.selCommentCnt");
	}

	// 특정 날짜 기준 총 댓글 수
	@Override
	public int selTotalCommentCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminBoardStats.selTotalCommentCountByDate", targetDate);
	}

	// 총 좋아요 수
	@Override
	public int selLikeCnt() {
		return session.selectOne("AdminBoardStats.selLikeCnt");
	}

	// 총 조회 수
	@Override
	public int selViewCnt() {
		return session.selectOne("AdminBoardStats.selViewCnt");
	}

	// 월별 게시글 추이
	@Override
	public List<TrendDTO> selDailyNewBoardTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminBoardStats.selMonthlyBoardTrend", dataRange);
	}

	// 인기 게시글 TOP 10
	@Override
	public List<TopBoardDTO> selTopBoards() {
		return session.selectList("AdminBoardStats.selTopBoards");
	}

}