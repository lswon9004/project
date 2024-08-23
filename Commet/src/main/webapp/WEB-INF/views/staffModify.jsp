<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>개인정보 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
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
        .modal img {
            display: block;
            margin: auto;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 8px;
            width: 80%;
            max-width: 800px;
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
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
        
        button, #addressSearchBtn { /* 주소검색 CSS */
    	padding: auto;
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
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[readonly],
        textarea[readonly] {
            background-color: #f4f4f4;
            color: #666;
        }

		select[readonly] {
		  background-color: #f4f4f4;
		  color: #666;
		  pointer-events: none;
		}


        textarea {
            resize: none;
            height : 200px;
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
    
    <!-- Daum 주소 검색 API 스크립트 추가 -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>    
    <!-- 글수정시 수정버튼을 눌렀을때만 수정 가능 하게 하는 기능인데 -->
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
        document.getElementById('modify').style.display = 'none'; // 수정 버튼 숨기기
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
    
</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="location.href='/main'">&times;</span><!--/main 받아오는 컨트롤러가 없음 만들어야함-->
        <h2>개인정보 수정</h2>
        <form action="/empInfo" method="post" >
            <input type="hidden" name="_method" value="put">
            
            <img src="/upload/${user.imgPath}" alt="Profile Image" width="100"><!--로그인한 아이디 정보 가저와야함 메인화면 사진 나오는거랑 비슷하게 하면될듯 -->
            <table>
            <tr>
                <td>사원 이름:</td><td>${user.ename}</td>
                <td>사원 번호:</td><td>${user.empno}</td>
                <td>랭크:</td><td>${user.right}</td>
            </tr>
            <tr> 
				<td>부서:</td><td>${user.deptno}</td>
				<td>담당업무:</td><td>${user.jop}</td>
				<td>직급:</td><td>${user.position}</td>

            </tr>
            <tr>
				<td>연락처:</td><td><input type="text" name="phone" value="${user.email}" readonly></td>
				<td>이메일:</td><td><input type="text" name="email" value="${user.email}" readonly></td>
            </tr>
            <tr>
 				<td>주소:</td><td><input type="text" id="address" name="address" value="${user.address}" readonly>
 				<button type="button" id="addressSearchBtn" onclick="execDaumPostcode()" style="display: none;">주소 검색</button>
 				</td>				
  				<td>상세주소:</td><td><input type="text" name="detailAddr" value="${user.detailAddr}" readonly></td>
            </tr>
            <tr>
	    		<td>생년월일:</td><td><fmt:formatDate value='${user.birthday}' pattern='yyyy-MM-dd' /></td>
    			<td>입사일:</td><td><fmt:formatDate value='${user.hiredate}' pattern='yyyy-MM-dd' /></td>
            </tr>
			<tr>
				<td>비밀번호:</td><td><input type="text" name="password"></td>
			</tr>
            </table>
            <div class="buttons">
                <button type="button" onclick="enableEdit()" id="modify">수정</button>
                <button type="submit" id="submitButton">등록</button>
                <button type="button" onclick="location.href='/main'">닫기</button><!--/main 받아오는 컨트롤러가 없음 만들어야함-->
            </div>
        </form>
    </div>
</div>
</body>
</html>