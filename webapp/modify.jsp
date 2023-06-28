<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="jdbc.DBconPool"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
	//상세보기 페이지에서 수정버튼을 클릭하면..
	//상세보기 폼의 수정가능한 데이터들이 파라미터로 넘어온다.
	//1. 파라미터 받기 (title, content, bno)
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String _bno = request.getParameter("bno");
	int bno = Integer.parseInt(_bno);
	
	//2. DB접속 + 쿼리 실행
	String sql = "UPDATE tbl_board SET title = ?, content = ?, moddate = now() WHERE bno = ?";
	Connection con = DBconPool.getConnection();
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setString(1, title);
	stmt.setString(2, content);
	stmt.setInt(3, bno);
	
	int result = stmt.executeUpdate();
	
	
	   stmt.close();
	   con.close();
	if(result == 1){
		response.sendRedirect("boardList.jsp?m=1");
	}else{
		response.sendRedirect("datail.jsp?bno=" + bno + "&mode=0");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>수정 modify</title>
</head>
<body>
<script>
  function submit() {
    var modifyForm = document.getElementById("modifyForm");
    var title = document.getElementById("title");
    var content = document.getElementById("content");

    if (title.value == "") {
      alert("제목을 입력해주세요.");
      title.focus();
      return false;
    }

    if (content.value == "") {
      alert("내용을 입력해주세요.");
      content.focus();
      return false;
    }
    modifyForm.submit();
  }

  function cancel() {
    history.back();
  }
</script>

</body>
</html>