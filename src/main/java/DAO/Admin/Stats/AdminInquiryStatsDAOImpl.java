package DAO.Admin.Stats;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Admin.Stats.DateRangeDTO;
import DTO.Admin.Stats.InquiryStatusStatDTO;
import DTO.Admin.Stats.TrendDTO;

public class AdminInquiryStatsDAOImpl implements AdminInquiryStatsDAO {

	private final SqlSession session;

	public AdminInquiryStatsDAOImpl(SqlSession session) {
        this.session = session;
    }

	// 총 문의 수
	@Override
	public int selTotalInquiryCnt() {
		return session.selectOne("AdminInquiryStats.selTotalInquiryCnt");
	}

	// 기간 내 총 문의 수
	@Override
	public int selTotalInquiryCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminInquiryStats.selTotalInquiryCountByDate", targetDate);
	}

	// 총 완료된 문의 수
	@Override
	public int selCompletedInquiryCnt() {
		return session.selectOne("AdminInquiryStats.selCompletedInquiryCnt");
	}

	// 기간 내 완료된 문의 수
	@Override
	public int selCompletedInquiryCountByDate(LocalDate targetDate) {
		return session.selectOne("AdminInquiryStats.selCompletedInquiryCountByDate", targetDate);
	}

	// 총 처리 중인 문의 수
	@Override
	public int selPendingInquiryCnt() {
		return session.selectOne("AdminInquiryStats.selPendingInquiryCnt");
	}

	// 평균 문의 처리 시간(처리 댓글 등록일 - 문의 등록일)
	@Override
	public double selAvgProcessingTime() {
		return session.selectOne("AdminInquiryStats.selAvgProcessingTime");
	}

	// 1달 내 문의 처리 현황
	@Override
	public InquiryStatusStatDTO selInquiryStatus(DateRangeDTO dataRange) {
		return session.selectOne("AdminInquiryStats.selInquiryStatus", dataRange);
	}

	// 일별 문의 접수 추이
	@Override
	public List<TrendDTO> selDailyReceivedInquiryTrend(DateRangeDTO dataRange) {
		return session.selectList("AdminInquiryStats.selDailyReceivedInquiryTrend", dataRange);
	}
}