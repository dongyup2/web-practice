<%@page import="jdbc.DBconPool"%>
<%@page import="vo.Reply"%>
<%@page import="vo.Board"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<%
String _bno = request.getParameter("bno");
	int bno = Integer.parseInt(_bno);
	
	String sql = "SELECT * FROM tbl_board WHERE bno = ?";
	
	Connection con = DBconPool.getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, bno);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	Board board = new Board();
	board.setBno(rs.getInt("bno"));
	board.setTitle(rs.getString("title"));
	board.setContent(rs.getString("content"));
	board.setWriter(rs.getString("writer"));
	board.setRegdate(rs.getTimestamp("regdate"));
	board.setModdate(rs.getTimestamp("moddate"));
	
	pageContext.setAttribute("board", board);
	rs.close();
	pstmt.close();
	
	String reply_sql="SELECT * FROM tbl_reply WHERE bno=?";
	pstmt = con.prepareStatement(reply_sql);
	pstmt.setInt(1, bno);
	rs = pstmt.executeQuery();
	
	/* while(rs.next()){
		Reply reply = new Reply();
		reply.setBno(rs.getInt("bno"));
		reply.setRno(rs.getInt("rno"));
		reply.setComment(rs.getString("comment"));
		reply.setWriter(rs.getString("writer"));
		reply.setRegdate(rs.getString("regdate"));
	//댓글 목록 가져오기
	} */
%>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
</head>
<body>
<h1>detail Page</h1>
<hr>
	<form action="modify.jsp" method="POST">
	번호 <input type="text" name="bno" id="" value="${board.bno }" readonly> <br>
	제목 <input type="text" name="title" id="" value="${board.title }"> <br>
	내용 <textarea name="content"> ${board.content} </textarea> <br>
	작성자 <input type="text" name="writer" id="" value="${board.writer }" readonly> <br>
	등록일자 <input type="text" name="regdate" id="" value="${board.regdate }" readonly> <br>
	수정일자 <input type="text" name="moddate" id="" value="${board.moddate }" readonly> <br>
			<input type="submit" value="수정">&nbsp;&nbsp;
			<input type="button" value="삭제" onclick="delBoard()">
	</form>
	<hr>
<h3>댓글 작성하기</h3>
<input type="text" name="comment">
<input type="button" value="댓글 등록" onclick="regReply()">
<div id="demo"></div>
<hr>
<h3>댓글 목록</h3>
	<table border="1">
		<tbody id="tbody">
		<c:forEach var="reply" items="${replyList }" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${replyList.comment}</td>
				<td>${replyList.writer}</td>
				<td>${replyList.regdate}</td>
				<td>X</td>
			<tr>
		</c:forEach>
		</tbody>
	</table>
<script>
	const txt_bno = document.querySelector("input[name='bno']");
	const txt_writer = document.querySelector("input[name='writer']");	
	const txt_comment = document.querySelector("input[name='comment']");
	const tbody = document.querySelector("#tbody");
	
	function delBoard() {
		// 게시물 번호를 게시물 삭제기능을 수행하는 페이지로 보내기
		location.href="deleteBoard.jsp?bno=" + txt_bno.value;
	}
	
	function regReply(){
		//댓글을 등록시키는 함수. 댓글을 가져와 db에 넣어준다.
		let bno = txt_bno.value;
		let comment = txt_comment.value;
		let writer = txt_writer.value;
				
		const queryString = "bno="+bno+"&comment="+comment+"&writer="+writer;
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			document.getElementById("demo").innerHTML = this.responseText;
			txt_comment.value=""; // 댓글 작성 텍스트 박스 초기화하기
			getReplyList();
		}
		xhr.open("POST", "registReply.jsp", true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send(queryString);
		
	}
	
	function getReplyList(){
		
		const xhr = new XMLHttpRequest();
		xhr.onload = function(){
			// 댓글 테이블 초기화
			tbody.innerHTML = "";
			// 서버로부터 데이터 받기 
			 let jstr = this.responseText; // 댓글목록(텍스트자료 - js 객체로 변환가능한 문자열-json)
			 let replyList = JSON.parse(jstr); // 
			 for (let i = 0; i < replyList.length; i++) {
				// 댓글 테이블에 데이터를 차례로 넣어줘야합니다
				tbody.innerHTML += "<tr>"
								+ "<td>" + (i+1) + "</td>"
								+ "<td>" + replyList[i].comment + "</td>"
								+ "<td>" + replyList[i].writer + "</td>"
								+ "<td>" + replyList[i].regdate + "</td>"
								+ "<td>X</td>"
								+ "</tr>"
			}
		}
		// 서버로 요청보내기
		xhr.open("GET", "replyList.jsp?bno=" + txt_bno.value, true);
		// 실행하기
		xhr.send();
		
	}
	
</script>


</body>
</html>
