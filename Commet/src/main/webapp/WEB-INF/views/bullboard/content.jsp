<%@ page contentType="text/html; charset=UTF-8"%>
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
        <p><input type="text" name="title" value="${board.title}" readonly /></p>
        <p><strong>작성자</strong><input type="text" name="author" value="${board.iid}" readonly /></p>
        <p><strong>작성일</strong><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></p>
        <p><strong>조회수</strong><input type="text" name="readCount" value="${board.readCount +1}" readonly /></p>
         </div>
        
        <textarea name="content" class="textarea-content" readonly>${board.content}</textarea>
        
        <!-- 좋아요 버튼 -->
        <input type="button" id="like-button" data-board-no="${board.no}" value="👍" />
         <span id="like-count">${likeCount}</span>

       <!-- 싫어요 버튼 -->
        <input type="button" id="hate-button" data-board-no="${board.no}" value="👎" />
        <span id="hate-count">${hateCount}</span>
       </form>
        
        <div class="button-box">
           <button onclick="location.href='/bullboard'">목록으로</button>
           <button onclick="location.href='/update/${board.no}'">수정</button>
        </div>  
        <form action="/delete/${board.no}" method="post">
          <label for="password-input">Password:</label>
           <input type="password" id="password-input1" name="password" />
         
         <button type="submit">삭제</button>
     </form>
    
     <!-- 댓글 목록 -->
    <c:forEach var="reply" items="${replies}">
     <form action="/reply/delete" method="post">
    	<input type="hidden" name="cno" value="${reply.cno }">
    	    	<input type="hidden" name="no" value="${board.no }">
    	
        <div class="reply">           
            <p>${reply.content}</p>
               <label for="password-input">Password:</label>
            <input type="password" id="password-input-${reply.id}" name="password"> 
            <button class="delete-reply" data-reply-id="${reply.id}">댓글 삭제</button>
        </div>
         </form>
            </c:forEach>
    
     <!-- 댓글 등록 폼 -->
     <form id="reply-form" action="/content/insert" method="post">
    <!-- id 입력 -->
    <label for="id-input">ID:</label>
    <input type="text" id="id-input" name="id" />
   
    <input type="hidden" name="board_no" value="${board.no}"/>
   
    <!-- password 입력 -->
    <label for="password-input">Password:</label>
    <input type="password" id="password-input2" name="password" />
   
    <!-- content 입력 -->
    <label for="content-input">Comment:</label>
    <input type="text" id="content-input" name="content" />

    <!-- 제출 버튼 -->
    <input type="submit" id="submit-reply" value="Submit reply" />
  </form>
</div>
          
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	boardNo = ${board.no}
	empno = ${user.empno}// 문서가 준비되면 아래의 이벤트 리스너를 활성화
    $('.reply-update-form').on('submit', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작을 막음
        const form = $(this); // 제출된 폼 요소 참조
        const cno = form.find('input[name="cno"]').val(); // 폼에서 댓글 번호(cno)를 가져옴
        const content = form.find('input[name="content"]').val(); // 폼에서 댓글 내용을 가져옴

        $.ajax({ // AJAX 요청을 통해 댓글을 서버에 업데이트
            type: 'POST', // POST 방식으로 요청
            url: '/reply/update', // 이 경로로 요청
            data: { cno: cno, content: content }, // 댓글 번호와 수정된 내용을 서버에 전달
            success: function(response) { // 요청이 성공하면 아래의 수행문 실행
                form.find('input[name="content"]').val(''); // 입력 필드를 초기화
                form.closest('.reply').find('p').text(text); // 댓글 내용을 업데이트
            },
            error: function(error) { // 요청이 실패하면 오류를 콘솔에 출력
                console.log(error); 
            }
        });
    });})
$(document).ready(function() {
    // 좋아요 버튼 클릭 이벤트
    $('#like-button').click(function() {
    	$.getJSON("/bullboard/like",{'no':boardNo,'empno':empno},function(data){
    	      alert(data)         
    })});

    // 싫어요 버튼 클릭 이벤트
    $('#hate-button').click(function() {
    	$.getJSON("/bullboard/hate",{'no':boardNo,'empno':empno},function(data){
  	      alert(data)     

        
        });
    });
});
</script>
</body>
</html>
