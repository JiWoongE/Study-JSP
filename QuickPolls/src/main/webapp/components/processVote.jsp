<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%
    String pollId = request.getParameter("poll_id");
    String[] selectedOptions = request.getParameterValues("selected_options");
    String username = (String) session.getAttribute("username"); // 사용자 이름

    if (pollId == null || selectedOptions == null || selectedOptions.length == 0 || username == null) {
        out.println("<script>alert('유효하지 않은 입력입니다. 다시 시도해주세요.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
        return;
    }

    // 세션에서 투표 여부 확인
    String votedPolls = (String) session.getAttribute("votedPolls");
    if (votedPolls != null && votedPolls.contains("," + pollId + ",")) {
        out.println("<script>alert('이미 이 투표에 참여하셨습니다.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
        return;
    }
    if (selectedOptions == null || selectedOptions.length == 0) {
        out.println("<script>alert('최소 하나의 항목을 선택해주세요.'); location.href='voteDetail.jsp?poll_id=" + pollId + "';</script>");
        return;
    }

    try {
        Integer.parseInt(pollId);
        for (String optionId : selectedOptions) {
            Integer.parseInt(optionId);
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 형식의 입력입니다. 다시 시도해주세요.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
    String dbUser = "root";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        conn.setAutoCommit(false); // 트랜잭션 시작

        // 1. 마감된 투표인지 확인
        String deadlineCheckSql = "SELECT deadline FROM polls WHERE poll_id = ?";
        stmt = conn.prepareStatement(deadlineCheckSql);
        stmt.setInt(1, Integer.parseInt(pollId));
        rs = stmt.executeQuery();

        if (!rs.next()) {
            out.println("<script>alert('유효하지 않은 투표입니다.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
            return;
        }

        Timestamp deadline = rs.getTimestamp("deadline");
        if (deadline != null && deadline.before(new Timestamp(System.currentTimeMillis()))) {
            out.println("<script>alert('이 투표는 마감되었습니다.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
            return;
        }
        rs.close();
        stmt.close();

        // 2. vote_count 업데이트
        String updateVoteCountSql = "UPDATE poll_options SET vote_count = vote_count + 1 WHERE option_id = ?";
        stmt = conn.prepareStatement(updateVoteCountSql);

        for (String optionId : selectedOptions) {
            stmt.setInt(1, Integer.parseInt(optionId));
            stmt.addBatch();
        }

        int[] updateCounts = stmt.executeBatch();
        stmt.close();

        // 실패한 배치 처리 확인
        for (int count : updateCounts) {
            if (count == Statement.EXECUTE_FAILED) {
                throw new SQLException("Batch update failed for one or more vote counts.");
            }
        }

        conn.commit(); // 트랜잭션 커밋

        // 세션에 투표 기록 추가
        if (votedPolls == null) {
            votedPolls = ",";
        }
        session.setAttribute("votedPolls", votedPolls + pollId + ",");

        // 성공적으로 result.jsp로 리디렉션
        response.sendRedirect("result.jsp?poll_id=" + pollId);

    } catch (SQLException e) {
        if (conn != null) conn.rollback(); // 트랜잭션 롤백
        e.printStackTrace();
        out.println("<script>alert('데이터베이스 오류가 발생했습니다. 다시 시도해주세요.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('예기치 않은 오류가 발생했습니다. 다시 시도해주세요.'); location.href='result.jsp?poll_id=" + pollId + "';</script>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
