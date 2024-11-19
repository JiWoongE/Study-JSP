<%@ page contentType="text/html; charset=utf-8" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
