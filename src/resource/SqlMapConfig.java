package resource;

import java.io.File;
import java.io.Reader;

import org.apache.ibatis.io.Resources;

import org.apache.ibatis.session.SqlSessionFactory;

import org.apache.ibatis.session.SqlSessionFactoryBuilder;


public class SqlMapConfig {
	private static SqlSessionFactory sqlSession;
	
	static {
		String resource = "resource/Configuration.xml";
		File file = new File(resource);
		try {

			Reader reader = Resources.getResourceAsReader(resource);

			sqlSession = new SqlSessionFactoryBuilder().build(reader);

			reader.close();

			Class[] mapper = {
					server.db.mapper.Mapper.class,
					};

			for(Class m : mapper){

				sqlSession.getConfiguration().addMapper(m); 

			}

			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SqlMapConfig Error ");

		}

	}
	public static SqlSessionFactory getSqlSession() {

		return sqlSession;

	}
}