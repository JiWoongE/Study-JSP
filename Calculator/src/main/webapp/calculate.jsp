<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.Calculator" %>
<%@ page import="java.lang.ArithmeticException" %>
<%@ page import="java.lang.IllegalArgumentException" %>
<%@ page import="java.lang.NumberFormatException" %>

<%
    String num1Str = request.getParameter("num1");
    String num2Str = request.getParameter("num2");
    String operator = request.getParameter("operator");
    Calculator calc = new Calculator();

    try {
    	double num1 = Double.parseDouble(num1Str);
        double num2 = Double.parseDouble(num2Str);
        
        calc.setNum1(num1);
        calc.setNum2(num2);
        calc.setOperator(operator);

        double result = calc.getResult();
        out.println("<h2>계산 결과</h2>");
        out.println("<p>결과: " + result + "</p>");

    } catch (NumberFormatException e) {
        response.sendRedirect("calculateFailed.jsp");
    } catch (ArithmeticException e) {
        response.sendRedirect("calculateFailed.jsp");
    } catch (IllegalArgumentException e) {
        response.sendRedirect("calculateFailed.jsp");
    } catch (Exception e) {
        response.sendRedirect("calculateFailed.jsp");
    }
	    out.println("<a href='calculator.jsp'>돌아가기</a>");

%>
