package DAO;

import org.apache.ibatis.session.SqlSession;

import mybatis.DBService;

public class HomeDAOImpl implements HomeDAO {
	private static HomeDAOImpl instance = null;

	public HomeDAOImpl() {}

	public static HomeDAOImpl getInstance() {
		if (instance == null) {
			instance = new HomeDAOImpl();
		}
		return instance;
	}

	private SqlSession getSqlSession() {
		return DBService.getFactory().openSession(false);
	}

	@Override
	public void increaseTodayDau() {
		try (SqlSession sqlSession = getSqlSession()) {
			sqlSession.update("Home.increaseTodayDau");
			sqlSession.commit();
		}
	}

}
