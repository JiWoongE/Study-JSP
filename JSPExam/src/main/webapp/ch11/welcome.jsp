<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("session_out.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
</head>
<body>
    <h2><%= userID %>, 님 반갑습니다.</h2>
    <form action="session_out.jsp" method="post">
        <input type="submit" value="로그아웃">
    </form>
</body>
</html>