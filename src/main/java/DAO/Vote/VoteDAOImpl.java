package DAO.Vote;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;
import mybatis.DBService;

public class VoteDAOImpl implements VoteDAO {

	public static VoteDAOImpl instance = null;

	public VoteDAOImpl() {}

	public static VoteDAOImpl getInstance() {
		if(instance == null) {
			instance = new VoteDAOImpl();
			return instance;
		} else {
			return instance;
		}
	}

	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}

	@Override
	public void insertVoteRecord(VoteRecordDTO voteRecord) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			sqlSession.insert("vrec_in", voteRecord);
			sqlSession.commit();
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

	}

	@Override
	public List<VoteResultDTO> getVoteResult(int vote_id) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vrec_result", vote_id);


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegList() {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vreg_list");


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public VoteRegisterDTO getVoteRegById(int vote_id) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("vreg_one", vote_id);


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordList() {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vrec_record_all");


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public VoteRecordDTO getVoteRecordByMemNo(VoteRecordDTO vrdto) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("vrec_record_memno", vrdto);


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public void updateVoteRecord(VoteRecordDTO voteRecord) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			sqlSession.insert("vrec_update", voteRecord);
			sqlSession.commit();
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
		
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegFullList() {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vreg_full_list");


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}
}
