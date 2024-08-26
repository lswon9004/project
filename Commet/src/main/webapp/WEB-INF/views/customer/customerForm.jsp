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
            background-color: rgba(0,0,0,0.4); /* 배경색 a*/
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff; /* 세부정보 포함 배경색 */
            padding: 17px;
            border: 0px solid #888;
            border-radius: 8px;
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
            background-color: #e0f7fa; /* 고객번호 연락처 등 항목 백그라운드 색상 */
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
        }
        #address{
        text-align: left;  }    
    </style>

</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="window.close()">&times;</span>
        <h2>세부정보</h2>
        <form action="${pageContext.request.contextPath}/customerForm" method="post" onsubmit="closeWindowAfterSubmit(event);">
			<!-- 수정완료 후 폼을 체출한 후 창을 닫기 위해 onsubmit 이벤트 처리 -->
			
            <input type="hidden" name="_method" value="put">
            <input type="hidden" name="customerID" value="${customerInfo.customerID}">
            <table>
                <tr>
                    <th style="width: 9%;">접수번호</th>
                    <th style="width: 17%;">연락처</th>
                    <th style="width: 17%;">이메일</th>
                    <th style="width: 10%;">이름</th> <!-- 칸 너비 줄임 -->
                    <th style="width: 13%;">생년월일</th> <!-- 칸 너비 줄임 -->
                    <th style="width: 20%;">진행상태</th> <!-- 칸 너비 늘림 -->
                </tr>
                
                <tr>
                    <td style="background-color: #e0f7fa; font-weight: bold;">${customerInfo.customerID}</td>
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
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="5" id="address">
                    <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" value="${customerInfo.zipcode}" readonly style="width: 20%;">
                     <button type="button" id="addressSearchBtn" onclick="execDaumPostcode()" style="display: none;">주소 검색</button>
                    <input type="text" id="address" name="address" value="${customerInfo.address}" readonly>
                   
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
                <button type="submit" id="submitButton"   >수정완료</button>
                <button type="button" onclick="window.close()">닫기</button>
                
            </div>
        </form>
    </div>
</div>


 <!-- Daum 주소 검색 API 스크립트 추가 -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script>
    
 	// Daum 주소 검색 API를 실행하는 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) { // 주소 검색이 완료되었을 때 호출되는 콜백 함수
                var roadAddr = data.roadAddress; // 도로명 주소
                var jibunAddr = data.jibunAddress; // 지번 주소
					
             	// 도로명 주소가 있으면 roadAddr을, 없으면 지번 주소를 입력 필드에 설정
                document.getElementById('address').value = roadAddr || jibunAddr;
                document.getElementById('zipcode').value = data.zonecode;
            }
        }).open();// 주소 검색 팝업 열기
    }
 
 
    function enableEdit() {  // 수정 버튼을 눌렀을 때 호출되는 함수
        const inputs = document.querySelectorAll('input, textarea, select');// 모든 input, textarea, select 요소를 선택
     	// 선택된 요소들의 읽기 전용 속성을 제거하여 편집 가능하게 만듦
        inputs.forEach(input => {
            input.removeAttribute('readonly'); // readonly 속성 제거
            if (input.tagName.toLowerCase() === 'select') {
                input.removeAttribute('disabled'); // select 태그의 disabled 속성 제거
            }
        });
     	
        document.getElementById('addressSearchBtn').style.display = 'inline-block'; // 주소 검색 버튼을 보이게 함
        document.getElementById('submitButton').style.display = 'inline-block'; // 등록 버튼 보이기
        document.querySelector('.buttons button[onclick="enableEdit()"]').style.display = 'none';// 수정 버튼 숨기기
    }
    
 	// 수정 모드를 취소하고 원래 상태로 되돌리는 함수
    function cancelEdit() {
        const inputs = document.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.setAttribute('readonly', true);
            if (input.tagName.toLowerCase() === 'select') {
                input.setAttribute('disabled', true);
            }
        });

        document.getElementById('addressSearchBtn').style.display = 'none';   // 주소 검색 버튼을 숨김
        document.getElementById('submitButton').style.display = 'none'; // 등록 버튼 숨기기
        location.href='/customerList';  // customerList 페이지로 이동
    }
 	
    </script>
    
    
    <script> // 수정완료 후 저장 > 닫기 구현을 위해 Ajax활용
    	function closeWindowAfterSubmit(event) {
        event.preventDefault(); // 기본 폼 제출을 막음

        const form = event.target;

        // 폼 데이터를 Ajax로 제출
        const xhr = new XMLHttpRequest();
        xhr.open(form.method, form.action, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        
        xhr.onload = function() {
            if (xhr.status === 200) {
               no=${customerInfo.customerID}; // 수정완료 후 다시 이전 화면으로
               location.href='/customerDetail/'+no; // 수정완료 후 다시 이전 화면으로 //이 방법보다 더 쉬운 방법 있을거 같음 나중에 확인
            } else {
                alert("수정 중 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        };

        // 폼 데이터를 직렬화하여 전송
        const formData = new FormData(form);
        
        formData.set('zipcode', document.getElementById('zipcode').value);
        
        const urlEncodedData = new URLSearchParams(formData).toString();
        xhr.send(urlEncodedData);
    }
    
    	//1.	폼이 제출되면: onsubmit 이벤트가 발생하여 closeWindowAfterSubmit 함수가 호출됩니다.
    	//2.	기본 제출 동작을 막고: Ajax를 사용해 비동기적으로 데이터를 서버에 전송합니다.
    	//3.	서버 응답을 받고: 응답이 성공적이면 창을 닫고, 오류가 발생하면 경고 메시지를 표시합니다.
	</script>
</body>
</html>