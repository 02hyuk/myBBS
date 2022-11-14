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
						<a class="nav-link" href="main.jsp">메인</a>
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

    <!--회원가입 양식-->
    <div class="container" style="padding-top: 30px">
            <div class="row bg-light border" style="padding: 50px 70px 20px 70px; border-radius: 10px;">
                <div class="col-12">
                    <form method="post" action="joinAction.jsp">
                        <h3 style="text-align: center" class="mb-4">회원가입 화면</h3>
						<div class="mb-4">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						</div>
						<div class="mb-4">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<div class="mb-4">
							<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
						</div>
						<div style="text-align: center">
							<div class="form-check-inline mb-4">
								<input class="form-check-input" type="radio" id="male" name="userGender" value="남자">
								<label class="form-check-label" for="male">
									남자
								</label>
							</div>
							<div class="form-check-inline mb-4">
								<input class="form-check-input" type="radio" id="female" name="userGender" value="여자">
								<label class="form-check-label" for="female">
									여자
								</label>
							</div>
						</div>
						<div class="mb-5">
							<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
						</div>
						<div class="mb-1">
							<input type="submit" class="btn btn-outline-primary form-control" value="회원가입">
						</div>
                    </form>
                </div>
            </div>
        </div>

	<!--부트스트랩 참조 영역-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>