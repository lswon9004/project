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
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
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

        textarea {
            resize: none;
            height: 100px;
        }
        
        .button-container {
        
            display: flex;
            justify-content: flex-end;/*버튼을 오른쪽으로 정렬 start 로 하면 왼쪽 정렬*/
            gap: 5px; /* 버튼 간격 */
            margin-top: 20px;
        }
        

        button {
            padding: 10px 20px;
            margin-top: 5px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            align-self: flex-start;
            
        }

        button:hover {
            background-color: #ccc;
        }

        .message {
            color: #ff0000;
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <!-- Daum 주소 검색 API 스크립트 추가 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var jibunAddr = data.jibunAddress; // 지번 주소 변수

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById("address").value = roadAddr || jibunAddr;
                }
            }).open();
        }
    </script>
</head>
<body>

    <div class="container">
        <h2>고객정보</h2>
        <form action="saveCustomer" method="post" modelAttribute="customerInfo">
            <label for="customerName">고객명:</label>
            <input type="text" id="customerName" name="customerName" required  placeholder="공백없이 입력하세요">

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required placeholder="공백없이 입력하세요">

            <label for="address">주소:</label>
            <div style="display: flex; gap: 10px;">
                <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly style="width: 20%;">
                <button type="button" onclick="execDaumPostcode()">주소 검색</button>
            </div>
            <input type="text" id="address" name="address" required>

            <label for="dateOfBirth">생년월일:</label>
            <input type="text" id="dateOfBirth" name="dateOfBirth" required placeholder="공백없이 6자리 입력하세요">

            <label for="contact">연락처:</label>
            <input type="text" id="contact" name="contact" required placeholder="000-0000-0000 형식으로 입력하세요">

            <label for="status">진행상태:</label>
            <select id="status" name="status" required>
                <option value="Received">접수완료</option>
                <option value="Consulted">상담완료</option>
                <option value="Complaint">민원인</option>
            </select>

            <label for="memo">Memo:</label>
            <textarea id="memo" name="memo"></textarea>

            <div class="button-container">
                <button type="submit">저장</button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/customerList'">닫기</button>
            </div>
        </form>
        
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>
    </div>

</body>
</html>