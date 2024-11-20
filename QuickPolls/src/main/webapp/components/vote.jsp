<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>QuickPolls - 투표 목록</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/vote.css">
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <main class="vote-page">
        <section class="poll-list">
            <h1>진행 중인 투표</h1>
            <div class="poll-container">
                <%
                    String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
                    String dbUser = "root";
                    String dbPassword = "12345678";
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                        String sql = "SELECT poll_id, title, description, deadline, created_by FROM polls WHERE deadline > NOW() ORDER BY deadline ASC";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int poll_id = rs.getInt("poll_id");
                            String title = rs.getString("title");
                            String description = rs.getString("description");
                            Timestamp deadline = rs.getTimestamp("deadline");
                            String createdBy = rs.getString("created_by");
                %>
                            <div class="poll-item">
                                <h3><%= title %></h3>
                                <p class="details">
                                    <span>마감일: <%= deadline %></span> <br> <span>작성자: <%= createdBy %></span>
                                </p>
                                <div class="actions">
                                    <a href="voteDetail.jsp?poll_id=<%= poll_id %>" class="btn vote-btn">투표하러 가기</a>
									<a href="result.jsp?poll_id=<%= poll_id %>" class="btn result-btn">결과 보기</a>
                                </div>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </div>
        </section>
    </main>
</body>
<%@ include file="footer.jsp" %>
</html>
