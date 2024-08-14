<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            font-size: 16px;
        }

        .modal {
            display: block;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 8px;
            width: 90%;
            max-width: 1000px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin: 0 0 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            
        }
        
        button, #addressSearchBtn { /* 주소검색 CSS */
    	padding: 10px 20px;
    	margin-top: 5px;
    	border: none;
   		background-color: #00bfff;
    	color: #fff;
    	cursor: pointer;
    	border-radius: 4px;
    	align-self: flex-start;
    	
		}

		button:hover, #addressSearchBtn:hover {
    	background-color: #ccc;
		}

        input[type="text"],
        input[type="email"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        

        input[readonly],
        textarea[readonly],
        select[readonly] {
            background-color: #f4f4f4;
            color: #666;
            pointer-events: none;
        }
        
         select[disabled] {
            background-color: #f4f4f4; /* 다른 목록과 동일한 배경색 */
            color: #666; /* 다른 목록과 동일한 글자색 */
            pointer-events: none;
        }

        textarea {
            resize: none;
            height: 200px;
        }

        .buttons {
            text-align: right;
            margin-top: 20px;
        }

        .buttons button {
            padding: 10px 20px;
            margin-left: 5px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }

        .buttons button:last-child {
            background-color: #ccc;
        }
        
         /* 숨겨진 등록 버튼 */
        #submitButton {
            display: none;
            
    </style>

   
  
</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <%-- <span class="close" onclick="location.href='${pageContext.request.contextPath}/customerList'">&times;</span> 클릭 했을때 리스트로이동--%>
        <span class="close" onclick="window.close()">&times;</span>
        <h2>세부정보</h2>
        <form action="${pageContext.request.contextPath}/customerForm" method="post">
            <input type="hidden" name="_method" value="put">
            <input type="hidden" name="customerID" value="${customerInfo.customerID}">
            <table>
                <tr>
                    <th style="width: 9%;">고객번호</th>
                    <th style="width: 17%;">연락처</th>
                    <th style="width: 20%;">이메일</th>
                    <th style="width: 10%;">이름</th> <!-- 칸 너비 줄임 -->
                    <th style="width: 10%;">생년월일</th> <!-- 칸 너비 줄임 -->
                    <th style="width: 20%;">진행상태</th> <!-- 칸 너비 늘림 -->
                </tr>
                
                <tr>
                    <td>${customerInfo.customerID}</td>
                    <td><input type="text" name="contact" value="${customerInfo.contact}" readonly></td>
                    <td><input type="email" name="email" value="${customerInfo.email}" readonly></td>
                    <td><input type="text" name="customerName" value="${customerInfo.customerName}" readonly></td>
                    <td><input type="text" name="dateOfBirth" value="${customerInfo.dateOfBirth}" readonly></td>
                    <td>
                        <select name="status" disabled>
                            <option value="Received" ${customerInfo.status == 'Received' ? 'selected' : ''}>접수완료</option>
                            <option value="Consulted" ${customerInfo.status == 'Consulted' ? 'selected' : ''}>상담완료</option>
                            <option value="Complaint" ${customerInfo.status == 'Complaint' ? 'selected' : ''}>민원인</option>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <th>주소</th>
                    <td colspan="5">
                        <input type="text" id="address" name="address" value="${customerInfo.address}" readonly>
                        <button type="button" id="addressSearchBtn" onclick="execDaumPostcode()" style="display: none;">주소 검색</button>
                    </td>
                </tr>
                
                <tr>
                    <th>메모</th>
                    <td colspan="5">
                        <textarea name="memo" readonly>${customerInfo.memo}</textarea>
                    </td>
                </tr>
                
            </table>
            <div class="buttons">
                <button type="button" onclick="enableEdit()">수정</button>
                <button type="submit" id="submitButton">등록</button>
                <button type="button" onclick="window.close()">닫기</button>
                
            </div>
        </form>
    </div>
</div>


 <!-- Daum 주소 검색 API 스크립트 추가 -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script>
    function enableEdit() {
        const inputs = document.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.removeAttribute('readonly');
            if (input.tagName.toLowerCase() === 'select') {
                input.removeAttribute('disabled');
            }
        });

        document.getElementById('addressSearchBtn').style.display = 'inline-block';
        document.getElementById('submitButton').style.display = 'inline-block'; // 등록 버튼 보이기
    }

    function cancelEdit() {
        const inputs = document.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.setAttribute('readonly', true);
            if (input.tagName.toLowerCase() === 'select') {
                input.setAttribute('disabled', true);
            }
        });

        document.getElementById('addressSearchBtn').style.display = 'none';
        document.getElementById('submitButton').style.display = 'none'; // 등록 버튼 숨기기
        location.href='${pageContext.request.contextPath}/customerList';
    }

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
    
    
</body>
</html>