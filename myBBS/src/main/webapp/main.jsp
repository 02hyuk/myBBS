<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--반응형 웹 메타태그-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--bootstrap.css 참조-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
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
	<nav class="navbar navbar-expand-lg bg-light border-bottom">
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			<!--버튼의 역할: 브라우저 창 작을 때 메뉴 표시하는 버튼-->
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
			<!--브라우저창이 작을 경우 위의 버튼이 눌렸을 떄 표시되는 내용들(collapse)-->
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="main.jsp">메인</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="bbs.jsp">게시판</a>
					</li>
				<%
					// 세션에 아이디가 등록되지 않은 경우(비로그인)
					if(userID == null) {
				%>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							접속하기
						</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="login.jsp">로그인</a></li>
							<li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				<%
					// 로그인하여 세션에 값이 등록된 경우
					} else {
				%>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							회원관리
						</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				<%
					}
				%>
				</ul>
			</div>
		</div>
	</nav>
	<!--내비게이션 바 끝-->

	<!--메인 페이지 영역 시작-->
	<div class="container">
		<div class="row" style="padding: 50px 200px 50px 200px">
			<div class="container bg-light border" style="padding: 40px; border-radius: 10px;">
				<h1>게시판 사이트</h1>
				<p>
					<br>jsp를 이용해 간단한 게시판 사이트를 제작한 프로젝트입니다. 이 프로젝트를 통해 처음 부트스트랩을 접해보는데
					코드만 조금 붙여 넣어도 사이트가 예쁘게 구성되는 걸 보니 기분이 좋습니다. 앞으로는 스프링부트를 공부해 볼 예정입니다.
				</p>
				<img src="images/main_samsoon.jpg" alt="samsoon" width="150" height="150">
			</div>
		</div>
	</div>
	<!--메인 페이지 영역 끝-->

	<!--부트스트랩 참조 영역-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>