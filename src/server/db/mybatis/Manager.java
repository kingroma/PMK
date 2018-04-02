package server.db.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import resource.SqlMapConfig;

public class Manager {
	private static Manager INSTANCE;
	
	private SqlSessionFactory factiory;
	private SqlSession sqlSession;
	
	private Manager() {
		initEnv();
	}
	
	private void initEnv() {
		
		factiory = SqlMapConfig.getSqlSession();
	}
	
	public static Manager getInstance() {
		if(INSTANCE == null) {
			INSTANCE = new Manager();
		}
		return INSTANCE;
	}
	
	public void start() {
		try {
			sqlSession = factiory.openSession();
		} catch (Exception e) {
			if(sqlSession!=null) {
				sqlSession.rollback();
			}
		}
	}
	
	public void end() {
		try {
			sqlSession.commit();
			sqlSession.close();
		} catch(Exception e) {
			if(sqlSession!=null) {
				sqlSession.rollback();
			}
		}
		
	}

	public SqlSessionFactory getFactiory() {
		return factiory;
	}

	public void setFactiory(SqlSessionFactory factiory) {
		this.factiory = factiory;
	}

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
}
