<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%
    session.invalidate();
    response.sendRedirect("session.jsp");
%>