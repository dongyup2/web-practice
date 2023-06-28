<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="jdbc.DBconPool"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
	String del_param = request.getParameter("d");
		if(del_param != null){
%>	
	<script>
		alert("게시물이 삭제되었습니다.");
	</script>
<%
}
	//1. DB에서 테이블자료를 가져오기.
	//1-1 객체얻기
	
	Connection con = DBconPool.getConnection();
	Statement stmt = con.createStatement();
	//ResultSet rs = null;
	//1-2 쿼리실행
	String sql = "SELECT b.bno, b.title, b.content, b.writer, b.regdate, b.moddate, r.replyCnt FROM tbl_board b LEFT JOIN v_reply r ON b.bno = r.bno ORDER BY bno DESC;";
	//rs = stmt.executeQuery(sql);
	ResultSet rs = stmt.executeQuery(sql);
	
	ArrayList<Board> list = new ArrayList<>();
	
	while(rs.next()){
		Board board = new Board();
		board.setBno(rs.getInt("bno"));
		board.setTitle(rs.getString("title"));
		board.setWriter(rs.getString("writer"));
		board.setRegdate(rs.getTimestamp("regdate"));
		board.setModdate(rs.getTimestamp("moddate"));
		board.setReplyCnt(rs.getInt("replyCnt"));
		
		list.add(board);
	}
	rs.close();
	stmt.close();
	
	//저장
	pageContext.setAttribute("list", list);
	
	String sql2 = "SELECT COUNT(*) FROM tbl_reply WHERE bno=?" ;
	//stmt = con.prepareStatement(sql2);
	//stmt.setInt(1, bno);
	//rs = stmt.executeQuery();
%>
<html>
<head>
<meta charset="UTF-8">
<title>getList DB목록을 가져와 조회한다.</title>
</head>
<body>
<h1>DB에서 자료를 가져와 조회하기</h1>
<hr>
<table border="1">
	<thead>
		<tr>
			<th>번호</th><th>제목</th><th>작성자</th><th>작성일자</th><th>수정일자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${list }">
		<tr>
			<td>${ board.bno}</td>
			<td><a href="detail.jsp?bno=${ board.bno}"> ${ board.title} (${board.replyCnt })</a></td>
			<td>${ board.writer}</td>
			<td>
				<fmt:formatDate value="${ board.regdate}" pattern="yyyy/MM/dd HH:mm:ss" />
			</td>
			<td>
				<fmt:formatDate value="${ board.moddate}" pattern="yyyy/MM/dd HH:mm:ss" />
			</td>
		</tr>
		</c:forEach>
	</tbody>
	
	
</table>
<script>
	const txt_bno = document.querySelector("input[name='bno']");
	const txt_writer = document.querySelector("input[name='writer']")
	const txt_comment = document.querySelector("input[name='comment']");
	
	function delBoard(){
		location.href= "deleteBoard.jsp?bno" + txt_bno.value;
	}
	
	function regReply(){
		let bno = txt_bno.value;
		let comment = txt_comment.value;
		let writer = txt_writer.value;
		const queryString = "bno=" + bno + "&comment=" + comment + "&writer=" + writer;
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			this.responseTest;
		}
		xhr.open("POST","registReply.jsp", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send();	
	}
	
	
</script>
</body>
</html>