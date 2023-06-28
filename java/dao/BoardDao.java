package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import jdbc.DBconPool;
import vo.Board;

public class BoardDao {
	//등록
	DBconPool dBcon2 = new DBconPool();
	public void regist(Board board) {
		String sql = "INSERT INTO tbl_board (title, content, writer, regdate, moddate) VALUES (?, ?, ?, NOW(), ?)";
		
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = dBcon2.getConnection();
			stmt = con.prepareStatement(sql);
			
			stmt.setString(1, board.getTitle());
			stmt.setString(2, board.getContent());
			stmt.setString(3, board.getWriter());
			stmt.setTimestamp(4, board.getRegdate());
			stmt.setTimestamp(5, board.getModdate());
			stmt.executeUpdate();
			
		} catch (Exception e) {
		}
	}
	
	//수정
	
	//삭제
	public void delete(Board board) {
		String sql = "DELETE FROM tbl_board WHERE bno =? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = dBcon2.getConnection();
			stmt = con.prepareStatement(sql);
		} catch (Exception e) {
		}
	}
	//개인조회
	
	//전체조회
	
	//초그인
}
