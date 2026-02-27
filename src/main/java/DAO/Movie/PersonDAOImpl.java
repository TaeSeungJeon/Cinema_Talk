package DAO.Movie;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import DTO.Movie.PersonDTO;
import mybatis.DBService;

public class PersonDAOImpl implements PersonDAO {
	public static PersonDAOImpl instance = null;
	
	public PersonDAOImpl() {}
	
	public static PersonDAOImpl getInstance() {
		if(instance == null) {
			instance = new PersonDAOImpl();
		} 
		return instance;
	}
	
	private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
	
	@Override
	public void insertPerson(PersonDTO person) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.PersonDAO.insertPerson", person);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}
	
	@Override
	public void insertPersonBatch(List<PersonDTO> persons) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			for (PersonDTO person : persons) {
				session.insert("DAO.Movie.PersonDAO.insertPerson", person);
			}
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public void mergePerson(PersonDTO person) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			session.insert("DAO.Movie.PersonDAO.mergePerson", person);
			session.commit();
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public boolean existsPerson(int personId) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			PersonDTO person = session.selectOne("DAO.Movie.PersonDAO.selectPersonById", personId);
			return person != null;
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public PersonDTO getPersonById(int pid) {
		SqlSession session = null;
		try {
			session = getSqlSession();
			return session.selectOne("DAO.Movie.PersonDAO.selectPersonById", pid);
		} finally {
			if(session != null) {
				session.close();
			}
		}
	}

	@Override
	public List<PersonDTO> searchPerson(String keyword) {
		
		try (SqlSession sqlSession = getSqlSession()) {
	        return sqlSession.selectList("DAO.Movie.PersonDAO.searchPerson", keyword);
	    } catch (RuntimeException e) {
	        throw new RuntimeException("DB Error - searchPerson", e);
	    }
	}

}
