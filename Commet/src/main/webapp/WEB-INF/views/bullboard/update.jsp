<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>게시글 수정</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #ADD8E6; 
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
    margin: 50px auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

h2 {
    text-align: center;
}

form {
    display: flex;
    flex-direction: column;
    margin: 20px; /* 마진 조정 */
    padding: 20px; /* 패딩 추가 */
    border: 1px solid #ddd; /* 테두리 추가 */
    background-color: #F0F0F0;  /* 배경색 변경 */
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
<div class="container">
<h2>익명게시글 수정</h2>
 <form action="/bullboard/update" method="post" style="background-color: #F0F0F0;"><!-- 폼데이터가 url로 post를 요청 -->
 <input type="hidden" name="no" value="${board.no}" /><!-- 게시글 번호를 숨겨진 필드로 전송 -->
  <label for="iid">작성자</label>
  <input type="text" name="iid" value="${board.iid}" placeholder="작성자를 입력하세요" />
  <div>
   <label for="title">제목</label>
   <input type="text" name="title" value="${board.title}" placeholder="제목을 입력하세요" />
   </div>
   <div>
    <label for="content">내용</label>
    <textarea name="content" placeholder="내용을 입력하세요">${board.content}</textarea>
    </div>
    <div class="button-box">
     <button type="submit">수정완료</button>
    </div>
 </form>
</div>
</body>
</html>
