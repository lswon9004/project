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
    background-color: #FFFFFF; 
    margin: 0;
    padding: 0;
}

.container {
    width: 900px;
    height: 700px;
    margin: 50px auto;
    background-color: #fff;
    border: 1px solid #000000;
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
    width: 60%;
    box-sizing: border-box;
    margin-right: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid rgba(0, 0, 0, 0.5);
    padding: 10px;
    text-align: center;
}

th {
    background-color: #E0FFFF;
}

.button-container {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}

button {
    padding: 10px 15px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
   
}

button:hover {
    background-color: #005f99;
}

#page {
    text-align: center;
    display: flex;
    justify-content: center;
    margin: 300px;
}

#page a{
     padding: 5px 10px;
     margin: 0 5px; 
     text-decoration: none; 
}


#page a:hover {
    color: #007BFF;
}
</style>
</head>
<body>
        <div class="container">
        <h2>익명 게시판 검색결과</h2>
        <div class="search-container">
        <form action="/search" method="get">
            <input type="text" name="title" placeholder="제목" size=30>
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
                    <th>좋아요</th>
                    <th>싫어요</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="board" items="${boardList}">
                    <tr>
                        <td style="width: 20px;">${board.no}</td>
                        <td style="width: 50px;"><a href="/content/${board.no}">${board.title}</a></td>
                        <td style="width: 50px;">${board.iid}</td>
                        <td style="width: 50px;"><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></td>
                        <td style="width: 50px;">${board.readCount}</td>
                        <td style="width: 50px;">
                        <c:forEach var="likeCount" items="${likeCountList}">
                        		<c:if test="${likeCount.no==board.no}">
                        			<c:if test="${likeCount.count!=null}">
                        				${likeCount.count }
                        			</c:if>
                        			<c:if test="${likeCount.count==null}">
                        				0
                        			</c:if>
                        		</c:if>
                        	</c:forEach> 
                        	</td>
                             <td style="width: 50px;">
                              <c:forEach var="hateCount" items="${hateCountList}">
                        		<c:if test="${hateCount.board_no==board.no}">
                        			<c:if test="${hateCount.count!=null}">
                        				${hateCount.count }
                        			</c:if>
                        			<c:if test="${hateCount.count==null}">
                        				0
                        			</c:if>
                        		</c:if>
                        	</c:forEach>
                       </td> 
                    </tr>
                </c:forEach>
                <c:if test="${count == 0}">
					<tr>
						<td colspan="7" class="tac">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>
            </tbody>
        </table>
        <div class="button-container">
            <button onclick="location.href='bullboard'">목록</button>
        </div>
        <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/search?p=${begin-1 }&title=${title}">[이전]</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/search?p=${i}&title=${title}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/search?p=${end+1}&title=${title}">[다음]</a>
				</c:if>
	    </div>
    </div>
</body>
</html>