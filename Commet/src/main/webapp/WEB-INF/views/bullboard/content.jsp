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
        <h2><input type="text" name="title" value="${board.title}" readonly/></h2>
        <p><strong>작성자</strong><input type="text" name="author" value="${board.iid}" readonly /></p>
        <p><strong>작성일</strong><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></p>
        <p><strong>조회수</strong><input type="text" name="readCount" value="${board.readCount +1}" readonly /></p>
         </div>
        
        <textarea name="content" class="textarea-content" readonly>${board.content}</textarea>
        
        <div class="like-dislike-box">
         <button type="button" class="like-button" data-board-no="${board.no}">👍</button>
           <span id="like-count-${board.no}">
              <c:forEach items="${likeList }" var="like">
                <c:if test="${like.no==board.no }">${like.count}</c:if>
                 </c:forEach>
                  </span>
                
                <button type="button" class="dislike-button" data-board-no="${board.no}">👎</button>
                <span id="dislike-count-${board.no}">
                 <c:forEach items="${hateList}" var="hate">
                  <c:if test="${hate.no == board.no }">${hate.count}</c:if>
                    </c:forEach>
                 </span>  
         </div>          
        </form>
        
        <div class="button-box">
           <button onclick="location.href='/bullboard'">목록으로</button>
           <button onclick="location.href='/update/${board.no}'">수정</button>
             <button onclick="location.href='/delete/${board.no}'">삭제</button>
     </div>
        
        
   <!-- 댓글 목록 -->
<div id="reply-list">
    <!-- 댓글 목록을 여기에 표시합니다. -->
</div>

<!-- 댓글 작성 폼 -->
<form id="reply-form" action="/content/${board.no}/replies" method="post">
    <textarea name="content" placeholder="댓글을 입력하세요." required></textarea>
    <button type="submit">댓글 작성</button>
</form>

<!-- 댓글 수정 폼 (숨김 상태) -->
<form id="reply-edit-form" style="display: none;">
    <input type="hidden" name="cno" />
    <textarea name="content" required></textarea>
    <button type="submit">댓글 수정</button>
    <button type="button" id="reply-edit-cancel">취소</button>
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 댓글 목록 로드
    function loadReplies() {
        $.ajax({
            url: "/content/${board.no}/replies",
            type: "get",
            success: function(response) {
                $("#reply-list").html(response);
            }
        });
    }

    // 초기 댓글 목록 로드
    loadReplies();

    // 댓글 작성
    $("#reply-form").submit(function(e) {
        e.preventDefault();
        var content = $(this).find("textarea[name='content']").val();

        $.ajax({
            url: "/content/${board.no}/replies",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify({ content: content }),
            success: function(response) {
                loadReplies();
                $("#reply-form textarea[name='content']").val('');  // 입력 폼 초기화
            }
        });
    });

    // 댓글 수정
    $(document).on("click", ".reply-edit-button", function() {
        var cno = $(this).data("cno");
        var content = $(this).data("content");

        $("#reply-edit-form").find("input[name='cno']").val(cno);
        $("#reply-edit-form").find("textarea[name='content']").val(content);

        $("#reply-form").hide();
        $("#reply-edit-form").show();
    });

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
                loadReplies();
                $("#reply-edit-form").hide();
                $("#reply-form").show();
            }
        });
    });

    // 댓글 수정 취소
    $("#reply-edit-cancel").click(function() {
        $("#reply-edit-form").hide();
        $("#reply-form").show();
    });

    // 댓글 삭제
    $(document).on("click", ".reply-delete-button", function() {
        var cno = $(this).data("cno");
        var password = prompt("댓글 비밀번호를 입력하세요:");

        if (password != null && password !== "") {
            $.ajax({
                url: "/content/${board.no}/reply/" + cno + "/delete",
                type: "delete",
                contentType: "application/json",
                data: JSON.stringify({ password: password }),
                success: function(response) {
                    loadReplies();
                }
            });
        }
    });
});
</script>

</div>

</body>
</html>
