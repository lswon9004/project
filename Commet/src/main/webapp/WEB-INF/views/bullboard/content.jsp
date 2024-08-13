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
        </div>  
        <form action="/delete/${board.no}" method="post">
         <button type="submit">삭제</button>
     </form>
       <div class="container">
        <h2>Replies</h2>
        <div id="rList">
            <c:forEach var="reply" items="${replies}">
                <div class="reply">
                    <p><strong>${reply.cno}</strong></p>
                    <p>${reply.content}</p>
                    <p>${reply.board_no}</p>
                </div>
            </c:forEach>
        </div> 
    </div>
     <!-- New Reply Form -->
            <textarea id="new-reply-content"></textarea>
            <button id="add-reply" data-board-no="${board.no}">등록</button>
        </div>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() { // 문서가 준비되면 아래의 이벤트 리스너를 활성화
    $('.comment-update-form').on('submit', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작을 막음
        const form = $(this); // 제출된 폼 요소 참조
        const cno = form.find('input[name="cno"]').val(); // 폼에서 댓글 번호(cno)를 가져옴
        const text = form.find('input[name="text"]').val(); // 폼에서 댓글 내용을 가져옴

        $.ajax({ // AJAX 요청을 통해 댓글을 서버에 업데이트
            type: 'POST', // POST 방식으로 요청
            url: '/comments/update', // 이 경로로 요청
            data: { cno: cno, text: text }, // 댓글 번호와 수정된 내용을 서버에 전달
            success: function(response) { // 요청이 성공하면 아래의 수행문 실행
                form.find('input[name="text"]').val(''); // 입력 필드를 초기화
                form.closest('.comment').find('p').text(text); // 댓글 내용을 업데이트
            },
            error: function(error) { // 요청이 실패하면 오류를 콘솔에 출력
                console.log(error); 
            }
        });
    });

    $('#likeForm button').on('click', function(e) { // 추천 버튼이 클릭될 때 실행할 코드를 정의
        e.preventDefault(); // 기본 버튼 클릭 동작을 막음
        const button = $(this); // 클릭된 버튼 요소를 참조
        const form = button.closest('form'); // 버튼이 속한 폼 요소 참조
        const empno = form.find('input[name="empno"]').val(); // 폼에서 직원 번호를 가져옴
        const no = form.find('input[name="no"]').val(); // 폼에서 게시글 번호를 가져옴
        const url = form.attr('action'); // 폼의 액션 URL을 사져옴

        $.ajax({ // AJAX 요청을 통해 추천 상태를 서버에 전송
            type: 'POST', // POST 방식으로 요청
            url: url, // 폼의 액션 URL로 요청
            data: { empno: empno, no: no }, // 직원 번호와 게시글 번호를 서버에 전달
            success: function(response) { // 요청이 성공하면 아래의 수행문 실행
                $('#likeCount').text(response.likeCount); // 추천수를 업데이트된 값으로 변경
                form.attr('action', response.newUrl); // 폼의 액션 URL을 새로운 URL로 변경
                // 버튼 텍스트를 업데이트
                button.find('.heart-icon').text(response.action === "unlike" ? '💔' : '❤');
            },
            error: function(error) { // 요청 실패시 오류를 콘솔에 출력
                console.log(error);
            }
        });
    });
});
</script>
</body>
</html>
