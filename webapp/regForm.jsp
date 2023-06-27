<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Regist Form Page</h1>
<hr>
<form action="regist.jsp" method="post">
	<label>제목 <input type="text" name="title"></label><br>
	<label>내용 <textarea type="text" name="content"></textarea></label><br>
	<label>작성자 <input type="text" name="writer"></label><br>
	<input type="submit" value="등록">
	<input type="reset" value="초기화">
	
</form>
</body>
</html>
