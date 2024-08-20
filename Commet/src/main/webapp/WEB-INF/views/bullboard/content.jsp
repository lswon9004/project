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
    width: 90%;
    margin: 20px; /* 마진을 20px로 조정 */
    padding: 20px; /* 패딩을 20px로 조정 */
    overflow-x: hidden; /* 가로 스크롤을 없애는 코드 */
    
}

.container {
    max-width: 95%;
    margin: 50px auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 10px;
}
.details-section {
    width: 90%;
    height: auto;
    /* 기타 스타일 */
}

.textarea-content {
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    background-color: #ffffff;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin: 10px;
}

.textarea-content p {
    margin: 50px;
    padding: 10;
    font-size: 16px;
    line-height: 1.5;
    color: #333;
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
.button-box {
    display: flex;
    flex-direction: left;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin: 30px;
}

.button-box button {
    padding: 10px 20px;
    font-size: 16px;
    color: #fff;
    background-color: #007bff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.button-box button:hover {
    background-color: #0056b3;
}

.button-box #pw {
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button[type="submit"] {
    width:70px; 
    height: 30px; 
    margin: 10px;
    background-color: #4CAF50;
     color: white; 
}



input[type="text"], input[type="password"] {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 100px; 
    height: 30px; 
    box-sizing: border-box;
    margin-top: 5px;
}
input[type="button"] {
    width: 50px; 
    height: 25px; 
    margin-right: 10px;
    background-color: blue;
   
}
#like-button{
    display: inline-block;
    text-align: center;
    background-color: blue;
}
#like-count{
   display: inline-block;
    text-align: center;
}
#hate-button{
    display: inline-block;
    text-align: center;
    background-color: red;
}
 #hate-count{
    display: inline-block;
    text-align: center;
 }
 
#submit-reply {
    width: 90px; 
    height: 30px; 
    margin: 10px;
    color: white; 
    background-color: #4CAF50; 
}
.delete-reply {
    background-color: #ff0000; /* 버튼의 배경색을 빨간색으로 설정 */
    color: white; /* 버튼의 글씨 색상을 흰색으로 설정 */
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
       
       <div style="display: flex; justify-content: center; align-items: center;">
        <input type="button" id="like-button" data-board-no="${board.no}" value="👍" /><!-- 좋아요 버튼 -->
         <span id="like-count">${likeCount}</span>
        </div>
       <div style="display: flex;  justify-content: center; align-items: center;">
        <input type="button" id="hate-button" data-board-no="${board.no}" value="👎" /><!-- 싫어요 버튼 -->
        <span id="hate-count">${hateCount}</span>
        </div>
       </form>
        
        <div class="button-box">
           <button onclick="location.href='/bullboard'">목록</button>
           <button onclick="update()">수정</button>
           <input id="pw" type="password">
        </div>
       
        
        <form action="/delete/${board.no}" method="post">
          <label for="password-input">Password</label>
           <input type="password" id="password-input1" name="password" />
          <button type="submit">글삭제</button>
        </form>
    
     <!-- 댓글 목록 -->
    <c:forEach var="reply" items="${replies}">
     <form action="/reply/delete" method="post">
    	<input type="hidden" name="cno" value="${reply.cno }">
    	<input type="hidden" name="no" value="${board.no }">
    	
        <div class="reply">
           <p>${reply.id}</p>           
            <p>${reply.content}</p>
             <label for="password-input">Password</label>
            <input type="password" id="password-input-${reply.id}" name="password"> 
            <button class="delete-reply" data-reply-id="${reply.id}">댓글 삭제</button>
        </div>
       </form>
    </c:forEach>
    
     <!-- 댓글 등록 폼 -->
     <form id="reply-form" action="/content/insert" method="post">
    <!-- id 입력 -->
     <div style="display: flex; align-items: center;">
    <label for="id-input">작성자 </label>
    <input type="text" id="id-input" name="id" />
    </div>
   
    <input type="hidden" name="board_no" value="${board.no}"/>
   
    <!-- password 입력 -->
    <div style="display: flex; align-items: center;">
    <label for="password-input">암호 </label>
    <input type="password" id="password-input2" name="password" />
    </div>
    
    <!-- content 입력 -->
    <div style="display: flex; align-items: center;">
    <label for="content-input">댓글 </label>
    <input type="text" id="content-input" name="content" />
     </div>
    
    <!-- 제출 버튼 -->
    <input type="submit" id="submit-reply" value="댓글 등록" />
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
