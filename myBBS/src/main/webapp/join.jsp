<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 연습</title>
</head>
<body>
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
			<ul>
				<li>
					<a href="#" role="button">접속하기</a>
					<ul>
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<!--내비게이션 바 끝-->

    <!--회원가입 양식-->
    <div class="container">
        <div>
            <div>
                <form method="post" action="joinAction.jsp">
                    <h3 style="text-align: center">회원가입 화면</h3>
                    <div>
                        <input type="text" placeholder="아이디" name="userID" maxlength="20">
                    </div>
                    <div>
                        <input type="password" placeholder="비밀번호" name="userPassword" maxlength="20">
                    </div>
					<div>
                        <input type="text" placeholder="이름" name="userName" maxlength="20">
                    </div>
					<div style="text-align:center">
                        <div>
							<label>
								<input type="radio" name="userGender" value="남자">남자
							</label>
							<label>
								<input type="radio" name="userGender" value="여자">여자
							</label>
						</div>
                    </div>
					<div>
                        <input type="email" placeholder="이메일" name="userEmail" maxlength="20">
                    </div>
                    <input type="submit" value="회원가입">
                </form>
            </div>
        </div>
    </div>
</body>
</html>