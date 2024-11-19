<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="header.jsp" %>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>
    <main class="login-page">
            <section class="login-container">
        <h1>로그인</h1>
        <form action="processLogin.jsp" method="post">
            <div class="login-section">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required>
            </div>
            <div class="login-section">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="login-section">
                <button type="submit">로그인</button>
            </div>
        </form>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <p>계정이 없으신가요? <a href="register.jsp">회원가입</a></p>
        </section>
    </main>
</body>
<%@ include file="footer.jsp" %>
