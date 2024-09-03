<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>사원 정보 수정</title>
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
	background-color: rgba(0, 0, 0, 0.4);
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

.close:hover, .close:focus {
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

input[type="text"], input[type="email"], textarea, select {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 4px;
}

input[readonly], textarea[readonly] {
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
</style>

</head>
<body>

	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="document.location.href='/emp_manage'">&times;</span>
			<h2>사원정보</h2>
			<img src="/img/${empInfo.imgPath}" alt="Profile Image" width="100">
			<!-- 사진 업로드 폼 -->
			<form action="/modify/uploadPhoto" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="no" value="${empInfo.empno}">

				<div class="form-group">
					<label for="photo"></label> <input type="file" name="imgPath1"
						id="imgPath" accept="image/*"> <input type="hidden"
						name="redirectPage" value="empModify">
				</div>
				<div class="button-container">
					<input type="submit" value="업로드">

				</div>
			</form>
			<form action="/empModify" method="post" modelAttribute="ModifyDto">
				<input type="hidden" name="_method" value="put"> <input
					type="hidden" name="imgPath" value="${empInfo.imgPath}">
				<table>
					<tr>
						<td>사원 이름:</td>
						<td><input type="text" name="ename" value="${empInfo.ename}"
							required></td>
						<td>사원 번호:</td>
						<td><input type="text" name="empno" value="${empInfo.empno}"
							readonly></td>
						<td>랭크:</td>
						<td>${empInfo.authority}</td>
					</tr>
					<tr>
						<td>부서:</td>
						<!-- db에서 dept 부서와 번호 저장 안해두면 작동안할수있음-->
						<td><select id="selected" name="deptno">
								<c:forEach var="dept" items="${deptList}">
									<option value="${dept.deptno}">${dept.deptname}</option>
								</c:forEach>
						</select></td>
						<td>담당업무:</td>
						<td><input type="text" name="jop" value="${empInfo.jop}"></td>
						<td>직급:</td>
						<td><select name="position">
								<c:forEach var="position" items="${positionList}">
									<option value="${position.position}">${position.position}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>연락처:</td>
						<td><input type="text" name="phone" value="${empInfo.phone}"></td>
						<td>이메일:</td>
						<td><input type="text" name="email" value="${empInfo.email}"></td>
					</tr>
					<tr>
						<td>주소:</td>
						<td><input type="text" id="address" name="address"
							value="${empInfo.address}">
							<button type="button" id="addressSearchBtn"
								onclick="execDaumPostcode()">주소
								검색</button></td>
						<td>상세주소:</td>
						<td><input type="text" name="detailAddr"
							value="${empInfo.detailAddr}"></td>
					</tr>
					<tr>
						<td>생년월일:</td>
						<td><input type="text" name="birthday"
							value="<fmt:formatDate value='${empInfo.hiredate}' pattern='yyyy-MM-dd' />"
							readonly></td>
						<td>입사일:</td>
						<td><input type="text" name="hiredate"
							value="<fmt:formatDate value='${empInfo.hiredate}' pattern='yyyy-MM-dd' />"
							readonly></td>
					</tr>
					<tr>
						<td>급여:</td>
						<td><input type="text" name="sal" value="${empInfo.sal}"></td>
					</tr>
					<tr>
						<td>메모:</td>
						<td colspan="5"><textarea name="memo">${empInfo.memo}</textarea>
						</td>
					</tr>
				</table>
				<div class="buttons">
					<button type="submit" id="submitButton">등록</button>
					<button type="button" onclick="deleteEmployee(${empInfo.empno})">삭제</button>					
					<button type="button" onclick="document.location.href='/emp_manage'">닫기</button>

				</div>
			</form>
		</div>
	</div>

	<!-- Daum 주소 검색 API 스크립트 추가 -->
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

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

	<script>
	function deleteEmployee(empno) {
    	if (confirm("정말로 삭제하시겠습니까?")) {
        	const form = document.createElement('form');
        	form.method = 'post';
        	form.action = '/deleteEmp';
        
        	const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'empnos';
            input.value = empno;
        
        	form.appendChild(input);
        
        	document.body.appendChild(form);
        	form.submit();
    	}
	}
	</script>

</body>
</html>