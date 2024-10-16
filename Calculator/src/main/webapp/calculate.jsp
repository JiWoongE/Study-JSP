<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.Calculator" %>
<%@ page import="java.lang.ArithmeticException" %>
<%@ page import="java.lang.IllegalArgumentException" %>

<jsp:useBean id="calc" class="dao.Calculator" scope="request" />
<jsp:setProperty name="calc" property="num1" param="num1" />
<jsp:setProperty name="calc" property="num2" param="num2" />
<jsp:setProperty name="calc" property="operator" param="operator" />

<html>
<head>
    <title>계산 결과</title>
</head>
<body>
    <h2>계산 결과</h2>
    <%
        try {
            double result = calc.getResult();
            out.println("<p>결과: " + result + "</p>");
        } catch (ArithmeticException e) {
            response.sendRedirect("calculationError.jsp");
        } catch (IllegalArgumentException e) {
            response.sendRedirect("calculationError.jsp");
        } catch (Exception e) {
            response.sendRedirect("calculationError.jsp");
        }
    %>
    <a href="calculator.jsp">돌아가기</a>
</body>
</html>
