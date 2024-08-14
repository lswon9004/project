<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>익명게시판 글목록</title>
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

    h2, th, td {
        text-align: center;
    }

    h2, button {
        color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
    }

    th {
        background-color: #f4f4f4;
    }

    input[type="text"] {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: 100%;
        box-sizing: border-box;
    }

    .search-container {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
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
        <h2>익명 게시판</h2>
        <div class="search-container">
        <form action="/search" method="get">
            <input type="text" name="title" placeholder="제목" size=10>
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
            
            <c:if test="${count == 0 }">
             <tr>
               <td colspan="7">아직 입력한 글이 없습니다.</td>
			 </tr>
			</c:if>
			
			<c:if test="${count != 0 }">
                <c:forEach var="board" items="${boardList}">   
                    <tr>
                        <td>${board.no}</td>
                          <!-- 게시글 제목에 하이퍼링크 추가 -->
                        <td><a href="/content/${board.no}">${board.title}</a></td>
                        <td>${board.iid}</td>
                        <td><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></td>
                        <td>${board.readCount}</td>
                        <td>
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
                        <td>
                        <c:forEach var="hateCount" items="${hateCountList}">
                        		<c:if test="${hateCount.no==board.no}">
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
               </c:if>
            </tbody>
        </table>
        
        <div class="button-container">
            <button onclick="location.href='/write'">글쓰기</button>
        </div>
        <!-- 페이지 네비게이션 -->
        <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/bullboard?p=${begin-1 }">[이전]</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/bullboard?p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/bullboard?p=${end+1}">[다음]</a>
				</c:if>
			</div>
    </div>
</body>
</html>
