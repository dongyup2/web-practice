<%@page import="vo.Board"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="jdbc.DBcon2"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String _bno = request.getParameter("bno");
	int bno = Integer.parseInt(_bno);
	
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	DBcon2 db = new DBcon2();
	con = db.getConnection(); 
	
	String sql = "select * from tbl_board where bno = ?";
	pstmt = con.prepareStatement(sql);
	//1) 쿼리 실행 하기
	//1) 결과집합 얻기	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		Board board = new Board();
		board.setBno(rs.getInt("bno"));
		board.setTitle(rs.getString("title"));
		board.setWriter(rs.getString("writer"));
		board.setRegdate(rs.getTimestamp("regdate"));
		board.setModdate(rs.getTimestamp("moddate"));
	
	pageContext.setAttribute("board", board);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Detail Page</h1>
<hr>
<form action="regist.jsp" method="post">
	<label> <input type="text" name="title" value="${board.bno }"></label><br>
	<label> <input type="text" name="title" value="${board.title }"></label><br>
	<label><textarea type="text" name="content" value="${board.content }"></textarea></label><br>
	<label><input type="text" name="writer" value="${board.writer }"></label><br>
	<label><input type="text" name="writer" value="${board.regdate }"></label><br>
	<label><input type="text" name="writer" value="${board.moddate }"></label><br>
	<input type="submit" value="수정">
	<input type="submit" value="삭제">
</form>
</body>
</html>