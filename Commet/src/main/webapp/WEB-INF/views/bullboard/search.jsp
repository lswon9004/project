<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>익명게시판 검색결과</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 50px auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

h2 {
    text-align: center;
    color: #333;
}

.search-container {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.search-container input[type="text"] {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
    margin-right: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

th {
    background-color: #f4f4f4;
}

.button-container {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
}

button {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}

button:hover {
    background-color: #005f99;
}
</style>
</head>
<body>
        <div class="container">
        <h2>익명 게시판 검색결과</h2>
        <div class="search-container">
        <form action="/search" method="get">
            <input type="text" name="title" placeholder="제목">
            <button type="submit">검색</button>
        </form>
        </div>
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
            <tbody>
                <c:forEach var="board" items="${boardList}">
                    <tr>
                        <td>${board.no}</td>
                        <td><a href="/content/${board.no}">${board.title}</a></td>
                        <td>${board.iid}</td>
                        <td><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></td>
                        <td>${board.readCount}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="button-container">
            <button onclick="location.href='bullboard'">목록으로</button>
        </div>
    </div>
</body>
</html>