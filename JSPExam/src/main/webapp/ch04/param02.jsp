<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<title>Action Tag</title>
</head>
<body>
	<h2>param 액션 태그 </h2>
	<jsp:include page="param02_data.jsp">
		<jsp:param name="title" value='<%=java.net.URLDecoder.decode("오늘의 날짜와 시각 ") %>' />
		<jsp:param name="date" value="<%=java.util.Calendar.getInstance().getTime() %>" />
	</jsp:include>
</body>
</html>