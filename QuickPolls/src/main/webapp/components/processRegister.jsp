<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.User, dao.UserDAO" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    UserDAO userDAO = new UserDAO();
    String errorMessage = null;

    if (userDAO.isUsernameTaken(username)) {
        errorMessage = "이미 존재하는 사용자 이름입니다.";
    } else {
        User newUser = new User(username, password, email, phone);
        boolean isUserCreated = userDAO.createUser(newUser);
        if (isUserCreated) {
            response.sendRedirect("login.jsp");
        } else {
            errorMessage = "회원가입 중 오류가 발생했습니다.";
        }
    }

    if (errorMessage != null) {
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }
%>
