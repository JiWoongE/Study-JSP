<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>Validation Example</title>
    <script type="text/javascript">
        function validatePassword(password) {
            var hasLetter = /[a-zA-Z]/.test(password);
            var hasDigit = /\d/.test(password);
            var hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
            var isValidLength = password.length >= 8;
            
            return hasLetter && hasDigit && hasSpecialChar && isValidLength;
        }

        function validateForm() {
            var username = document.forms["validationForm"]["username"].value;
            var password = document.forms["validationForm"]["password"].value;
            var confirmPassword = document.forms["validationForm"]["confirmPassword"].value;
            
            if (username == "") {
                alert("아이디를 입력해주세요.");
                return false;
            }
            
            if (password == "") {
                alert("비밀번호를 입력해주세요.");
                return false;
            }

            if (confirmPassword == "") {
                alert("비밀번호 확인을 입력해주세요.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return false;
            }

            if (!validatePassword(password)) {
                alert("비밀번호는 영문, 숫자, 특수기호를 포함하여 8자리 이상으로 구성되어야 합니다.");
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <h2>Validation Example</h2>
    <form name="validationForm" action="validation_process.jsp" method="post" onsubmit="return validateForm()">
        아이디: <input type="text" name="username"><br>
        비밀번호: <input type="password" name="password"><br>
        비밀번호 확인: <input type="password" name="confirmPassword"><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>