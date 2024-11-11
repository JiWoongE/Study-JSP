<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ClubRepository" %>
<%@ page import="dto.Club" %>
<!DOCTYPE html>
<html>
<head>
    <title>Clubs</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <h2>Club List</h2>
    <a href="addClub.jsp">Add New Club</a> <!-- 동아리 추가 버튼 -->
    <ul>
        <%
            ClubRepository clubRepo = new ClubRepository();
            for (Club club : clubRepo.getAllClubs()) {
        %>
            <li>
                <a href="clubDetails.jsp?id=<%= club.getId() %>"><%= club.getName() %></a> - 
                <%= club.getDescription() %>
            </li>
        <%
            }
        %>
    </ul>
</body>
</html>
