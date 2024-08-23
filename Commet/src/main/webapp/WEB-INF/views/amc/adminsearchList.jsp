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
</head>
<body>
     <div class="container">
      <!-- Include header -->
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <!-- Main content area -->
        <main>
            <!-- Include aside (sidebar) -->
            <jsp:include page="/WEB-INF/views/aside.jsp" />
          <!--   여기서부터 가운데 메인 -->
          
            <section class="main-content">
             <div class="container">
        	<h2>사원근태현황</h2>
        	<div class="header-line"></div>
			<div class="form-container">
        	
    		<form action="/attendance/search" method="get">
    		<label for="empno">사원번호:</label>
    		<input type="text" id="empno" name="empno" required>
    		
    		<button type="submit">검색</button>
			
            <button type="button" onclick="location.href='/attendance/adminManagementList?p=1'">초기화</button>
        	</form>
        
        	<div class="button-group">
        	
        	<form action="/attendance/markAbsent2" method="post">
    		<label for="empno">사원번호:</label>
    		<input type="text" id="empno" name="eno" required>
    		<button type="submit">결근처리</button>
			</form>
			
			<!-- 메시지 표시 영역 a-->
			<c:if test="${not empty message}">
    		<p>${message}</p>
			</c:if>
           
            <button type="button" onclick="location.href='/attendance/downloadExcel3'">엑셀다운로드</button>
       		</div>
        </div>

        <table>
            <thead>
                <tr>
                   <th>번호</th>
                    <th>사원번호</th>
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
                        <td colspan="8" class="tac">데이터가 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${count > 0}">
                    <c:forEach var="attendance" items="${attendanceList}">
                        <tr>
                      		<td>${attendance.employee_attendance_no}</td>
                            <td>${attendance.empno}</td>
                            <td><fmt:formatDate value="${attendance.date}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${attendance.check_in}" pattern="HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${attendance.check_out}" pattern="HH:mm:ss"/></td>
                            <td>${attendance.worktype}</td>
                              <td> <c:forEach var="count" items="${leaveCountlist}">
                            				<c:if test="${count.empno== attendance.empno}">
                            					${count.c }
                            				</c:if>
                            		 </c:forEach></td>
                            <td><c:forEach var="alist" items="${alist}">
                            				<c:if test="${alist.empno== attendance.empno}">
                            					${alist.annual }
                            				</c:if>
                            		 </c:forEach></td>
                    
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>

      <div class="pagination">
    <c:if test="${begin > pageNum}">
        <a href="search?empno=${empno}&startDate=${startDate}&endDate=${endDate}&p=${begin-1}">[이전]</a>
    </c:if>
    <c:forEach begin="${begin}" end="${end}" var="i">
        <a href="search?empno=${empno}&startDate=${startDate}&endDate=${endDate}&p=${i}" class="${i == page ? 'active' : ''}">${i}</a>
    </c:forEach>
    <c:if test="${end < totalPages}">
        <a href="search?empno=${empno}&startDate=${startDate}&endDate=${endDate}&p=${end+1}">[다음]</a>
    </c:if>
    <c:if test="${count == 0}">
    </c:if>
</div>
    </div>


            </section>
        </main>
    </div>
</body>
<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};

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