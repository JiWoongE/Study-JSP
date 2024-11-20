<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.User, dao.UserDAO, dto.Poll, dao.PollDAO, java.util.List"%>
<%@ include file="header.jsp"%>
<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/profile.css">
</head>
<body>
	<main class="profile-page">
		<section class="profile-update-container">
		<h1>프로필 수정</h1>
		<%
		// 현재 로그인한 사용자 정보 가져오기
		String loggedInUsername = (String) session.getAttribute("username");
		if (loggedInUsername == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 사용자 정보 가져오기
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUserByUsername(loggedInUsername);

		if (user == null) {
			out.println("<p>사용자 정보를 가져올 수 없습니다.</p>");
			return;
		}

		// 사용자가 생성한 투표 목록 가져오기
		PollDAO pollDAO = new PollDAO();
		List<Poll> userPolls = pollDAO.getPollsByUser(loggedInUsername);
		%>

		<form action="processProfileUpdate.jsp" method="post">
			<div class="profile-section">
				<label for="username">아이디</label> 
				<input type="text" id="username" name="username" value="<%=user.getUsername()%>" readonly>
			</div>
			<div class="profile-section">
				<label for="password">비밀번호</label> 
				<input type="password" id="password" name="password" value="<%=user.getPassword()%>" required>
			</div>
			<div class="profile-section">
				<label for="email">이메일</label> 
				<input type="email" id="email" name="email" value="<%=user.getEmail()%>" required>
			</div>
			<div class="profile-section">
				<label for="phone">전화번호</label> 
				<input type="text" id="phone" name="phone" value="<%=user.getPhone()%>" required>
			</div>
			<div class="profile-section">
				<button type="submit">프로필 업데이트</button>
			</div>
		</form>
		</section>
		<section class="poll-lists">
		<h1>내가 생성한 투표 목록</h2>
        <%
            if (userPolls == null || userPolls.isEmpty()) {
        %>
            <p>생성한 투표가 없습니다.</p>
        <%
            } else {
        %>
            <ul class="poll-list">
                <% for (Poll poll : userPolls) { %>
                    <li>
                        <a class="poll-link" href="voteDetail.jsp?poll_id=<%=poll.getPoll_id()%>">
                            <%=poll.getTitle()%>
                        </a>
                        <p class="poll-description"><%=poll.getDescription()%></p>
                        <p class="poll-deadline">마감 시간: 
                            <%=poll.getDeadline() != null ? poll.getDeadline() : "마감 시간 없음"%>
                        </p>
                    </li>
                <% } %>
            </ul>
        <%
            }
        %>
        </section>
	</main>
</body>
<%@ include file="footer.jsp"%>
