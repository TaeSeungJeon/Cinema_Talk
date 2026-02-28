package DAO.Member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import DTO.Member.MemberDTO;
import mybatis.DBService;

public class MemberDAOImpl implements MemberDAO {
	
	//정적변수
	private static MemberDAOImpl instance = null;
	
	//기본생성자
	public MemberDAOImpl() {}
	
	//DAOImpl 객체 생성해서 반환
	public static MemberDAOImpl getInstance() {
		if(instance ==  null) {
			instance = new MemberDAOImpl();
		}
		return instance;
	}//getInstance()
	
	//mybatis 커리문 수행 SqlSession 반환
	private SqlSession getSqlSession() {
		return DBService.getFactory().openSession(false); 
		//수동 commit 모드
	}//getSqlSession()

	@Override
	public void insertMember(MemberDTO member) {
		SqlSession sqlSession = getSqlSession();
		
		try {
			sqlSession.insert("Member.registerIn", member);
			sqlSession.commit(); //수동 커밋
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//insertMember() -> 회원정보 저장

	@Override
	public MemberDTO idCheck(String memId) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("idCheck", memId);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//idCheck() -> 아이디 중복 검색

	@Override
	public MemberDTO loginCheck(String id) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("loginCheck", id);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//loginCheck() -> 입력한 아이디로 로그인 인증

	@Override
	public MemberDTO getMemberInfo(Integer memNo) {
		SqlSession sqlSession = null;

		try{
			sqlSession = getSqlSession();
			return sqlSession.selectOne("Member.getMemberInfo", memNo);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

	}//loginCheck() -> 입력한 아이디로 로그인 인증

	@Override
	public MemberDTO findId(MemberDTO mdto) {
		SqlSession sqlSession = null;

		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("findId", mdto);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}

	}//findId() -> 입력받은 이름과 전화번호를 기준으로 아이디 찾기

	@Override
	public MemberDTO findByIdAndPhone(String memId, String memPhone) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			
			Map<String, Object> param = new HashMap<>();
			param.put("memId", memId);
			param.put("memPhone", memPhone);
			
			return sqlSession.selectOne("findByIdAndPhone", param);
		}finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}//findByIdAndPhone() -> 입력받은 아이디와 전화번호를 기준으로 아이디 찾기

	@Override
	public int updatePwd(MemberDTO mdto) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			int a = sqlSession.update("updatePwd", mdto);
			sqlSession.commit();
			return a;
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//updatePwd() -> 암호화된 임시비밀번호로 업데이트

	@Override
	public int phoneCheck(String memPhone) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("phoneCheck", memPhone);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//phoneCheck() -> 전화번호 중복 체크

	@Override
	public int emailCheck(String memEmail) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("emailCheck", memEmail);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//emailCheck() -> 이메일 중복 체크
	
	public int updateLastLogin(String memId) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			int result = sqlSession.update("updateLastLogin", memId);
			sqlSession.commit();
			return result;
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//updateLastLogin() -> 마지막 로그인 날짜 업데이트
	
	@Override
	public int withdrawMember(int memNo){
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			Map<String, Object> param = new HashMap<>();
			param.put("memNo", memNo);
			param.put("memState", 3); // 3: 탈퇴 상태
			int result = sqlSession.update("Member.updateMemberState", param);
			sqlSession.commit();
			return result;
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}//withdrawMember() -> 회원 탈퇴 (상태값 3으로 변경)

	@Override
	public String findProfilePhotoPath(int memNo) {
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("Member.findProfilePhotoPath", memNo);
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}//findProfilePhotoPath() -> 프로필 사진 상대경로 조회

	@Override
	public int updateProfilePhotoPath(int memNo, String relativePath) {
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSession();
			Map<String, Object> param = new HashMap<>();
			param.put("memNo", memNo);
			param.put("memProfilePhoto", relativePath);
			int result = sqlSession.update("Member.updateProfilePhotoPath", param);
			sqlSession.commit();
			return result;
		} finally {
			if (sqlSession != null) {
				sqlSession.close();
			}
		}
	}//updateProfilePhotoPath() -> 프로필 사진 경로 업데이트

	@Override
	public List<MemberDTO> getMemberList() {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectList("getMemberList");	
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//getMemberList() -> 회원 목록 조회

}
