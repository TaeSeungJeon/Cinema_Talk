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
			sqlSession.insert("Member.register_in", member);
			sqlSession.commit(); //수통 커밋
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
	}//insertMember() -> 회원정보 저장

	@Override
	public MemberDTO idCheck(String mem_id) {
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSession();
			return sqlSession.selectOne("Member.idCheck", mem_id);
		}finally {
			if(sqlSession != null) {
				sqlSession.close();
			}
		}
		
	}//idCheck() -> 아이디 중복 검색
	
	
}
