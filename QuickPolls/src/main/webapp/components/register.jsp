<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - QuickPolls</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/register.css">
</head>
<body>
    <main class="register-page">
        <section class="register-container">
            <h1>회원가입</h1>
            <form action="processRegister.jsp" method="post">
                <!-- 아이디 입력 -->
                <div class="form-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" placeholder="아이디를 입력하세요" required>
                </div>

                <!-- 비밀번호 입력 -->
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>

                <!-- 이메일 입력 -->
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
                </div>

                <!-- 전화번호 입력 -->
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="01012345678" pattern="[0-9]{10,15}" required>
                </div>

                <!-- 제출 버튼 -->
                <div class="form-group">
                    <button type="submit" class="btn">회원가입</button>
                </div>
            </form>

            <!-- 회원가입 실패 메시지 -->
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>

            <p>이미 계정이 있으신가요? <a href="login.jsp">로그인</a></p>
        </section>
    </main>
    <%@ include file="footer.jsp"%>
</body>
</html>
