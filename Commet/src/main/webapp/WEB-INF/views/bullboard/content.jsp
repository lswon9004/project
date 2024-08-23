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
    background-color: white; 
    border: 1px solid rgba(0, 0, 0, 0.5); 
    border-radius: 10px; 
    padding: 30px; 
    margin: 20px auto; 
    width: 60%; 
    height: 70%; 
    overflow: auto;
    
}

#detailcontent {
    border: 1px solid rgba(0, 0, 0, 0.5); 
}

.details-section, .content-display {
   
    margin-bottom: 10px; 
    background-color:white;
    position: auto; 
    font-size: 20px;
    
}

.content-display {
    top: -1px; 
}

h1 {
    font-family: Arial, sans-serif; 
    text-align: center;
    color: black;
    font-size: 30px;
    font-weight: bold;
}

p {
    color: #333; 
    padding: 10px; 
    text-align: left; 
    display: inline-block;
}

#like-button {
    background-color: red; 
    border-radius: 5px; 
    border: none;
    margin: 5px;
    padding: 5px 10px; 
    cursor: pointer;
}

#hate-button {
    background-color: blue; 
    border-radius: 5px; 
    border: none;
    margin: 5px;
    padding: 5px 10px; 
    cursor: pointer;
}

#input1, #input2 {
    
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
}

.reply {
    
    border: 1px solid rgba(0, 0, 0, 0.5);
    padding: 10px;
    margin-bottom: 10px;
    background-color: #f2f2f2;
}

.delete-reply {
    margin-left: 10px; 
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
   
  
}

#pwinput {
    padding: 3px 3px;
    box-sizing: border-box;
    width: 100px;
    height: 30px;
    
}


#reply-form {
    display: flex;
    justify-content: flex-end; 
    margin: auto;
}

#id-input, #password-input2{
    display: flex;
    justify-content: flex-end; 
    margin: auto;
    width: 100px;
    height: 30px;
    padding: 3px 3px;
   
}

#content-input {
    width: 700px;
    height: 30px;
     margin: auto;
    padding: 3px 3px;
    
}

#submit-reply {
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    margin: auto;
    width: 80px;
    height: 40px;
   padding: auto;

}
#password-input1, #pw{
    margin: 5px;
    padding: 5px 10px;
}

.condel {
    margin: 5px;
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    
}

.upda {
    margin: 5px;
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    
}

.button-box {
    display: flex;
    justify-content: center;
     
}

.button-box button {
    padding: 10px 20px;
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
}

.button-box2 {
    display: flex;
    justify-content: flex-end; 
}

.button-box2 input {
   margin: 5px;
    padding: 10px;
    width: 105px;
    height: 35px;
    box-sizing: border-box;

}

.button-box2 button {
    margin: 3px; 
    border: none;
    background-color: #00bfff;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    width: 80px;
    height: 35px;
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
     <!-- 게시글 내용 표시 -->
     <form action="/content/${board.no}" method="post" id="detailcontent"> 
      
      <div class="details-section">
      <h1> ${board.title} </h1>
       <p><strong>작성자 </strong>${board.iid}</p>
       <p><strong>작성일 </strong><fmt:formatDate value="${board.ref_date}" pattern="yyyy-MM-dd"/></p>
       <p><strong>조회수 </strong>${board.readCount +1}</p>
       </div>
        <hr>
         <textarea  id="editor">${board.content}</textarea>
       
       <div style="display: flex; justify-content: center; align-items: center; gap:5px;">
        <span id="like-count">${likeCount}</span>
        <input type="button" id="like-button" data-board-no="${board.no}" value="👍" /><!-- 좋아요 버튼 -->
        <input type="button" id="hate-button" data-board-no="${board.no}" value="👎" /><!-- 싫어요 버튼 -->
        <span id="hate-count">${hateCount}</span>
        </div>
       </form>
       <br>
     
     <!-- 댓글 목록 -->
    <c:forEach var="reply" items="${replies}">
     <form action="/reply/delete" method="post" style="display: flex; justify-content: space-between;">
    	<input id="input1" type="hidden" name="cno" value="${reply.cno }">
    	<input id="input2" type="hidden" name="no" value="${board.no }">
        <div class="reply">
            <p>[${reply.id}]</p>           
            <p>${reply.content}</p>
             <label for="password-input"></label>
            <input type="password" id="pwinput" value="${reply.id}" name="password" placeholder="비밀번호"/> 
            <button class="delete-reply" data-reply-id="${reply.id}">댓글 삭제</button>
        </div>
       </form>
    </c:forEach>
    <br>
    
    <!-- 댓글 등록 폼 -->
     <form id="reply-form" action="/content/insert" method="post">
    <!-- id 입력 -->
     <div style="display: flex; align-items: center;">
    <label for="id-input"></label>
    <input type="text" id="id-input" name="id" placeholder="작성자" size=10 />
    </div>
 
    <input type="hidden" name="board_no" value="${board.no}"/>
   
    <!-- password 입력 -->
    <div style="display: flex; align-items: center;">
    <label for="password-input"></label>
    <input type="password" id="password-input2" name="password" placeholder="비밀번호" size=10 />
    </div>
     <!-- content 입력 -->
    <div style="display: flex; align-items: center;">
    <label for="content-input"></label>
    <input type="text" id="content-input" name="content" placeholder="댓글을 입력하세요" />
     </div>
     <!-- 제출 버튼 -->
    <input type="submit" id="submit-reply" value="댓글 등록" />
    </form>
   <br>
        
    <form id="content-del" action="/delete/${board.no}" method="post"
          style="display: flex; justify-content: flex-end;">
      <label for="password-input"></label>  
       <input type="password" id="password-input1" name="password" placeholder="비밀번호" size=10 />
       <button class="condel" type="submit">글삭제</button>
       
       <input id="pw" type="password" placeholder="비밀번호" size=10 />
       <button class="upda" onclick="update()">수정</button>
     </form>
       <br>
      <hr>
    <div class="button-box">
      <button onclick="location.href='/bullboard'">목록</button>
    </div>
</div>  
          
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    
    <script>
    ClassicEditor.create(document.querySelector('#editor'), {
        language: "ko",
        ckfinder: { uploadUrl: 'http://localhost:8083/img/upload' }
    }).then(editor => {
        window.editor = editor;
        editor.enableReadOnlyMode('#editor'); // 읽기 전용 모드 설정

    }).catch(error => {
        console.error(error);
    });
    </script>
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
