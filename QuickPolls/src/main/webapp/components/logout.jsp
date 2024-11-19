<%@ page contentType="text/html; charset=utf-8" %>
<%
    // 현재 세션 종료
    session.invalidate();

    // 메인 페이지로 리다이렉트
    response.sendRedirect("index.jsp");
%>
