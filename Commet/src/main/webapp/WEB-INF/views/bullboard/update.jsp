<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 수정</title>
</head>
<body>
<%-- 수정할 게시글의 데이터를 불러오는 부분 --%>
<form action="/bullboard/update" method="post">
	<input type="hidden" name="no" value="${board.no}" />
    <input type="text" name="iid" value="${board.iid}" />
    <div>
        <label for="title">제목:</label>
        <input type="text" name="title" value="${board.title}" />
    </div>
    <div>
        <label for="content">내용:</label>
        <textarea name="content">${board.content}</textarea>
    </div>
     <div>
        <label for="password">비밀번호:</label>
        <input type="password" name="password" value="${board.password}"/>
    </div>
     <!-- 수정 완료버튼 -->
         <div class="button-box">
         <button>수정완료</button>
         </div>
</form>
</body>
</html>
