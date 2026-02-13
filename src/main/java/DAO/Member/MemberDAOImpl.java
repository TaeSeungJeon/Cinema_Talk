package DAO.Member;

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
			return sqlSession.selectOne("Member.idCheck", memId);
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
			return sqlSession.selectOne("Member.loginCheck", id);
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


}
