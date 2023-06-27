<%@page import="java.sql.Connection"%>
<%@page import="jdbc.DBcon2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Index Page</h1>
<hr>
<a href="regForm.jsp">게시물등록</a>
<a href="boardList.jsp">목록보기</a>

<%
	DBcon2 db = new DBcon2();
	Connection con = db.getConnection();
	
	if(con != null){
		out.print("ok...");
	}else{
		out.print("TT");
	}
%>
</body>
</html>