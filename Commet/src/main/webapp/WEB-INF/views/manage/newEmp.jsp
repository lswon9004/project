<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>신규 사원등록</title>
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
</head>
<body>
	<form action="insert" method="post" id="newEmp" class="modal">
		<table border="1">
			<tr>
				<td>사원이름</td><td><input name="ename" /></td>
				<td>사원번호</td><td><input name="empno" /></td>
			</tr>
			<tr>
				<td>부서번호</td>
				<td>
                    <select name="deptno">
                        <option value="200">sdff</option>
                        <option value="100">qwer</option>
                        <option value="300">asdf</option>
                    </select>
                </td>
				<td>담당업무</td><td><input name="jop" /></td>
				<td>직급</td>
				<td>
                    <select name="position">
                        <option value="대리">대리</option>
                        <option value="팀장">팀장</option>
                        <option value="관리자">관리자</option>
                    </select>
                </td>
			</tr>
			<tr>
				<td>연락처</td><td><input name="phone" /></td>
			</tr>
			<tr>
				<td>이메일</td><td><input name="email" /></td>
				<td>주소</td><td><input name="address" /></td>
			</tr>
			<tr>
				<td>상세주소</td><td><input name="detailAddr" /></td>
				<td>생년월일</td><td><input name="birthday" /></td>
			</tr>
			<tr>
				<td>입사일</td><td><input name="hiredate" /></td>
				<td>연봉</td><td><input name="sal" /></td>
			</tr>
			<tr>
				<td>메모:</td><td colspan="5"><textarea id="memo" name="memo"></textarea></td>
			</tr> 
		</table>
		<div class="buttons">
                <button type="submit">등록</button>
               <button type="button" onclick="location.href='${pageContext.request.contextPath}/emp_manage'">닫기</button>
               
            </div>
	</form>
</body>
</html>