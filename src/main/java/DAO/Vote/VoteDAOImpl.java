package DAO.Vote;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import DTO.Vote.VoteOptionDTO;
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

	@Override
	public boolean insertVoteRegister(VoteRegisterDTO vdto) {
		SqlSession sqlSession = null;
		boolean isSuccess = false;

		try {
			sqlSession = getSqlSession();
			sqlSession.insert("vregIn", vdto);
			
			int generatedId = vdto.getVoteId();
			for(VoteOptionDTO opt : vdto.getOptionList()) {
	            opt.setVoteId(generatedId); // 모든 옵션에 부모 ID 세팅
	        }
			
			sqlSession.insert("voptIn", vdto.getOptionList());
			
			sqlSession.commit();
			isSuccess = true;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

		return isSuccess;
	}

	@Override
	public boolean editVoteRegister( VoteRegisterDTO vdto) {
		SqlSession sqlSession = null;
		boolean isSuccess = false;

		try {
			sqlSession = getSqlSession();
			sqlSession.update("vregUpdate", vdto);
			sqlSession.delete("voptDel", vdto);
			for(VoteOptionDTO opt : vdto.getOptionList()) {
	            opt.setVoteId(vdto.getVoteId()); // 모든 옵션에 부모 ID 세팅
	        }
			
			sqlSession.insert("voptIn", vdto.getOptionList());
			
			sqlSession.commit();
			isSuccess = true;
		} catch (Exception e){
			if(sqlSession != null) {
				sqlSession.rollback();//예외 발생하면 롤백처리
				
			}
			isSuccess = false;
			e.printStackTrace();
		}
		
		finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

		return isSuccess;
	}

	@Override
	public boolean deleteVoteRegister(VoteRegisterDTO vdto) {
		SqlSession sqlSession = null;
		boolean isSuccess = false;

		try {
			sqlSession = getSqlSession();
			sqlSession.delete("vregDel", vdto);
			
			sqlSession.commit();
			isSuccess = true;
		} finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

		return isSuccess;
	}
}
