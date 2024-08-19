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
        
    </style>  
    
</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="location.href='/emp_manage'">&times;</span>
        <h2>사원정보</h2>
        <form action="/empModify" method="get" >
        	<input type="hidden" name="no" value="${empInfo.empno }">
            <img src="/upload/${empInfo.imgPath}" alt="Profile Image" width="100">
            <table>
            <tr>
                <td>사원 이름:</td><td>${empInfo.ename}</td>
                <td>사원 번호:</td><td>${empInfo.empno}</td>
                <td>랭크:</td><td>${empInfo.authority}</td>
            </tr>
            <tr>
				<td>부서:</td><td>${empInfo.deptno}</td>
				<td>담당업무:</td><td>${empInfo.jop}</td>
				<td>직급:</td><td>${empInfo.position}</td>
            </tr>
            <tr>
				<td>연락처:</td><td>${empInfo.phone}</td>
				<td>이메일:</td><td>${empInfo.email}</td>
            </tr>
            <tr>
 				<td>주소:</td><td>${empInfo.address}</td>		
  				<td>상세주소:</td><td>${empInfo.detailAddr}</td>
            </tr>
            <tr>
	    		<td>생년월일:</td><td><fmt:formatDate value='${empInfo.birthday}' pattern='yyyy-MM-dd' /></td>
    			<td>입사일:</td><td><fmt:formatDate value='${empInfo.hiredate}' pattern='yyyy-MM-dd' /></td>
            </tr>
             <tr>
	    		<td>급여:</td><td>${empInfo.sal}</td>
            </tr>
            <tr>
            	<td>메모:</td>
                <td colspan="5">${empInfo.memo}</td>
            </tr> 
            </table>
            <div class="buttons">
                <button type="submit">수정</button>
                <button type="button" onclick="location.href='/emp_manage'">닫기</button>
               
            </div>
        </form>
    </div>
</div>
</body>
</html>