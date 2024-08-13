<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>익명게시판 글쓰기</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
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

form {
    display: flex;
    flex-direction: column;
    margin-top: 20px;
}

label {
    margin-top: 10px;
    font-weight: bold;
}

input[type="text"], input[type="password"], textarea {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
    margin-top: 5px;
}

button {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    margin-top: 20px;
    align-self: flex-end;
}

button:hover {
    background-color: #005f99;
}  
</style>
   <!-- 스마트에디터 라이브러리 추가 -->
    <script type="text/javascript" src="/smarteditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
    <div class="container">
        <h2>익명 게시판 글쓰기</h2>
        <form action="/save" method="post" enctype="multipart/form-data">
            <label>제목</label>
            <input type="text" name="title" value="${board.title}" required>
            <!-- 임시 작성자 기능 -->
            <label>작성자</label>
            <input type="text" name="iid" required>
            <label>내용</label>
             <!-- 스마트에디터 적용 -->
            <textarea name="content" rows="10" required>${board.content}</textarea>
            <label>비밀번호</label>
            <input type="password" name="password" required>
            <!-- 저장 및 닫기 버튼 기능 -->
            <button type="submit">저장</button> 
            <button type="button" onclick="location.href='close'">닫기</button>
        </form>
    </div>     
</body>
</html>
