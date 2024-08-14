<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원정보등록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            position: relative;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        label {
            margin: 5px 0;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        select,
        textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        .photo-container {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .photo-container img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        .button-container {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #ccc;
        }

        .message {
            grid-column: 1 / -1;
            color: #ff0000;
            text-align: center;
            margin-top: 20px;
        }

        .authority-container {
            display: flex;
            align-items: center;
        }

        .authority-container select {
            margin-left: 10px;
            flex-grow: 1;
        }

    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress;
                    var jibunAddr = data.jibunAddress;
                    document.getElementById('address').value = roadAddr || jibunAddr;
                }
            }).open();
        }
    </script>
</head>
<body>

    <div class="container">
        <h2>직원등록</h2>
        <div class="photo-container">
            <img src="default-profile.png" alt="Profile Picture">
        </div>
        <form action="saveinsert" method="post" modelAttribute="InserEmpDto">
            <label for="ename">사원이름:</label>
            <input type="text" id="ename" name="ename" required>

            <label for="empno">사원번호:</label>
            <input type="empno" id="empno" name="empno" required>

            <label for="deptno">부서번호:</label>
            <input type="text" id="deptno" name="deptno" required>

            <label for="jop">담당업무:</label>
            <input type="text" id="jop" name="jop" required>

            <label for="position">직급:</label>
            <select id="position" name="position" required>
                <option value="관리자">관리자</option>
                <option value="대리">대리</option>
                <option value="팀장">팀장</option>
                <option value="사원">사원</option>
            </select>

            <label for="authority">권한부여:</label>
            <div class="authority-container">
                <input type="text" id="authority" name="authority" value="사원" readonly>
                <select id="authority-select" name="authority-select">
                    <option value="팀장">팀장</option>
                    <option value="관리자">관리자</option>
                </select>
            </div>

            <label for="phone">연락처:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="email">이메일:</label>
            <input type="text" id="email" name="email" required>

            <label for="address">주소:</label>
            <div style="display: flex; gap: 10px;">
                <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly style="width: 20%;">
                <button type="button" onclick="execDaumPostcode()">주소 검색</button>
            </div>
            <input type="text" id="address" name="address" required>

            <label for="birthday">생년월일:</label>
            <input type="date" id="birthday" name="birthday" required>

            <label for="hiredate">입사일:</label>
            <input type="date" id="hiredate" name="hiredate">

            <label for="sal">연봉:</label>
            <input type="text" id="sal" name="sal">

            <label for="memo">메모:</label>
            <textarea id="memo" name="memo"></textarea>

            <div class="button-container">
                <button type="submit">등록</button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/empList'">닫기</button>
                <button type="button">계정잠금/해제</button>
            </div>
        </form>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>
    </div>

</body>
</html>