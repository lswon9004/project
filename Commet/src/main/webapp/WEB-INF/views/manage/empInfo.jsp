<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>사원 정보</title>
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

        input[type="text"],
        input[type="email"],
        textarea {
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
    </style>
    
    <!-- 글수정시 수정버튼을 눌렀을때만 수정 가능 하게 하는 기능인데 -->
    <script>
    function enableEdit() {
        const inputs = document.querySelectorAll('input, textarea');
        inputs.forEach(input => input.removeAttribute('readonly'));
    }

    function cancelEdit() {
        const inputs = document.querySelectorAll('input, textarea');
        inputs.forEach(input => input.setAttribute('readonly', true));
        location.href='${pageContext.request.contextPath}/empList';
    }
    </script>
    
</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="location.href='${pageContext.request.contextPath}/emp_manage'">&times;</span>
        <h2>사원정보</h2>
        <form action="${pageContext.request.contextPath}/empInfo" method="post">
            <input type="hidden" name="_method" value="put">
            <input type="hidden" name="empno" value="${empInfo.empno}">
            <img src="${pageContext.request.contextPath}/images/profile.png" alt="Profile Image" width="100">
            <table>
            <tr>
                <td>사원 이름:</td><td><input type="text" name="ename" value="${empInfo.ename}" readonly></td>
                <td>사원 번호:</td><td><input type="text" name="empno" value="${empInfo.empno}" readonly></td>
                <td>랭크:</td><td><input type="text" name="annual" value="${empInfo.annual}" readonly></td>
            </tr>
            <tr>
				<td>부서:</td><td><input type="text" name="deptname" value="${empInfo.deptname}" readonly></td>
				<td>담당업무:</td><td><input type="text" name="jop" value="${empInfo.jop}" readonly></td>
				<td>직급:</td><td><input type="text" name="position" value="${empInfo.position}" readonly></td>
            </tr>
            <tr>
				<td>연락처:</td><td><input type="text" name="phone" value="${empInfo.phone}" readonly></td>
				<td>이메일:</td><td><input type="text" name="email" value="${empInfo.email}" readonly></td>
            </tr>
            <tr>
 				<td>주소:</td><td><input type="text" name="address" value="${empInfo.address}" readonly></td>
  				<td>상세주소:</td><td><input type="text" name="detailAddr" value="${empInfo.detailAddr}" readonly></td>
            </tr>
            <tr>
	    		<td>생년월일:</td><td><input type="text" name="birthday" value="<fmt:formatDate value='${empInfo.birthday}' pattern='yyyy-MM-dd' />"  readonly></td>
    			<td>입사일:</td><td><input type="text" name="hiredate" value="<fmt:formatDate value='${empInfo.hiredate}' pattern='yyyy-MM-dd' />"  readonly></td>
            </tr>
             <tr>
	    		<td>급여:</td><td><input type="text" name="sal" value="${empInfo.sal}" readonly></td>
            </tr>
            <tr>
            	<td>메모:</td>
                <td colspan="5">
                    <textarea name="memo" readonly>${empInfo.memo}</textarea>
                </td>
            </tr> 
            </table>
            <div class="buttons">
                <button type="button" onclick="enableEdit()">수정</button>
                <button type="submit">등록</button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/emp_manage'">닫기</button>
               
            </div>
        </form>
    </div>
</div>
</body>
</html>