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
    background-color: #FFFFFF; 
    margin: 0;
    padding: 0;
}

.container {
    width: 900px;
    height: 700px;
    margin: 50px auto;
    background-color: #fff;
    border: 3px solid #000000;
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
    margin: 20px; /* 마진 조정 */
    padding: 20px; /* 패딩 추가 */
    border: 1px solid #ddd; /* 테두리 추가 */
    background-color: #F0F0F0;  /* 배경색 변경 */
}


label {
    margin-top: 10px;
    font-weight: bold;
    width: 100%;
}
.label-title {
    font-size: 1.2em; /* 제목 레이블의 크기를 조정 */
    width: 200px; /* 너비 설정 */
    height: 30px; /* 높이 설정 */
    /* 기타 스타일 */
}

.label-iid {
    font-size: 1.1em; /* 작성자 레이블의 크기를 조정 */
    width: 200px; /* 너비 설정 */
    height: 30px; /* 높이 설정 */
    /* 기타 스타일 */
}

.label-content {
    font-size: 1.3em; /* 내용 레이블의 크기를 조정 */
    width: 200px; /* 너비 설정 */
    height: 30px; /* 높이 설정 */
    /* 기타 스타일 */
}

.label-password {
    font-size: 1.1em; /* 비밀번호 레이블의 크기를 조정 */
    width: 200px; /* 너비 설정 */
    height: 30px; /* 높이 설정 */
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
.ck.ck-editor{

        width: 100%;
        }
        .ck-editor__editable {
           height: 200px;
        }
</style>
</head>
<body>
    <div class="container">
        <h2>익명게시글 작성</h2>
        <form action="/save" method="post" enctype="multipart/form-data">
            <label class="label-title">제목</label>
            <input type="text" name="title" value="${board.title}" required placeholder="제목을 입력하세요"/>
            <!-- 임시 작성자 기능 -->
            <label class="label-iid">작성자</label>
            <input type="text" name="iid" required placeholder="작성자을 입력하세요"/>
            <label class="label-content">내용</label>
            <textarea id="editor" name="content" rows="10" placeholder="내용을 입력하세요">${board.content}</textarea>
            <label class="label-password">비밀번호</label>
            <input type="password" name="password" required placeholder="비밀번호를 입력하세요"/>
            <!-- 저장 및 닫기 버튼 기능 -->
              <div style="display: flex-end;">
            <button type="submit">저장</button> 
            <button type="button" onclick="location.href='close'">닫기</button>
            </div>
        </form>
    </div>  
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    
    <script>
    ClassicEditor.create(document.querySelector('#editor'), {
        language: "ko",
        ckfinder: { uploadUrl: 'http://localhost:8083/img/upload' }
    }).then(editor => {
        window.editor = editor;
    }).catch(error => {
        console.error(error);
    });
    </script>   
</body>
</html>
