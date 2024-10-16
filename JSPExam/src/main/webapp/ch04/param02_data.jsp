<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
	<%
		String title = request.getParameter("title");
	%>
	<h2><%=java.net.URLDecoder.decode(title) %></h2>
	<p> Today is : <%=request.getParameter("date") %>
</body>
</html>