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
				<h2>결재승인</h2>
				<div class="header-line"></div>
                <div class="status-overview">
                    <div class="form-container">
        <form action="/approval/status/search">
        <label for="empno">결제번호:</label>
        <input type="hidden" name="approval_empno" value="${user.empno }">
        <input type="number" id="empno" name="empno" value="">
        <label for="approval_title">결재 제목:</label>
        <input type="text" id="approval_title" name="approval_title">
        <label for="startDate">작성일:</label>
        <input type="date" id="startDate" name="startDate">~
        <input type="date" id="endDate" name="endDate">
       <select class="cbutton" name="approval_status1" style="width: 70px">
								<option class="dropdown">분류</option>
								<option class="dropdown">요청</option>
								<option class="dropdown">승인</option>
								<option class="dropdown">대기</option>
								<option class="dropdown">반려</option>
							</select>
							<button>조회</button>
						</form>
    </div>
    <table>
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
						<td colspan="6" class="tac">결재 목록이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${count > 0}">
					<c:forEach items="${alist}" var="alist">
						<tr>
							<td>${alist.approval_no }</td>
							<td><a href="/approval/statusForm/${alist.approval_no }">${alist.approval_title }</a></td>
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
                <div class="pagination">
		<div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/approval/search?p=${begin-1 }&approval_no=${approval_no}&approval_title=${approval_title}&approval_status1=${approval_status1}&startDate=${startDate}&endDate=${endDate}" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/approval/search?p=${i}&approval_no=${approval_no}&approval_title=${approval_title}&approval_status1=${approval_status1}&startDate=${startDate}&endDate=${endDate}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/approval/search?p=${end+1}&approval_no=${approval_no}&approval_title=${approval_title}&approval_status1=${approval_status1}&startDate=${startDate}&endDate=${endDate}" class="page next">&gt;</a>
				</c:if>
			</div>
		</div>
            </section>
        </main>
    </div>
</body>
</html>