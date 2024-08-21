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
                <img src="/upload/${user.imgPath}" alt="User Profile">
                <div>
                    <p>이름: ${user.ename }</p>
                    <p>직책: ${user.position }</p>
                    <p>사번: ${user.empno }</p>
                    <p>${user.ename }님 환영합니다.</p>
                </div>
            </div>
            <h1>코멧 업무포털</h1>
            <div class="header-right">
                <button id="start">업무시작</button>
                <button id="end">업무종료</button>
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" /></c:if><c:if test="${startTime==null}">00:00</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a></c:if>
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a></c:if>
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/searchCustomers">통합업무</a></li>
                    <li><a href="/attendance/managementList">근태현황</a></li>
                    <li><a href="/boards" class="active">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=3 }"> <li><a href="/emp_manage" class="active">직원관리</a></li></c:if>
                </ul>
            </aside>
            <section class="board-main-content">
                <div class="board-viewtitle" style="margin-right: 10px;">게시글 수정</div>
                <div class="board-title"></div>
                <div class="board-detail">
                    <div class="section-inline-section">
                        <div class="right">
                            <div><strong>작성자:</strong> ${user.empno}</div>
                            <div><strong>작성일자:</strong>
                                <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH시mm분ss초" /></div>
                        </div>
                    </div>
                    <form action="/boards/edit/${board.no}" method="post">
                        <div class="section" style="height: 530px;">
                            <div class="section-title">제목</div>
                                <input class= "title-text" type="text" id="title" name="title" value="${board.title}" required>
                            <div class="section-title">내용</div>
                                <textarea class="text" id="content" name="content" required>${board.content}</textarea>
                        </div>
                        <div class="form-actions" style="display: ruby-text;">
                        <button onclick="location.href='/boards'">목록</button>
                        <button type="submit">완료</button>
                        </div>
                		
                    </form>
                </div>
            </section>
        </main>
    </div>
</body>
<footer>
    <p class="footer-text">현재시간 : <span id="current-time"></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
$('#end').click(function() {
    $.getJSON('/endTime', {
        'empno': empno
    }, function(data) {
        $('#endTime').text(data)
    })
})

function selectDate(date) {
    $.getJSON('/vacation', {
        'date': date
    }, function(data) {
        $('#vlist').append(datea)
    })
}
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

    updateTime();
    setInterval(updateTime, 1000);
</script>
</html>
