<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<!-- CSS는 Main 으로 이동 -->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인화면</title>
        <link rel="stylesheet" type="text/css" href="/css/main.css" />
</head>
<body>
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
     <div class="container">
     
      <!-- Include header a-->
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <!-- Main content area -->
        <main>

            <!-- Include aside (sidebar) -->
            <jsp:include page="/WEB-INF/views/aside.jsp" />
            
            <!-- 여기서부터 가운데 메인 -->
            <section class="main-content">
                <div class="status-overview">
                    <h2>나의 출근 현황</h2>
                    <table>
                    <colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
                        <tr>
                            <th>구분</th>
                            <th>병가</th>
                            <th>사용</th>
                            <th>잔여</th>
                        </tr>
                        <tr>
                            <td>연차x${user.annual }</td>
                            <td><c:if test="${sickCount!=0 }">${sickCount }일</c:if><c:if test="${sickCount==0 }">0일</c:if> </td>
                            <td><c:if test="${leaveCount!=0 }">${leaveCount }일</c:if><c:if test="${leaveCount==0 }">0일</c:if></td>
                            <td>${user.annual - leaveCount }일</td>
                        </tr>
                    </table>
                    <table>
                    <colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
                        <tr>
                            <th>구분</th>
                            <th>출근</th>
                            <th>지각</th>
                            <th>결근</th>
                        </tr>
                        <tr>
                            <td><%=lastDay %></td>
                            <td>${count }일</td>
                            <td>${Tcount }일</td>
                            <td>${abcount }일</td>
                        </tr>
                    </table>
                </div>
                <div class="notes">
                    <div class="note" >
                        <p>12:20 부장님과 점심</p>
                        <p>14:50 미팅</p>
                    </div>
                    <div class="note">
                        <p id="vlist">Add note</p>
                    </div>
                </div>
                    

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
            </section><!-- 가운데 메인 끝나는 곳 -->
        </main>
    </div>
</body>
<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>

<!--메인화면에서 출근 버튼을 눌렀을때 발생 되는 스크립트문-->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
deptno = ${user.deptno};
function selectDate(date) {
	   $.getJSON('/vacation',{'date':date},function(data){
		  $('#vlist').text("휴가자")
	      $('#vlist').append("<br>"+data)
	   })
	}
</script>
<script type="text/javascript" src="/js/main.js"></script>
<!--현재시간 -->
<script>
    function updateTime() {
        const now = new Date();
        const options = { 
            year: 'numeric', 
            month: '2-digit', 
            day: '2-digit', 
            weekday: 'long', 
            hour: '2-digit', 
            minute: '2-digit', 
            second: '2-digit'
        };
        const currentTimeString = now.toLocaleDateString('ko-KR', options);
        document.getElementById('current-time').innerText = currentTimeString;
    }

    // 처음 페이지 로드 시 시간을 표시
    updateTime();

    // 매 초마다 시간을 업데이트
    setInterval(updateTime, 1000);
</script>
</html>