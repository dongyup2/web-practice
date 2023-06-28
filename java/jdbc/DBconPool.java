package jdbc;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DBconPool {
	private static Connection con;
	
	public static Connection getConnection() {
		try {
			InitialContext initctx = new InitialContext();
			Context ctx = (Context)initctx.lookup("java:comp/env");
			DataSource source = (DataSource) ctx.lookup("dbcp.mydb");
			
			//커넥션 풀을 통해 커넥션 객체 얻기
			con = source.getConnection();			
		} catch (Exception e) {
			e.printStackTrace();	
		}
		
		return con;
	}
}
