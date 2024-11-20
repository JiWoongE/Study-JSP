<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.User, dao.UserDAO" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    UserDAO userDAO = new UserDAO();
    User user = new User(username, password, email, phone);

    boolean updateSuccess = userDAO.updateUser(user);

    if (updateSuccess) {
        session.setAttribute("username", username); // 세션 업데이트
        response.sendRedirect("profile.jsp?success=true");
    } else {
        request.setAttribute("errorMessage", "프로필 업데이트에 실패했습니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }
%>
