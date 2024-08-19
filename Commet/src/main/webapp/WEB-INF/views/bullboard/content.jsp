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

.container {
    max-width: 90%;
    margin: 50px auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}
.details-section {
    width: 90%;
    height: auto;
    /* 기타 스타일 */
}

.textarea-content {
   background-color: #ffffff; /* 배경색 설정 */
    border: 1px solid #ddd; /* 테두리 설정 */
    border-radius: 4px; /* 테두리 둥글게 설정 */
    padding: 10px; /* 내부 패딩 설정 */
    margin-bottom: 20px; /* 아래쪽 마진 설정 */
}


.button-box {
    width: 50%;
    height: auto;
    /* 기타 스타일 */
}

h2 {
    text-align: center;
    color: #333;
}

form {
    display: flex;
    flex-direction: column;
    margin-top: 20px;
    width: 90%;
    height: auto;
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
input[type="text"], input[type="password"] {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 80%; /* 너비를 80%로 설정 */
    height: 40px; /* 높이를 40px로 설정 */
    box-sizing: border-box;
    margin-top: 5px;
}
input[type="button"] {
    width: 50px; /* 버튼의 너비를 100px로 설정 */
    height: 25px; /* 버튼의 높이를 50px로 설정 */
    /* 기타 스타일 */
}
</style>

</head>
<body>
    <div class="container">
     <!-- 게시글 내용 표시 -->
     <form action="/content/${board.no}" method="post"> 
      
      <div class="details-section">
      <h1>${board.title}</h1>
       <p><strong>작성자: </strong>${board.iid}</p>
       <p><strong>작성일: </strong><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></p>
       <p><strong>조회수: </strong>${board.readCount +1}</p>
        </div>
         <div class="textarea-content">
         <p>${board.content}</p>
         </div>
        <!-- 좋아요 버튼 -->
        <input type="button" id="like-button" data-board-no="${board.no}" value="👍" />
         <span id="like-count">${likeCount}</span>

       <!-- 싫어요 버튼 -->
        <input type="button" id="hate-button" data-board-no="${board.no}" value="👎" />
        <span id="hate-count">${hateCount}</span>
       </form>
        
        <div class="button-box">
           <button onclick="location.href='/bullboard'">목록으로</button>
           <button onclick="update()">수정</button>
           <input id="pw" type="password">
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
           <p>${reply.id}</p>           
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
    		$('#like-count').text(data);    
    })});

    // 싫어요 버튼 클릭 이벤트
    $('#hate-button').click(function() {
    	$.getJSON("/bullboard/hate",{'no':boardNo,'empno':empno},function(data){
    	      $('#hate-count').text(data);       
        });
    });

});
function update(){
	pw = $('#pw').val()
	$.getJSON("/pwCheck/"+boardNo,{'pw':pw},function(data){
		if(data!="/"){
			location.href=data
		}else{
			alert('비밀번호 틀림')
		}
	})
}
</script>
</body>
</html>
