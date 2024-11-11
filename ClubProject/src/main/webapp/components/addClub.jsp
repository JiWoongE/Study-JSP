<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ClubRepository" %>
<%@ page import="dto.Club" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Club</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <form action="addClub.jsp" method="post">
        <h2>Add New Club</h2>
        <label>Club Name: <input type="text" name="name" required></label><br>
        <label>Description: <input type="text" name="description" required></label><br>
        <label>Leader: <input type="text" name="leader" required></label><br>
        <input type="submit" value="Add Club">
    </form>

    <%
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String leader = request.getParameter("leader");

        if (name != null && description != null && leader != null) {
            ClubRepository clubRepo = new ClubRepository();
            Club newClub = new Club(String.valueOf(clubRepo.getAllClubs().size() + 1), name, description, leader);
            clubRepo.getAllClubs().add(newClub);  // Repository에 새 동아리 추가

            out.println("<p>Club added successfully! <a href='clubs.jsp'>Back to Club List</a></p>");
        }
    %>
</body>
</html>
