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
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/customerList">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards" class="active">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                </ul>
            </aside>
		<section class="main-content">
		<h2>게시판</h2>
            <div class="search-form">
                <form action="/boards/search" method="get">
                    <input type="text" name="title" placeholder="제목으로 검색">
                    <input type="text" name="author" placeholder="작성자로 검색">
                    <input type="date" name="date">
                    <button type="submit">검색</button>
                </form>
                <div>
                <button onclick="location.href='/boards/write'">글쓰기</button>
					</div>
            </div>
            <!-- 게시판 목록 테이블 영역 -->
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <!-- c:forEach 태그를 사용하여 boardList 변수에 있는 게시물을 반복하여 테이블 행으로 표시 -->
                <tbody>
                    <c:forEach var="board" items="${boardList}">
                        <tr>
                            <td>${board.no}</td>
                            <td><a href="/boards/${board.no}">${board.title}</a></td>
                            <td>${board.empno}</td>
                            <td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd" /></td>
                            <td>${board.readcount}</td>
                        </tr>
                    </c:forEach>
                </tbody> 
            </table> <!-- 게시판 목록 테이블 영역 끝 -->
            <!-- 페이징을 위한 요소 -->
            <div class="pagination">
            <!-- c:if와 c:forEach 태그를 사용하여 페이지 번호를 표시하고, 이전 및 다음 버튼을 제공 -->
		<div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/boards/search?p=${begin-1 }&date=${date}&author=${author}&title=${title}" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/boards/search?p=${i}&date=${date}&author=${author}&title=${title}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/boards/search?p=${end+1}&date=${date}&author=${author}&title=${title}" class="page next">&gt;</a>
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
datea= ${user.att.startTime}
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