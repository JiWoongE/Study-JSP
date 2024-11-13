<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ClubRepository" %>
<%@ page import="dto.Club" %>
<!DOCTYPE html>
<html>
<head>
    <title>Clubs</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/clubsStyles.css">
</head>
<body>
    <h2>동아리 리스트</h2>
    <div class="button-container">
        <a href="addClub.jsp">새로운 동아리 추가</a>
    </div>
    <ul>
        <% 
            ClubRepository clubRepo = new ClubRepository();
            for (Club club : clubRepo.getAllClubs()) {
        %>
            <li>
                <a href="clubDetails.jsp?id=<%= club.getId() %>"><%= club.getName() %></a> - 
                <%= club.getDescription() %>
            </li>
        <% } %>
    </ul>
</body>
</html>
