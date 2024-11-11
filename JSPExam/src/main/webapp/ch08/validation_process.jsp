<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Validation Processing</title>
</head>
<body>
    <h2>Validation Processing</h2>
    <% 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean isValidPassword = false;

        if (password != null) {
            boolean hasLetter = password.matches(".*[a-zA-Z].*");
            boolean hasDigit = password.matches(".*\\d.*");
            boolean hasSpecialChar = password.matches(".*[!@#$%^&*(),.?\":{}|<>].*");
            boolean isValidLength = password.length() >= 8;
            isValidPassword = hasLetter && hasDigit && hasSpecialChar && isValidLength;
        }

        if (username == null || username.isEmpty()) {
            out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
        } else if (password == null || password.isEmpty()) {
            out.println("<script>alert('비밀번호를 입력해주세요.'); history.back();</script>");
        } else if (confirmPassword == null || confirmPassword.isEmpty()) {
            out.println("<script>alert('비밀번호 확인을 입력해주세요.'); history.back();</script>");
        } else if (!password.equals(confirmPassword)) {
            out.println("<script>alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.'); history.back();</script>");
        } else if (!isValidPassword) {
            out.println("<script>alert('비밀번호는 영문, 숫자, 특수기호를 포함하여 8자리 이상으로 구성되어야 합니다.'); history.back();</script>");
        } else {
            out.println("아이디: " + username + "<br>");
            out.println("비밀번호: " + password + "<br>");
        }
    %>
</body>
</html>
