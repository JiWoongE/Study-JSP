<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>계산기</title>
</head>
<body>
    <h2>계산기</h2>
    <form action="calculate.jsp" method="post">
        <input type="text" name="num1" placeholder="첫 번째 숫자" required />
        <select name="operator">
            <option value="+">+</option>
            <option value="-">-</option>
            <option value="*">*</option>
            <option value="/">/</option>
        </select>
        <input type="text" name="num2" placeholder="두 번째 숫자" required />
        <input type="submit" value="계산" />
    </form>
</body>
</html>
