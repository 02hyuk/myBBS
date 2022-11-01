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
<title>게시판 연습</title>
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
	<!--게시판 메인 페이지 영역 시작-->
	<div class="container">
		<div>
			<table>
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
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
						<%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
							+ list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			
			<!--페이징 처리 영역-->
			<%
				// 현재 페이지가 1페이지가 아니면 이전 페이지 이동 버튼 생성
				if(pageNumber != 1) {
			%>
			<a href = "bbs.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a>
			<%
				// 다음 페이지가 존재한다면 다음 페이지 이동 버튼 생성
				} if (bbsDAO.isPageExist(pageNumber + 1)) {
			%>
			<a href = "bbs.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a>
			<%
				}
			%>
			<!--글쓰기 버튼 생성-->
			<a href="write.jsp">글쓰기</a>
		</div>
	</div>
	<!--게시판 메인 페이지 영역 끝-->
</body>
</html>