<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
    // 사용자 입력 값 가져오기
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    // 디버깅 출력
    System.out.println("입력값 검증: 사용자 이름=" + username + ", 이메일=" + email + ", 전화번호=" + phone);

    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
    String dbUser = "root";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement stmt = null;

    boolean isUserCreated = false;
    String errorMessage = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        System.out.println("데이터베이스 연결 성공");

        // 트랜잭션 시작
        conn.setAutoCommit(false);

        // 사용자 이름 중복 확인
        String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        int userCount = rs.getInt(1);
        System.out.println("중복된 사용자 이름 확인 결과: " + userCount);

        if (userCount > 0) {
            errorMessage = "이미 존재하는 사용자 이름입니다.";
            System.out.println("중복된 사용자 이름으로 인해 회원가입 중단");
        } else {
            // 새 사용자 삽입
            String insertSql = "INSERT INTO users (username, password, email, phone, role) VALUES (?, ?, ?, ?, 'USER')";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, phone);

            System.out.println("실행 중인 쿼리: " + stmt.toString());
            int rows = stmt.executeUpdate();
            System.out.println("적용된 행 수: " + rows);

            if (rows > 0) {
                isUserCreated = true;
                conn.commit(); // 성공 시 커밋
                System.out.println("회원가입 성공 및 커밋 완료");
            } else {
                System.out.println("회원가입 실패: 행 추가되지 않음");
            }
        }
    } catch (Exception e) {
        // 예외 발생 시 롤백 및 오류 출력
        if (conn != null) conn.rollback();
        System.out.println("오류 발생: " + e.getMessage());
        e.printStackTrace();
        errorMessage = "회원가입 중 오류가 발생했습니다.";
    } finally {
        // 자원 해제
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    // 결과 처리
    if (isUserCreated) {
        response.sendRedirect("login.jsp");
    } else {
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }
%>
