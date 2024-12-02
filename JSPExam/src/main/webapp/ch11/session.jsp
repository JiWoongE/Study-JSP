<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>session</title>
</head>
<body>
    <h2>Login</h2>
    <form action="session_process.jsp" method="post">
		<p> 아 이 디 : <input type="text" name="id">
	    <p> 비밀번호 : <input type="password" name="passwd">
        <p> <input type="submit" value="Login">
    </form>
</body>
</html>