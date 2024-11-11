<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ClubRepository" %>
<%@ page import="dto.Club" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Details</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <%
        String clubId = request.getParameter("id");
        ClubRepository clubRepo = new ClubRepository();
        Club club = clubRepo.getClubById(clubId);

        if (club != null) {
    %>
        <h2><%= club.getName() %></h2>
        <p>Description: <%= club.getDescription() %></p>
        <p>Leader: <%= club.getLeader() %></p>
    <%
        } else {
    %>
        <p>Club not found.</p>
    <%
        }
    %>
</body>
</html>
