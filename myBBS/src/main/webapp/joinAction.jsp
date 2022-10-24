<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 연습</title>
</head>
<body>
	<%
		// 입력한 5개 정보 중 하나라도 누락되면
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			PrintWriter script = response.getWriter();
			
			// join 메소드 실행(쿼리 실행)중 오류 발생 - 중복된 아이디가 존재해 회원가입 실패
			if(result == -1){
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("alert('회원가입 성공')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>