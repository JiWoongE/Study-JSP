<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>QuickPolls</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
	<header>
		<nav class="navbar">
			<div class="navbar-brand">
				<img src="<%=request.getContextPath()%>/images/poll.png" alt="투표함" class="logo-image">
				<a href="index.jsp">QuickPolls</a>
			</div>
			<ul class="navbar-menu">
				<!-- 로그인 상태 확인 -->
				<c:choose>
					<c:when test="${sessionScope.username != null}">
						<li><a href="createPoll.jsp">투표 생성</a></li>
						<li><a href="vote.jsp">투표 참여</a></li>
						<li><a href="profile.jsp">프로필</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="register.jsp">회원가입</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</header>
</body>
</html>
