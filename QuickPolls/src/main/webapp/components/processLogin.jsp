<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.User, dao.UserDAO" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUser(username, password);

    if (user != null) {
        session.setAttribute("username", user.getUsername());
        response.sendRedirect("index.jsp");
    } else {
        request.setAttribute("errorMessage", "잘못된 사용자 이름 또는 비밀번호입니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>
