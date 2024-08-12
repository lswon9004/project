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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">00:00/</c:if></p>
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
                <div class="status-overview">
                    <h2>나의 출근 현황</h2>
                    <table>
                        <tr>
                            <th>구분</th>
                            <th>기준</th>
                            <th>사용</th>
                            <th>잔여</th>
                        </tr>
                        <tr>
                            <td>연차x12</td>
                            <td>11일</td>
                            <td>2일</td>
                            <td>5일</td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <th>구분</th>
                            <th>출근</th>
                            <th>지각</th>
                            <th>결근</th>
                        </tr>
                        <tr>
                            <td>출근x31</td>
                            <td>11일</td>
                            <td>2일</td>
                            <td>0일</td>
                        </tr>
                    </table>
                </div>
                <div class="notes">
                    <div class="note">
                        <p>12:20 부장님과 점심</p>
                        <p>14:50 미팅</p>
                    </div>
                    <div class="note">
                        <p id="vlist">Add note</p>
                    </div>
                </div>
                    
                    <%
                 // 날짜 값을 받아서 Calendar 객체 설정
                    String dateString = request.getParameter("date");
                    Calendar cal = Calendar.getInstance();
                    if (dateString != null && !dateString.isEmpty()) {
                        String[] dateParts = dateString.split("-");
                        int year = Integer.parseInt(dateParts[0]);
                        int month = Integer.parseInt(dateParts[1]) - 1; // 월은 0부터 시작
                        int day = Integer.parseInt(dateParts[2]);
                        cal.set(year, month, day);
                    }

                    int year = cal.get(Calendar.YEAR);
                    int month = cal.get(Calendar.MONTH);
                    cal.set(year, month, 1);
                    int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
                    int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

                    // 이전 달의 마지막 날
                    Calendar prevCal = (Calendar) cal.clone();
                    prevCal.add(Calendar.MONTH, -1);
                    int prevLastDay = prevCal.getActualMaximum(Calendar.DAY_OF_MONTH);

                    // 다음 달의 첫 번째 날
                    Calendar nextCal = (Calendar) cal.clone();
                    nextCal.add(Calendar.MONTH, 1);

    %>
                    <h2><%= year %>년 <%= month + 1 %>월 달력</h2>
                    <form >
                    	<input type="date" name="date"><button>확인</button>
                    </form>
                    <table>
        <thead>
            <tr>
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th>토</th>
            </tr>
        </thead>
        <tbody>
            <%
            int day = 1;
            int prevDay = prevLastDay - startDayOfWeek + 2;
            boolean nextMonth = false;

            for (int i = 1; i <= 6; i++) {
                out.println("<tr>");
                for (int j = 1; j <= 7; j++) {
                    if (i == 1 && j < startDayOfWeek) {
                        out.println("<td class='prev-month' onclick='selectDate(\"" + year + "-" + String.format("%02d", month) + "-" + String.format("%02d", prevDay) + "\")'>" + prevDay + "</td>");
                        prevDay++;
                    } else if (day > lastDay) {
                        out.println("<td class='next-month' onclick='selectDate(\"" + year + "-" + String.format("%02d", month + 2) + "-" + String.format("%02d", (day - lastDay)) + "\")'>" + (day - lastDay) + "</td>");
                        day++;
                    } else {
                        out.println("<td onclick='selectDate(\"" + year + "-" + String.format("%02d", month + 1) + "-" + String.format("%02d", day) + "\")'>" + day + "</td>");
                        day++;
                    }
                }
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
                <div class="chart">
                    <h2>출근 현황</h2>
                    <!-- Chart will be added here -->
                </div>
            </section>
        </main>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
datea= ${user.att.startTime}
date = <%= year %> +'-'+('0'+ <%= month + 1 %>).slice(-2)
$('#start').click(function(){
	deptno = ${user.deptno};
	$.getJSON("/startTime",{'empno':empno,'deptno':deptno},function(data){
		if (data){			
			$('#startTime').text(data+'/');
			console.log(data)
		 }else{
			alert('이미 출근버튼을 누르셨습니다.')
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
</html>