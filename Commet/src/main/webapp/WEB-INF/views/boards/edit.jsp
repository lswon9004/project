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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">0d:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a> </c:if><!--다른 jsp 파일에서 적용할거 -->
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a> </c:if> <!--다른 jsp 파일에서 적용할거 -->                    <a href="#">개인정보수정</a>
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/searchCustomers">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=2 }"> <li><a href="/emp_manage" class="active">직원관리</a></li></c:if>
                </ul>
            </aside>
            <section class="main-content">
                <!-- 메인 콘텐츠 영역 -->
	<h2>게시글 수정</h2> <!-- 페이지 콘텐츠의 제목 표시 -->
                <!-- 수정된 게시글 내용 제출 폼 -->
                <form action="/boards/edit/${board.no}" method="post">
                    <div class="form-group"> <!-- 폼 요소 그룹화 -->
                        <label for="title">제목</label> <!-- 제목 입력 필드 레이블 -->
                        <!-- 게시글 제목 입력 필드. 현재 게시글 제목이 기본값으로 설정 -->
                        <input type="text" id="title" name="title" value="${board.title}" required>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label> <!-- 내용 입력 필드 레이블 -->
                        <!-- 게시글 내용을 입력하는 텍스트 영역. 현재 게시글 내용이 기본값으로 설정 -->
                        <textarea id="content" name="content" required>${board.content}</textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit">수정</button> <!-- 폼 제출 버튼 -->
                    </div>
                </form>
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