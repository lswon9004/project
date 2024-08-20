<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>게시글 수정</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
}

form {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-top: 20px;
    font-weight: bold;
}

input[type="text"], textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    margin-top: 5px;
}

.button-box {
    text-align: right;
    margin-top: 20px;
}

.button-box button {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}

.button-box button:hover {
    background-color: #005f99;
}

</style>
</head>
<body>

<form action="/bullboard/update" method="post"><!-- 폼데이터가 url로 post를 요청 -->
 <input type="hidden" name="no" value="${board.no}" /><!-- 게시글 번호를 숨겨진 필드로 전송 -->
  <label for="iid">작성자</label>
  <input type="text" name="iid" value="${board.iid}" />
  <div>
   <label for="title">제목</label>
   <input type="text" name="title" value="${board.title}" />
   </div>
   <div>
    <label for="content">내용</label>
    <textarea name="content">${board.content}</textarea>
    </div>
    <div class="button-box">
     <button type="submit">수정완료</button>
    </div>
</form>
</body>
</html>
