<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.DBcon2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //등록폼에서 넘어오는 자료를 받아서 DB에 넣는 역할]
    //1. 파라미터 받기
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String writer = request.getParameter("writer");
    Connection con = null;
    PreparedStatement pstmt = null;
    String sql = null;
    int result = 0;
    //2. DB 넣기
    DBcon2 db = new DBcon2();
    con = db.getConnection();
    //-- 1) 커넥션객체 얻기
    sql = "insert into tbl_board(title, content, writer,regdate) values(?,?,?,NOW())";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, writer);
    //-- 2) 쿼리 실행 객체를 사용
    result = pstmt.executeUpdate();
    pstmt.close();
    con.close();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 등록 결과</title>
</head>
<body>
    <% if (result > 0) { %>
        <h3>작성된 글이 성공적으로 등록되었습니다.</h3> 
        <a href="index.jsp">게시판으로 돌아가기</a>
    <% } else { %>
        <h3>게시물 등록에 실패했습니다.</h3> 
        <a href="regForm.jsp">다시 시도하기</a>
    <% } %>
</body>
</html>
