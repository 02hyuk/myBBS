<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--반응형 웹 메타태그-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--bootstrap.css 참조-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>게시판 연습</title>
<style type="text/css">
	a, a.hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		// 세션에 아이디값 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		// 페이지 처리
		int pageNumber = 1; // 기본은 1(페이지)
		if(request.getParameter("pageNumber") != null){
			// 파라미터로 넘어온 페이지 값이 있다면 pageNumber에 저장
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
						<a class="nav-link active" aria-current="page" href="bbs.jsp">게시판</a>
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

	<!--게시판 메인 페이지 영역 시작-->
	<div class="container" style="padding-top: 20px">
		<div class="row border bg-light" style="padding: 5px; border-radius: 10px">
			<table class="table table-hover" style="text-align: center;">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i < list.size(); i++){
				%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>">
						<%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
							+ list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			
			<!--하단 버튼 영역-->
			<div class="row">
				<!--페이징 처리 영역-->
				<div class="btn-group col-md-auto" role="group">
					<%
					// 현재 페이지가 1페이지가 아니면 이전 페이지 이동 버튼 생성
					if(pageNumber != 1) {
					%>
					<a class="btn btn-outline-secondary" href = "bbs.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a>
					<%
						// 다음 페이지가 존재한다면 다음 페이지 이동 버튼 생성
						} if (bbsDAO.isPageExist(pageNumber + 1)) {
					%>
					<a class="btn btn-outline-secondary" href = "bbs.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a>
					<%
						}
					%>
				</div>
				<!--글쓰기 버튼-->
				<div class="col-md-auto">
					<!--글쓰기 버튼 생성-->
					<a class="btn btn-outline-success" href="write.jsp">글쓰기</a>
				</div>
			</div>
		</div>
	</div>
	<!--게시판 메인 페이지 영역 끝-->

	<!--부트스트랩 참조 영역-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>