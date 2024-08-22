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
        /* 폼 컨테이너 스타일 */
        .write-form-container {
            width: 65%;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* 폼 그룹 스타일 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* 입력 필드 스타일 */
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
        }

        /* 텍스트 입력 필드 스타일 */
        .form-group textarea {
            height: 300px;
            resize: vertical;
        }

        /* 버튼 스타일 */
        .actions {
            text-align: right;
        }

        .actions button {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            background: #00bfff;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .actions button.cancel {
            background-color: #ccc;
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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">00:00</c:if></p>
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
            <div class="board-viewtitle">글쓰기</div>
            <div class="board-title"></div>
                <div class="board-detail">
                    <form action="/boards/write" method="post">
                        <div class="form-group">
                            <label for="empno">작성자 번호</label>
                            <input type="text" id="empno" name="empno" required readonly="readonly" style="pointer-events: none;" value="${user.empno}">
                        </div>
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input class="title-text" type="text" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="text" id="content" name="content" required style="resize: none;"></textarea>
                        </div>
                        <div class="actions">
                            <button type="submit">등록</button>
                            <button onclick="location.href='/boards'">취소</button>
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
