<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="checkSession.jsp" %> <!-- 세션 확인 -->
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>QuickPolls - 투표 상세</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/voteDetail.css">
</head>
<body>
    <%@ include file="header.jsp" %> <!-- 헤더 포함 -->

    <main class="voteDeatail-page">
        <section class="poll-detail">
            <%
                String poll_id = request.getParameter("poll_id");
                if (poll_id == null) {
                    response.sendRedirect("vote.jsp?error=InvalidPoll");
                    return;
                }

                String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
                String dbUser = "root";
                String dbPassword = "12345678";

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                boolean isMultipleChoice = false;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // 투표 정보 가져오기
                    String sql = "SELECT * FROM polls WHERE poll_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(poll_id));
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        isMultipleChoice = rs.getBoolean("is_multiple_choice");

                        out.println("<h1 class='poll-title'>" + title + "</h1>");
                        out.println("<p class='poll-description'>" + description + "</p>");

                        // 파일 리스트 가져오기
                        String filesSql = "SELECT file_path FROM poll_files WHERE poll_id = ?";
                        PreparedStatement filesStmt = conn.prepareStatement(filesSql);
                        filesStmt.setInt(1, Integer.parseInt(poll_id));
                        ResultSet filesRs = filesStmt.executeQuery();

                        out.println("<div class='poll-images'>");
                        while (filesRs.next()) {
                            String filePath = filesRs.getString("file_path");
                            out.println("<div class='poll-image-item'>");
                            out.println("<img src='" + request.getContextPath() + "/" + filePath + "' alt='Uploaded Image' class='poll-image'>");
                            out.println("</div>");
                        }
                        out.println("</div>");

                        // 옵션 가져오기
                        String optionsSql = "SELECT * FROM poll_options WHERE poll_id = ?";
                        PreparedStatement optionsStmt = conn.prepareStatement(optionsSql);
                        optionsStmt.setInt(1, Integer.parseInt(poll_id));
                        ResultSet optionsRs = optionsStmt.executeQuery();

                        out.println("<form action='processVote.jsp' method='post' class='poll-form'>");
                        out.println("<input type='hidden' name='poll_id' value='" + poll_id + "'>");
                        out.println("<div class='poll-options'>");
                        while (optionsRs.next()) {
                            int optionId = optionsRs.getInt("option_id");
                            String optionText = optionsRs.getString("option_text");

                            out.println("<div class='poll-option'>");
                            out.println("<label>");
                            out.println("<input type='" + (isMultipleChoice ? "checkbox" : "radio") + "' name='selected_options' value='" + optionId + "'>");
                            out.println(optionText);
                            out.println("</label>");
                            out.println("</div>");
                        }
                        out.println("</div>");
                        out.println("<button type='submit' class='poll-submit-btn'>투표 제출</button>");
                        out.println("</form>");
                    } else {
                        out.println("<p class='poll-error'>유효하지 않은 투표입니다.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='poll-error'>오류가 발생했습니다. 나중에 다시 시도해주세요.</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </section>
    </main>

    <%@ include file="footer.jsp" %> <!-- 푸터 포함 -->
</body>
</html>
