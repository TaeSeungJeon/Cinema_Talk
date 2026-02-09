package DAO.Movie;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import DTO.Movie.PersonDTO;
import mybatis.DBService;

public class PersonDAOImpl implements PersonDAO {
	private SqlSessionFactory factory = DBService.getFactory();
	
	@Override
	public void insertPerson(PersonDTO person) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.PersonDAO.insertPerson", person);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void insertPersonBatch(List<PersonDTO> persons) {
		SqlSession session = factory.openSession();
		try {
			for (PersonDTO person : persons) {
				session.insert("DAO.Movie.PersonDAO.insertPerson", person);
			}
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void mergePerson(PersonDTO person) {
		SqlSession session = factory.openSession();
		try {
			session.insert("DAO.Movie.PersonDAO.mergePerson", person);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public boolean existsPerson(String personId) {
		SqlSession session = factory.openSession();
		try {
			PersonDTO person = session.selectOne("DAO.Movie.PersonDAO.selectPersonById", personId);
			return person != null;
		} finally {
			session.close();
		}
	}

	@Override
	public PersonDTO getPersonById(String personId) {
		SqlSession session = factory.openSession();
		try {
			return session.selectOne("DAO.Movie.PersonDAO.selectPersonById", personId);
		} finally {
			session.close();
		}
	}
}
