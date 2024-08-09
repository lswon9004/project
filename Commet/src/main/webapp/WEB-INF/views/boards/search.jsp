<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
/* 각 HTML 요소에 대한 스타일 코드 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}
.container {
    width: 90%;
    margin: auto;
    overflow: hidden;
}
header {
    background: #e0f7fa;
    color: #000;
    padding: 20px 0;
    border-bottom: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.user-info {
    display: flex;
    align-items: center;
    margin-left: 20px;
}
.user-info p {
    margin: 0;
    padding: 0;
}
h1 {
    margin: 0;
    padding: 0;
    font-size: 24px;
}
.logout a {
    color: #00796b;
    text-decoration: none;
    font-size: 16px;
    margin-right: 20px;
}
nav {
    margin-top: 20px;
    background: #333;
    color: #fff;
}
nav ul {
    padding: 0;
    list-style: none;
    display: flex;
    justify-content: space-around;
}
nav ul li {
    display: inline;
    margin: 0;
}
nav ul li a {
    color: #fff;
    text-decoration: none;
    padding: 15px 20px;
    display: inline-block;
}
nav ul li a:hover, .active {
    background: #77a1d3;
}
main {
    display: flex;
    margin-top: 20px;
}
aside {
    width: 25%;
    padding: 20px;
    background: #fafafa;
    border-right: 1px solid #ddd;
}
aside .menu {
    padding: 0;
    list-style: none;
}
aside .menu li {
    margin-bottom: 10px;
}
aside .menu li a {
    color: #00796b;
    text-decoration: none;
    display: block;
    padding: 10px;
    background: #f9f9f9;
    border-radius: 5px;
}
aside .menu li a.active, aside .menu li a:hover {
    background: #77a1d3;
    color: #fff;
    text-decoration: underline;
}
aside .footer-text {
    margin-top: 20px;
    color: #777;
    font-size: 14px;
}
.main-content {
    width: 75%;
    padding: 20px;
    background: #fff;
}
.actions {
    text-align: right;
    margin-bottom: 20px;
}
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
<!-- 페이지의 컨테이너를 정의하고  사용자의 번호를 표시하고, 로그아웃 링크를 추가 -->
<div class="container">
    <header> 
        <h1>${user.empno}</h1>
        <a href="/logout" class="logout">로그아웃</a>
    </header>
    <!-- 사이드바를 정의하고 다양한 메뉴 항목을 추가. 현재 시간을 표시하는 텍스트 추가 -->
    <main>
        <aside>
            <ul class="menu">
                <li><a href="#">통합업무</a></li>
                <li><a href="/boards" class="active">게시판</a></li>
                <li><a href="#">익명게시판</a></li>
                <li><a href="/approval">전자결재</a></li>
                <li><a href="#">직원관리</a></li>
                <li><a href="#">팀장전자결재</a></li>
                <li><a href="#">캘린더</a></li>
                <li><a href="#">권한관리</a></li>
            </ul>
            <p class="footer-text">현재시간 : 2024/07/29 수요일 09:15</p>
            <p class="footer-text">코멧업무포털</p>
        </aside> <!-- 사이드바 영역 끝 -->
        <!-- 제목 작성자 날짜로 검색할 수 있는 입력 필드와 검색 버튼을 포함하는 검색 폼을 정의 -->
        <section class="main-content">
            <div class="search-form">
                <form action="/boards/search" method="get">
                    <input type="text" name="title" placeholder="제목으로 검색">
                    <input type="text" name="author" placeholder="작성자로 검색">
                    <input type="date" name="date">
                    <button type="submit">검색</button>
                </form>
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
            <div class="paging">
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
            <div class="actions"> <!-- 글쓰기 버튼을 포함하는 요소 -->
                <button onclick="location.href='/boards/write'">글쓰기</button>
                <button onclick="location.href='/boards/write'">공지글작성</button>
            </div>
        </section>
    </main>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>