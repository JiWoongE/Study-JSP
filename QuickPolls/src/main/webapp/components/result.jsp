<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.PollDAO" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>QuickPolls - 투표 결과</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/result.css">
</head>
<body>
    <%@ include file="header.jsp" %> <!-- 헤더 포함 -->

    <main class="result-page">
        <section class="result-section">
            <%
                String pollId = request.getParameter("poll_id");
                if (pollId == null) {
                    response.sendRedirect("vote.jsp?error=InvalidPoll");
                    return;
                }

                PollDAO pollDAO = new PollDAO();
                String pollTitle = pollDAO.getPollTitle(Integer.parseInt(pollId)); // 투표 제목 가져오기
                Map<String, Integer> pollResults = null;
                try {
                    pollResults = pollDAO.getPollResults(Integer.parseInt(pollId));
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='error'>결과를 가져오는 중 오류가 발생했습니다.</p>");
                }

                if (pollResults == null || pollResults.isEmpty()) {
                    out.println("<p class='error'>투표 결과가 없습니다.</p>");
                } else {
                    int totalVotes = pollResults.values().stream().mapToInt(Integer::intValue).sum();
            %>
            <h1 class="result-title"><%= pollTitle %></h1> <!-- 투표 제목 표시 -->
            <canvas id="resultChart" width="400" height="200"></canvas>
            <ul class="result-details">
                <% for (Map.Entry<String, Integer> entry : pollResults.entrySet()) { 
                       String option = entry.getKey();
                       int votes = entry.getValue();
                       int percentage = (int) ((votes / (double) totalVotes) * 100);
                %>
                <li>
                    <strong><%= option %></strong>: <%= votes %>표 (<%= percentage %>%)
                </li>
                <% } %>
            </ul>

            <script>
                const ctx = document.getElementById('resultChart').getContext('2d');
                const chartData = {
                    labels: [<%
                        for (String option : pollResults.keySet()) {
                            out.print("'" + option + "',");
                        }
                    %>],
                    datasets: [{
                        label: '투표 수',
                        data: [<%
                            for (int count : pollResults.values()) {
                                out.print(count + ",");
                            }
                        %>],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                };
                new Chart(ctx, {
                    type: 'bar',
                    data: chartData,
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top'
                            },
                            tooltip: {
                                enabled: true
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: '투표 수'
                                }
                            }
                        }
                    }
                });
            </script>
            <% } %>
        </section>
    </main>

    <%@ include file="footer.jsp" %> <!-- 푸터 포함 -->
</body>
</html>
