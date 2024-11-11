<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <form action="clubs.jsp" method="post">
        <h2>로그인</h2>
        <label>아이디 : <input type="text" name="username"></label><br>
        <label>비밀번호 : <input type="password" name="password"></label><br>
        <input type="submit" value="Login">
    	<p> 계정이 없으신가요? <a href="register.jsp">회원가입</a>.</p>
    </form>
</body>
</html>
