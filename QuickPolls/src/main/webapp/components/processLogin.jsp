<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
    // 사용자 입력값 가져오기
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    System.out.println("입력된 사용자 이름: " + username);
    System.out.println("입력된 비밀번호: " + password);

    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
    String dbUser = "root";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    boolean isValidUser = false;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        System.out.println("데이터베이스 연결 성공");

        // 사용자 확인 쿼리 실행
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password); // 비밀번호는 이후에 해싱하여 저장 가능
        rs = stmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            isValidUser = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    // 결과 처리
    if (isValidUser) {
        session.setAttribute("username", username);
        response.sendRedirect("index.jsp");
    } else {
        request.setAttribute("errorMessage", "잘못된 사용자 이름 또는 비밀번호입니다.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>
