<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 연습</title>
</head>
<body>
	<%
		// 세션에 아이디값 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	<!--내비게이션 바 시작-->
	<nav>
		<div>
			<!--나중에 부트스트랩으로 반응형 페이지로 만들 예정-->
			<a>JSP 게시판 웹 사이트</a>
		</div>
		<div>
			<ul>
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				// 세션에 아이디가 등록되지 않은 경우(비로그인)
				if(userID == null) {
			%>
			<ul>
				<li>
					<a href="#" role="button">접속하기</a>
					<ul>
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인하여 세션에 값이 등록된 경우
				} else {
			%>
			<ul>
				<li>
					<a href="#" role="button">회원관리</a>
					<ul>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!--내비게이션 바 끝-->
	<!--게시판 글쓰기 양식 영역 시작-->
	<div class="container">
		<div>
			<form method="post" action="writeAction.jsp">
				<table style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<!--글쓰기 버튼 생성-->
				<input type="submit" value="글쓰기">
			</form>
		</div>
	</div>
	<!--게시판 글쓰기 양식 영역 끝-->
</body>
</html>