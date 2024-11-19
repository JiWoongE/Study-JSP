<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*, java.time.*, java.time.format.DateTimeFormatter"%>
<%@ include file="header.jsp" %>
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
</head>
<body>
<main>
    <!-- Hero 섹션 -->
    <section class="hero">
        <h1>QuickPolls에 오신 것을 환영합니다!</h1>
        <p>QuickPolls는 쉽고 빠르게 투표를 생성하고 참여할 수 있는 온라인 투표 시스템입니다.</p>
        <div class="buttons">
            <c:if test="${sessionScope.username == null}">
            </c:if>
            <c:if test="${sessionScope.username != null}">
                </c:if>
        </div>
    </section>

          <!-- 진행 중인 투표 -->
    <section class="ongoing-polls">
        <h2>진행 중인 투표</h2>
        <ul>
            <%
            // 데이터베이스 연결 설정
            String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
            String dbUser = "root";
            String dbPassword = "12345678";
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
            	Class.forName("com.mysql.cj.jdbc.Driver");
            	conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            	// SQL 쿼리 실행
            	String sql = "SELECT poll_id, title, deadline " + "FROM polls " + "WHERE deadline > NOW() "
            	+ "ORDER BY deadline ASC " + "LIMIT 3";
            	stmt = conn.prepareStatement(sql);
            	rs = stmt.executeQuery();

            	// 현재 시간
            	LocalDateTime now = LocalDateTime.now();

            	// 투표 데이터 출력
            	while (rs.next()) {
            		int pollId = rs.getInt("poll_id");
            		String title = rs.getString("title");
            		Timestamp deadlineTimestamp = rs.getTimestamp("deadline");
            		LocalDateTime deadline = deadlineTimestamp.toLocalDateTime();

            		// 남은 시간 계산
            		Duration duration = Duration.between(now, deadline);
            		long days = duration.toDays();
            		long hours = duration.toHours() % 24;
            		long minutes = duration.toMinutes() % 60;

            		String remainingTime = days > 0 ? days + "일 " + hours + "시간 남음"
            		: hours > 0 ? hours + "시간 " + minutes + "분 남음" : minutes + "분 남음";
            %>
                        <li>
                            <div class="poll-item">
                                <h3><%=title%></h3>
                                <p class="remaining-time">마감까지: <%=remainingTime%></p>
                                <a href="vote.jsp?pollId=<%=pollId%>" class="btn">투표하기</a>
                            </div>
                        </li>
            <%
            }
            } catch (Exception e) {
            } finally {
            if (rs != null)
            rs.close();
            if (stmt != null)
            stmt.close();
            if (conn != null)
            conn.close();
            }
            %>
        </ul>
        
        <!-- 더보기 버튼 -->
        <div style="text-align: center; margin-top: 20px;">
            <a href="vote.jsp" class="btn btn-more">더보기</a>
        </div>
    </section>

    <!-- 새로운 업데이트 소식 -->
    <section class="updates">
        <h2>새로운 소식</h2>
        <ul>
            <li>투표 항목에 이미지를 추가할 수 있습니다.</li>
            <li>투표 마감 알림 기능이 추가되었습니다.</li>
            <li>프로필 사진 업로드 기능이 제공됩니다.</li>
        </ul>
    </section>
</main>
</body>
<%@ include file="footer.jsp" %>
