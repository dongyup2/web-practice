package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBcon2 {
	//싱글톤 객체 생성하고 인스턴스에 할당
	private static final DBcon2 instance = new DBcon2();
	// 싱글톤 패턴: 기본 생성자를 private으로
	private DBcon2() {
		try {
			// MariaDB JDBC 드라이버 로드
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (Exception e) {
			throw new RuntimeException("DB가 로드되지 않았습니다.");
		}		
	}
	// DBconnectionMrg 인스턴스를 얻기 위한 메서드
	public static DBcon2 getInstance() {
		return instance;
	}
	// 데이터베이스 연결 객체를 반환하는 메서드
	public Connection getConnection() throws SQLException {
		// 데이터베이스 연결 정보 설정 및 연결 객체 생성
		Connection conn = DriverManager.getConnection(
				"jdbc:mariadb://localhost:3306/green02",
				"root",
				"1234"
				);
		return conn;
	}
	 
}
