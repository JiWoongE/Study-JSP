<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserRepository" %>
<%@ page import="dto.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <form action="register.jsp" method="post">
        <h2>회원가입</h2>
        <label>아이디 : <input type="text" name="username" required></label><br>
        <label>비밀번호 : <input type="password" name="password" required></label><br>
        <label>이메일주소 : <input type="email" name="email" required></label><br>
        <label>생년월일 : <input type="date" name="birthdate" placeholder="20000515" required></label><br>
        <label>전화번호 : <input type="tel" name="phoneNumber" placeholder="010-0000-0000" required></label><br>
        <input type="submit" value="Register">
    </form>

    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String birthdate = request.getParameter("birthdate");
        String phoneNumber = request.getParameter("phoneNumber");

        if (username != null && password != null && email != null && birthdate != null && phoneNumber != null) {
            UserRepository userRepo = new UserRepository();
            User newUser = new User(username, password, email, birthdate, phoneNumber);
            userRepo.addUser(newUser);

            out.println("<p>회원가입 완료! <a href='login.jsp'>로그인</a>.</p>");
        }
    %>
</body>
</html>
