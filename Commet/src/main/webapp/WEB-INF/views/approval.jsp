<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management Portal</title>
        <link rel="stylesheet" type="text/css" href="/css/main.css" />
  <style>

.form-container form {
    display: flex;
    flex: 1;
    align-items: center;
}

.form-container form select, 
.form-container form input,
.form-container form button {
    margin-right: 10px;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

button[type="submit"] {
    background: #00bfff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

.form-container button:last-child {
    margin-left: auto;
    background: #00bfff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

        .paging{text-align:center;margin:15px 0;}
		.paging strong{display:inline-block;width:25px;height:25px;line-height:24px;marging-right:5px;border:1px solid #ccc;color:#666;text-align:cetner;}
		.paging .page{display:inline-block;width:25px;height:25px;line-height:24px;margin-right:5px;background:#49be5a;color:#fff;text-align:center;}
       
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
                    <a class="active" href="/main">Home</a>
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/customerList">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a></li>
                    <li><a href="/boards" >게시판</a></li>
                    <li><a href="/approval/${user.empno}" class="active">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=3 }"> <li><a href="/emp_manage">직원관리</a></li></c:if>
                </ul>      
            </aside>
            <section class="main-content">
            <h2>전자결재</h2>
                <div class="status-overview">
                    <div class="form-container">
    <form action="/approval/search" style="flex: 1; display: flex; align-items: center;">
        <label for="approval_no">결재번호:</label>
        <input type="text" id="approval_no" name="approval_no">
        <label for="approval_title">결재 제목:</label>
        <input type="text" id="approval_title" name="approval_title">
        <label for="startDate">작성일:</label>
        <input type="date" id="startDate" name="startDate"> ~
        <input type="date" id="endDate" name="endDate">
        <select name="approval_status1">
            <option>요청</option>
            <option>승인</option>
            <option>대기</option>
            <option>반려</option>
        </select>
        <button type="submit" style="margin-left: 0px;">조회</button>
    </form>
    <button onclick="location.href='/approvalWrite'" style="margin-left: auto;">등록</button>
</div>
    <table>
    	<colgroup>
			<col style="width:10%;" />
			<col />
			<col style="width:12%;" />
			<col style="width:12%;" />
			<col style="width:12%;" />
			<col style="width:12%;" />
		</colgroup>
        <thead>
            <tr>
                <th>결재번호</th>
                <th>결재제목</th>
                <th>결재 종류</th>
                <th>작성일</th>
                <th>작성자</th>
                <th>결재 상태</th>
            </tr>
            	
        </thead>
        <tbody>
            <c:if test="${count == 0}">
					<tr>
						<td colspan="6" class="tac">게시판에 저장된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${count > 0}">
					<c:forEach items="${alist}" var="alist">
						<tr>
							<td>${alist.approval_no }</td>
							<td><a href="/approval/content/${alist.approval_no }">${alist.approval_title }</a></td>
							<td><c:choose>
									<c:when test="${alist.approval_type ==1 }">연차/휴가신청</c:when>
									<c:when test="${alist.approval_type ==2 }">출장신청</c:when>
									<c:when test="${alist.approval_type ==3 }">문서결재</c:when>
									<c:when test="${alist.approval_type ==4 }">비품신청</c:when>
								</c:choose></td>
							<td><fmt:formatDate value="${alist.created_date }" pattern="yyyy.MM.dd" /></td>
							<td>${alist.empno }</td>
							<td>${alist.approval_status1 }</td>
						</tr>
					</c:forEach>
				</c:if>
        </tbody>
    </table>
                </div>
                <div class="paging">
		<div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/approval/${user.empno}?p=${begin-1 }" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/approval/${user.empno}?p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/approval/${user.empno}?p=${end+1}" class="page next">&gt;</a>
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
