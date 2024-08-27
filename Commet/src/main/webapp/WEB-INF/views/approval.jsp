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
   
        </style>
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
            <h2>전자결재</h2>
            <div class="header-line"></div>
                <div class="status-overview">
                    <div class="form-container">
    <form action="/approval/search">
        <label for="approval_no">결재번호:</label>
        <input type="number" id="approval_no" name="approval_no">
        <label for="approval_title">결재 제목:</label>
        <input type="text" id="approval_title" name="approval_title">
        <label for="startDate">작성일:</label>
        <input type="date" id="startDate" name="startDate"> ~
        <input type="date" id="endDate" name="endDate">
        <select class="cbutton" name="approval_status1" style="width: 70px;">
            <option class="dropdown">요청</option>
            <option class="dropdown">승인</option>
            <option class="dropdown">대기</option>
            <option class="dropdown">반려</option>
        </select>
        <button type="submit">조회</button>
    </form>
    <button onclick="location.href='/approvalWrite'">등록</button>
</div>
    <table>
        <thead>
            <tr>
                <th>결재번호</th>
                <th>결재제목</th>
                <th>결재 종류</th>
                <th>작성일</th>
                <th>담당자</th>
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
							<td><c:forEach items="${ename }" var="ename">
								<c:if test="${alist.approver1_empno ==ename.empno }">
								${ename.ename }/
								</c:if>
								</c:forEach>
								<c:forEach items="${ename }" var="ename">
								<c:if test="${alist.approver2_empno ==ename.empno }">
								${ename.ename }
								</c:if>
								</c:forEach> </td>
							<td>${alist.approval_status1 }/${alist.approval_status2 }</td>
						</tr>
					</c:forEach>
				</c:if>
        </tbody>
    </table>
                </div>
                <div class="pagination">
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
 empno = ${user.empno};
 deptno = ${user.deptno};
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
<script type="text/javascript" src="/js/main.js"></script>
</html>
