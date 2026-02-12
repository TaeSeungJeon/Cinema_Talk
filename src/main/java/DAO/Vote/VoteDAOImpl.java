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
			sqlSession.insert("vrecIn", voteRecord);
			sqlSession.commit();
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

	}

	@Override
	public List<VoteResultDTO> getVoteResult(int voteId) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vrecResult", voteId);


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
			return sqlSession.selectList("vregList");


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public VoteRegisterDTO getVoteRegById(int voteId) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("vregOne", voteId);


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
			return sqlSession.selectList("vrecRecordAll");


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
			return sqlSession.selectOne("vrecRecordMemno", vrdto);


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
			sqlSession.insert("vrecUpdate", voteRecord);
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
			return sqlSession.selectList("vregFullList");


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordByVoteId(int voteId) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("vrecListVoteId", voteId);


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}

	@Override
	public VoteRegisterDTO getVoteRegFullById(int voteId) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("vregFullByVoteId", voteId);


		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}
}
