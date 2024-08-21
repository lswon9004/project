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
    background-color: #ADD8E6;
    width: 90%;
    margin: 20px;
    padding: 20px;
    overflow-x: hidden;
}

.container {
    background-color: white; /* 하얀 바탕색 */
    border: 1px solid rgba(0, 0, 0, 0.5); /* 흐린 실선 테두리 */
    border-radius: 10px; /* 둥근 테두리 */
    padding: 20px; /* 내부 패딩 */
    margin: 10px auto; /* 외부 마진 */
    width: 80%; /* 너비 */
    height: auto; /* 높이 */
}

#detailcontent {
    border: 1px solid rgba(0, 0, 0, 0.5); /* 테두리 추가 */
}

.details-section, .content-display {
   
    margin-bottom: 10px; /* 각 섹션 사이에 마진 추가 */
    background-color:white;
    position: auto; /* 위치를 상대적으로 설정 */
    font-size: 20px;
    
}

.content-display {
    top: -1px; /* 위치를 위로 1px 이동 */
}

h1 {
    font-family: 'Courier New', monospace; /* 폰트 변경 */
    text-align: center;
    color: blue;
    background-color: yellow;
    font-size: 30px;
}

p {
    color: #333; /* 텍스트 색상 변경 */
    padding: 10px; /* 패딩 추가 */
    text-align: left; /* 텍스트 정렬 변경 */
    display: inline-block; /* p 태그를 나란히 정렬 */
}

#like-button {
    background-color: lightblue; /* 좋아요 버튼의 색상을 연한 파랑으로 설정 */
    border-radius: 5px; /* 테두리를 둥글게 설정 */
    border: none;
    margin: 5px;
    padding: 10px 20px; /* 버튼 크기를 크게 설정 */
}

#hate-button {
    background-color: lightcoral; /* 싫어요 버튼의 색상을 연한 빨강으로 설정 */
    border-radius: 5px; /* 테두리를 둥글게 설정 */
    border: none;
    margin: 5px;
    padding: 10px 20px; /* 버튼 크기를 크게 설정 */
}

#input1, #input2 {
    /* 원하는 스타일을 여기에 추가하세요. 예를 들어: */
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
}

.reply {
    /* 원하는 스타일을 여기에 추가하세요. 예를 들어: */
    border: 1px solid rgba(0, 0, 0, 0.5);
    padding: 10px;
    margin-bottom: 10px;
    background-color: #f2f2f2;
    
}

.delete-reply {
    margin-left: 10px; /* 요소들 사이의 간격을 10px로 설정 */
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}

#reply-form {
    display: flex;
    justify-content: flex-end; /* 요소를 중앙으로 정렬 */
}

#id-input, #password-input2, #content-input {
     display: flex;
    justify-content: flex-end; /* 요소를 오른쪽으로 정렬 */
   
}

#submit-reply {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    margin: 5px;

}

#content-del, #password-input1 {
    display: flex;
    justify-content: flex-end; /* 요소를 오른쪽으로 정렬 */
    margin: 5px;
     
}

.condel {
   margin-left: 10px; /* 요소들 사이의 간격을 10px로 설정 */
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;

}



.button-box {
    display: flex;
    justify-content: center; /* 요소를 가운데로 정렬 */
}

.button-box button {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}

#pw {
    display: flex; /* 블록 요소로 설정 */
    margin-bottom: 10px; /* 아래쪽 마진 추가 */
    justify-content: center; 
}

.button-box2 {
    display: flex;
    justify-content: flex-end; /* 요소를 오른쪽으로 정렬 */
}

.button-box2 input {
  margin:5px;

}

.button-box2 button {
    margin-left: 10px; /* 요소들 사이의 간격을 10px로 설정 */
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}
</style>
</head>
<body>
    <div class="container">
     <!-- 게시글 내용 표시 -->
     <form action="/content/${board.no}" method="post" id="detailcontent"> 
      
      <div class="details-section">
      <h1>${board.title}</h1>
       <p><strong>작성자 </strong>${board.iid}</p>
       <p><strong>작성일 </strong><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></p>
       <p><strong>조회수 </strong>${board.readCount +1}</p>
       </div>
        <hr>
         <div class="content-display">
         <p>${board.content}</p>
         </div>
       
       <br>
       <div style="display: flex; justify-content: center; align-items: center; gap:5px;">
        <input type="button" id="like-button" data-board-no="${board.no}" value="👍" /><!-- 좋아요 버튼 -->
         <span id="like-count">${likeCount}</span>
        <input type="button" id="hate-button" data-board-no="${board.no}" value="👎" /><!-- 싫어요 버튼 -->
        <span id="hate-count">${hateCount}</span>
        </div>
       </form>
       <br>
     
     <!-- 댓글 목록 -->
    <c:forEach var="reply" items="${replies}">
     <form action="/reply/delete" method="post">
    	<input id="input1" type="hidden" name="cno" value="${reply.cno }">
    	<input id="input2" type="hidden" name="no" value="${board.no }">
        <div class="reply">
           <p>${reply.id}</p>           
            <p>${reply.content}</p>
             <label for="password-input">Password</label>
            <input type="password" id="password-input-${reply.id}" name="password"> 
            <button class="delete-reply" data-reply-id="${reply.id}">댓글 삭제</button>
        </div>
       </form>
    </c:forEach>
    <br>
    
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
   <br>
        
    <form id="content-del" action="/delete/${board.no}" method="post">
      <label for="password-input"></label>
       <input type="password" id="password-input1" name="password" />
       <button class="condel" type="submit">글삭제</button>
     </form>
        <br>
     
      <div class="button-box2">

      <input id="pw" type="password"/>
      <button onclick="update()">수정</button>
      </div>  
      <hr>
    
    <div class="button-box">
      <button onclick="location.href='/bullboard'">목록</button>
    </div>
  
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
