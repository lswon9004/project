<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management Portal</title>
        <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .prev-month, .next-month {
            color: #ccc;
        }
        
        
          /*여기서부터 managementList */ 
          
         body {
            font-family: Arial, sans-serif;
        }
        
      /*   .container {
            width: 100%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        
        이거 삭제 하니까 메인 안에 잘 들어감
         */
         
        h1 {
            text-align: center;
            color: #333;
        }
        .form-container { /*버튼정렬*/
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            align-items: center;
        }
        .form-container form {
            display: flex;
            align-items: center;
        }
        label {
            margin: 0 10px;
            font-weight: bold;
        }
        input[type="date"] {
            padding: 5px;
            margin: 0 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        button { /* 검색 + 전체 */
            padding: 5px 10px;
            background-color: #00bfff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f8f8f8;
        }
        .button-group {
            display: flex;
        }
        
        .button-group form {
            margin: 0px; /*엑셀 다운로드 버튼 크기*/
        }
       
       .pagination {
            text-align: center;
            margin: 20px 0;
            
        }
          .pagination a {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            color: #007bff;
            border-radius: 4px;
            
        }
        .pagination a.active {
            font-weight: bold;
            background-color: #007bff;
            color: white;
            
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
     <div class="container">
        <header>
            <div class="user-info">
                <img src="profile.jpg" alt="User Profile">
                <div>
                    <p>이름: 김자바</p>
                    <p>직책: ${user.position }</p>
                    <p>사번: ${user.empno }</p>
                    <p>김자바 님 환영합니다.</p>
                </div>
            </div>
            <h1>코멧 업무포털</h1>
            <div class="header-right">
                <button id="start">업무시작</button>
                <button id="end">업무종료</button>
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">0d:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <a href="/main">Home</a>
                    <a href="#">개인정보수정</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/customerList">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <li><a href="/approval/status">결재승인</a></li>
                    <li><a href="/bullboard">익명게시판</a></li>
                    <li><a href="/emp_manage">직원관리</a></li>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            
            <section class="main-content">
             <div class="container">
        	<h1>${user.empno}님의 근태현황 입니다.</h1>
			<div class="form-container">
        	<form action="/attendance/search" method="get">
            <label for="startDate">출근일자:</label>
            <input type="date" id="startDate" name="startDate"required>
            <label for="endDate">~</label>
            <input type="date" id="endDate" name="endDate" required>
            <button type="submit">검색</button>
            <button type="button" onclick="location.href='/attendance/managementList?p=1'">초기화</button>
        	</form>
        
        	<div class="button-group">
            <form action="/attendance/checkIn" method="post" >
                <button type="submit">출근</button>
            </form>
            <form action="/attendance/checkOut" method="post" >
                <button type="submit">퇴근</button>
            </form>
            <button type="button" onclick="location.href='/attendance/downloadExcel2'">엑셀다운로드</button>
       		</div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>출근번호</th>
                    <th>출근일자</th>
                    <th>출근시간</th>
                    <th>퇴근시간</th>
                    <th>근무유형</th>
                    <th>연차사용</th>
                    <th>잔여연차</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${count == 0}">
                    <tr>
                        <td colspan="7" class="tac">저장된 근태현황이 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${count > 0}">
                    <c:forEach var="attendance" items="${attendanceList}">
                        <tr>
                            <td>${attendance.attendance_no}</td>
                            <td><fmt:formatDate value="${attendance.date}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${attendance.check_in}" pattern="HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${attendance.check_out}" pattern="HH:mm:ss"/></td>
                            <td>${attendance.worktype}</td>
                            <td>${attendance.early_leave}</td>
                            <td></td>
                    
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>

      <div class="pagination">
            <c:if test="${begin > pageNum}">
                <a href="managementList?p=${begin-1}">[이전]</a>
            </c:if>
            <c:forEach begin="${begin}" end="${end}" var="i">
                <a href="managementList?p=${i}" class="${i == page ? 'active' : ''}" >${i}</a>
            </c:forEach>
            <c:if test="${end < totalPages}">
                <a href="managementList?p=${end+1}">[다음]</a>
            </c:if>
            <c:if test="${count == 0}">
                아직 입력한 정보가 없습니다.
            </c:if>
        </div>
    </div>

            </section>
        </main>
    </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
datea= ${user.att.startTime}

$('#start').click(function(){
	deptno = ${user.deptno};
	$.getJSON("/startTime",{'empno':empno,'deptno':deptno},function(data){
		if (data){			
			$('#startTime').text(data+'/');						
		 }else{
			alert('이미 출근버튼을 누르셨습니다.')
			alert(date)
		} 
	})
})
$('#end').click(function(){
	$.getJSON('/endTime',{'empno':empno},function(data){
		$('#endTime').text(data)
	})
})
 function selectDate(date) {
	$.getJSON('/vacation',{'date':date},function(data){
		$('#vlist').append(datea)
	})
}
</script>

 
   	<script>
        $(document).ready(function() {
            $("#checkInButton").click(function(event) {
                event.preventDefault(); // 기본 동작을 막음
                $.ajax({
                    url: "/attendance/checkInStatus",
                    method: "GET",
                    success: function(data) {
                        if (data) {
                            alert("출근 버튼을 이미 눌렀습니다.");
                        } else {
                            $("#checkInForm").submit(); // 출근 폼 제출
                        }
                    }
                });
            });
        });
    </script>
</html>