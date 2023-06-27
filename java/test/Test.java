package test;

import java.sql.Connection;

import jdbc.DBcon2;

public class Test {
	public static void main(String[] args) {
		DBcon2 db = new DBcon2();
		Connection con = db.getConnection();
		
		if(con != null) {
			System.out.println("db 연결..ok");
		}else {
			System.out.println("ㅠㅠ");
		}
	}
}
