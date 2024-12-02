<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp"%>
<html lang="${param.lang != null ? param.lang : 'ko'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <fmt:setLocale value="${param.lang != null ? param.lang : 'kr'}" />
    <fmt:setBundle basename="bundle.messages" />
    <title><fmt:message key="title.register" /></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/register.css">
</head>
<body>
    <main class="register-page">
        <!-- 언어 선택 -->
        <nav>
            <a href="?lang=en">English</a> | <a href="?lang=kr">한국어</a>
        </nav>

        <section class="register-container">
            <h1><fmt:message key="title.register" /></h1>
            <form action="processRegister.jsp" method="post">
                <!-- 아이디 입력 -->
                <div class="form-group">
                    <label for="username"><fmt:message key="label.username" /></label>
                    <input type="text" id="username" name="username" placeholder="<fmt:message key='placeholder.username' />" required>
                </div>

                <!-- 비밀번호 입력 -->
                <div class="form-group">
                    <label for="password"><fmt:message key="label.password" /></label>
                    <input type="password" id="password" name="password" placeholder="<fmt:message key='placeholder.password' />" required>
                </div>

                <!-- 이메일 입력 -->
                <div class="form-group">
                    <label for="email"><fmt:message key="label.email" /></label>
                    <input type="email" id="email" name="email" placeholder="<fmt:message key='placeholder.email' />" required>
                </div>

                <!-- 전화번호 입력 -->
                <div class="form-group">
                    <label for="phone"><fmt:message key="label.phone" /></label>
                    <input type="tel" id="phone" name="phone" placeholder="<fmt:message key='placeholder.phone' />" pattern="[0-9]{10,15}" required>
                </div>

                <!-- 제출 버튼 -->
                <div class="form-group">
                    <button type="submit" class="btn"><fmt:message key="button.submit" /></button>
                </div>
            </form>

            <!-- 회원가입 실패 메시지 -->
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>

            <p><fmt:message key="message.alreadyAccount" /> <a href="login.jsp"><fmt:message key="link.login" /></a></p>
        </section>
    </main>
    <%@ include file="footer.jsp"%>
</body>
</html>
