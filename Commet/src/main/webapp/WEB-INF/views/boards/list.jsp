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
        /* 메인 콘텐츠 내부 스타일 */
.main-content {
	width: 75%;
	padding: 20px;
	background: #fff;
}

.actions {
	text-align: right;
	margin-bottom: 20px;
}
/* 버튼 스타일 */
.actions button {
	padding: 10px 20px;
	margin: 5px;
	border: none;
	background: #e0f7fa; /* view.jsp의 글쓰기 버튼 색 */
	color: #000;
	border-radius: 5px;
	cursor: pointer;
	font-family: 'Noto Sans KR', sans-serif; /* th 태그와 동일한 글씨체 */
	font-weight: bold; /* th 태그와 동일한 글씨 굵기 */
}
/* 검색 폼 스타일 */
.search-form {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px;
	background: #f9f9f9;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.search-form input, .search-form button {
	padding: 10px;
	margin-right: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.search-form input[type="date"] {
	padding: 9px;
}

.search-form button {
	background: #333;
	color: #fff;
	border: none;
	cursor: pointer;
}
/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table th, table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

table th {
	background: #e0f7fa; /* view.jsp의 테이블 헤더 색 */
	color: #000;
	font-family: 'Noto Sans KR', sans-serif; /* th 태그와 동일한 글씨체 */
	font-weight: bold; /* th 태그와 동일한 글씨 굵기 */
}
/* 페이지네이션 스타일 */
.pagination {
	text-align: center;
	margin-bottom: 20px;
}

.pagination button {
	padding: 10px 20px;
	margin: 5px;
	border: none;
	background: #77a1d3;
	color: #fff;
	border-radius: 5px;
	cursor: pointer;
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
                    <a href="/cleander">연봉계산기</a>
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
                    <li><a href="/boards" class="active">게시판</a></li>
                    <li><a href="/approval"/${user.empno}">전자결재</a></li>
                    <li><a href="/approval/status">결재승인</a></li>
                    <li><a href="/bullboard">익명게시판</a></li>
                    <li><a href="/emp_manage">직원관리</a></li>
                    <li><a href="#">관찰관리</a></li>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            <section class="main-content">
                <!-- 메인 콘텐츠 영역 -->
				<div class="search-form">
					<!-- 검색 폼을 포함하는 요소 -->
					<!-- 제목, 작성자, 날짜로 검색할 수 있는 입력 필드와 검색 버튼이 포함 -->
					<form action="/boards/search" method="get">
						<input type="text" name="title" placeholder="제목으로 검색"> <input
							type="text" name="author" placeholder="작성자로 검색"> <input
							type="date" name="date">
						<button type="submit">검색</button>
					</form>
				</div>
				<table style="width:113.65%;">
				<colgroup>
			<col style="width:10%;" />
			<col />
			<col style="width:12%;" />
			<col style="width:12%;" />
			<col style="width:12%;" />
			<col style="width:12%;" />
		</colgroup>
					<!-- 게시판 목록을 표시하는 테이블 -->
					<thead>
						<!-- thead 영역 (번호 제목 작성자 작성일 조회수가 포함) -->
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<!-- thead 영역 끝 -->
					<tbody>
						<!-- tbody 영역 forEach 태그를 사용하여 boardList 변수에 있는
                			 게시물을 반복하여 테이블 행<tr>으로 표시 -->
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
					<!-- tbody 영역 끝 -->
				</table>
				<!-- 테이블 영역 끝 -->
				<div class="paging">
					<!-- 페이징을 위한 요소 -->
					<div id="page">
						<!-- c:if와 c:forEach 태그를 사용하여
              				 페이지 번호를 표시하고 이전 및 다음 버튼을 제공 -->
						<c:if test="${begin > pageNum }">
							<a href="/boards?p=${begin-1 }" class="page prv">first</a>
						</c:if>
						<c:forEach begin="${begin }" end="${end}" var="i">
							<a href="/boards?p=${i}">${i}</a>
						</c:forEach>
						<c:if test="${end < totalPages }">
							<a href="/boards?p=${end+1}" class="page next">end</a>
						</c:if>
					</div>
				</div>
				<div class="actions">
					<!-- 글쓰기 버튼을 포함하는 요소 -->
					<button onclick="location.href='/boards/write'">글쓰기</button>
					<button onclick="location.href='/boards/write'">공지글작성</button>
				</div>
            </section>
        </main>
    </div>
</body>
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
</html>