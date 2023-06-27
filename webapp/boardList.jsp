<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.DBcon2"%>
<%@page import="vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Board> list = new ArrayList<>();
	//DB에서 목록 데이터를 가져오면 된다.
	//1) 커넥션 객체 얻기
	Connection con = null;
	PreparedStatement pstmt = null;
	DBcon2 db = new DBcon2();
	con = db.getConnection(); 
	
	Statement stmt = con.createStatement();
	//1) 쿼리 실행 하기
	//1) 결과집합 얻기	
	ResultSet rs = stmt.executeQuery("Select * from tbl_board order by bno");
	
	while(rs.next()){
		Board board = new Board();
		board.setBno(rs.getInt("bno"));
		board.setTitle(rs.getString("title"));
		board.setWriter(rs.getString("writer"));
		board.setRegdate(rs.getTimestamp("regdate"));
		board.setModdate(rs.getTimestamp("moddate"));
	
		list.add(board);
	}
	rs.close();
	stmt.close();
	pageContext.setAttribute("list", list);

	/* String sql2 = "SELECT COUNT(*) FROM tbl_reply where bno=?";
	stmt = con.prepareStatement(sql2);
	stmt.setInt(1, bno);
	rs = stmt.executeQuery(sql2); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>list page</h1>
<hr>
	<table border ="1px">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일자</th>
				<th>수정일자</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.bno }</td>
				<td><a href="detail.jsp?bno=${board.bno }" >${board.title }</td>
				<td>${board.writer }</td>
				<td>
  					<fmt:formatDate value="${board.moddate }" pattern="yyyy/MM/dd"></fmt:formatDate>
				</td>
				<td>${board.moddate }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>