package Service.Admin;

import org.apache.ibatis.session.SqlSession;

import DAO.Admin.AdminNoticeDAO;
import DAO.Admin.AdminNoticeDAOImpl;
import mybatis.DBService;

public class AdminNoticeServiceImpl {
	private static AdminNoticeServiceImpl instance = null;
    
    private final AdminNoticeDAO dao = AdminNoticeDAOImpl.getInstance();

    private AdminNoticeServiceImpl() {}

    public static AdminNoticeServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdminNoticeServiceImpl();
		}
		return instance;
	}
    
    private SqlSession getSqlSession() {		
		return DBService.getFactory().openSession(false);
	}
}	
