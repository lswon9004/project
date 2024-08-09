<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>익명게시판 글내용</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
}

container {
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
.details-section {
    border: 1px solid #ddd;
    padding: 15px;
    margin-top: 20px;
    background-color: #f7f7f7;
    border-radius: 4px;
}

.details-section p {
    margin: 5px 0;
}

.textarea-content {
    width: 100%;
    height: 200px;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #ddd;
    margin-top: 20px;
    box-sizing: border-box;
}


button-box {
    text-align: center;
    margin-top: 30px;
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
     <!-- 게시글 내용 표시 -->
     <form action="/content/${board.no}" method="post"> 
      <div class="details-section">
        <h2><input type="text" name="title" value="${board.title}"/></h2>
        <p><strong>작성자</strong><input type="text" name="author" value="${board.iid}" /></p>
        <p><strong>작성일</strong><input type="text" name="date" value="<fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/>" /></p>
        
        <p><strong>조회수</strong><input type="text" name="readCount" value="${board.readCount +1}" /></p>
         </div>
        
        <textarea name="content" class="textarea-content">${board.content}
        </textarea>
        
         <button class="like-button" data-board-no="${board.no}">👍</button>
           <span id="like-count-${board.no}">
              <c:forEach items="${likeList }" var="like">
                <c:if test="${like.no==board.no }">${like.count}</c:if>
                 </c:forEach>
                  </span>
                
                <button class="dislike-button" data-board-no="${board.no}">👎</button>
          <span id="dislike-count-${board.no}">
            <c:forEach items="${hateList}" var="hate">
             <c:if test="${hate.no == board.no }">${hate.count}</c:if>
            </c:forEach>
          </span>            
        </form>
        
        <div class="button-box">
           <button onclick="location.href='/bullboard'">목록으로</button>
        </div>
         
          <!-- 수정버튼 -->
         <div class="button-box">
         <button onclick="location.href='/update/${board.no}'">수정</button>
         </div>
           
            <!-- 삭제 버튼 추가 -->
   <div class="button-box">
   <button onclick="location.href='/bullboard'">삭제</button>
   </div>
   <!-- 댓글 목록 -->
<div id="reply-list">
    <!-- 댓글 목록을 여기에 표시합니다. -->
</div>

<!-- 댓글 작성 폼 -->
<form id="reply-form" action="/content/${board.no}/replies" method="post">
    <textarea name="content" placeholder="댓글을 입력하세요."></textarea>
    <button type="submit">댓글 작성</button>
</form>

<!-- 댓글 수정 폼 (숨김 상태) -->
<form id="reply-edit-form" style="display: none;">
    <input type="hidden" name="cno" />
    <textarea name="content"></textarea>
    <button type="submit">댓글 수정</button>
    <button type="button" id="reply-edit-cancel">취소</button>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 댓글 목록을 가져와서 표시하는 코드를 여기에 작성합니다.

    // 댓글 작성 폼의 제출 이벤트 핸들러
    $("#reply-form").submit(function(e) {
        e.preventDefault();

        var content = $(this).find("textarea[name='content']").val();

        $.ajax({
            url: "/content/${board.no}/replies",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({ content: content }),
            success: function(response) {
                // 댓글 목록을 다시 불러와서 표시하는 코드를 여기에 작성합니다.
            }
        });
    });

    // 댓글 수정 폼의 제출 이벤트 핸들러
    $("#reply-edit-form").submit(function(e) {
        e.preventDefault();

        var cno = $(this).find("input[name='cno']").val();
        var content = $(this).find("textarea[name='content']").val();

        $.ajax({
            url: "/content/${board.no}/reply/" + cno,
            type: "put",
            contentType: "application/json",
            data: JSON.stringify({ content: content }),
            success: function(response) {
                // 댓글 목록을 다시 불러와서 표시하는 코드를 여기에 작성합니다.
            }
        });
    });

    // 댓글 수정 취소 버튼의 클릭 이벤트 핸들러
    $("#reply-edit-cancel").click(function() {
        $("#reply-edit-form").hide();
        $("#reply-form").show();
    });
});
</script>
   

</div>

</body>
</html>
