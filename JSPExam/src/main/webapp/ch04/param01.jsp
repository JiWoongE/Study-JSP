<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
	<h2>param 액션 태그 </h2>
	<jsp:forward page="param01_data.jsp">
		<jsp:param name="id" value="admin" />
		<jsp:param name="name" value='<%= java.net.URLEncoder.encode("관리자") %>' />
	</jsp:forward>
</body>
</html>