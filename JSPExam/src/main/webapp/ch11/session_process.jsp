<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%
    String userId = request.getParameter("id");
    String password = request.getParameter("passwd");

    if (userId.equals("admin") && password.equals("1234")) {
        session.setAttribute("userID", userId);
        response.sendRedirect("welcome.jsp");
    } else {
        out.println("아이디 혹은 비밀번호가 틀립니다");
    }
%>