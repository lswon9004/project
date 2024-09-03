<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management Portal</title>
        <link rel="stylesheet" type="text/css" href="/css/main.css" />
        <style type="text/css">
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
      <!-- Include header -->
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <!-- Main content area -->
        <main>

            <!-- Include aside (sidebar) -->
            <jsp:include page="/WEB-INF/views/aside.jsp" />
            
            <!-- 여기서부터 가운데 메인 -->
            <section class="board-main-content" style="overflow: auto;">
                <!-- 메인 콘텐츠 영역 -->
              <div class="board-viewtitle">게시글</div>
	<div class="board-title"></div> <!-- 게시판 제목 지정 -->
            <div class="board-detail"> <!-- 게시글 상세 내용 표시 a-->
            <div class="section-inline-section"> 
            <div class="right">
                      <div><strong>작성자:</strong> <c:forEach items="${ename }" var="ename">
								<c:if test="${board.empno ==ename.empno }">
								${ename.ename }
								</c:if>
								</c:forEach></div>
                     <div><strong>작성일자:</strong>
                        <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH시mm분ss초" /></div>
                    </div>
                </div>
                <div class="section"> <!-- section 클래스는 게시글의 각 섹션 정의 -->
                    <div class="section-title">제목</div>
                    <div class="section-content">${board.title}</div>
                
                <!-- 작성자와 작성일자를 인라인으로 표시 -->
                
                <div class="section-title">내용</div>
                <%--           <textarea id="editor" class="text" id="content" name="content" style="height: 370px;">${board.content}</textarea>
                 --%><div style="overflow: auto;">${board.content}</div>
                 
                 </div>
                <div class="like-dislike"> <!-- 추천 버튼 지정 -->
                    <form id="likeForm" action="${hasLiked ? '/boards/unlike' : '/boards/like'}" method="post">
                        <input type="hidden" name="empno" value="${user.empno}">
                        <input type="hidden" name="no" value="${board.no}">
                        <button class="like" type="button"><span class="heart-icon">❤</span> 추천 <span id="likeCount">${likeCount}</span></button>
                    </form>
                </div>
            </div>
            <div class="comment-section"> <!-- 댓글 섹션 지정 -->
                <div class="section-title">댓글</div>
                <c:forEach var="comment" items="${clist}">
                <!-- 각 댓글을 지정하며, 댓글 수정 및 삭제 폼을 포함함 -->
                    <div class="comment"> 
                        <p>${comment.text}</p>
                        <div class="meta">작성자: ${comment.empno} | 작성일: <fmt:formatDate value="${comment.regdate}" pattern="yyyy-MM-dd HH:mm" /></div>
                        <c:if test="${comment.empno == user.empno}">
                            <div class="comment-actions">
                                <form class="comment-update-form" method="post" style="display: inline;">
                                    <input type="hidden" name="cno" value="${comment.cno}">
                                    <input type="hidden" name="no" value="${board.no}">
                                    <input class="comment-text" type="text" name="text" required>
                                    <button type="submit">수정</button>
                                </form>
                                <form action="/comments/delete" method="post" style="display: inline;">
                                    <input type="hidden" name="cno" value="${comment.cno}">
                                    <input type="hidden" name="no" value="${board.no}">
                                    <button type="submit">삭제</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
                <div class="comment-form">
    <form action="/comments/add" method="post">
        <input type="hidden" name="empno" value="${user.empno}">
        <input type="hidden" name="no" value="${board.no}">
        <textarea name="text" placeholder="댓글을 입력하세요" required></textarea>
         <div class="comment-button-container">
            <button type="submit">작성</button>
        </div>
		</form>
			</div>
            </div>
            <div class="actions" style="margin-right: 60px;"> <!-- 페이지 하단의 액션 버튼을 지정 -->
                <button onclick="location.href='/boards'">목록</button>
                <c:if test="${board.empno == user.empno}">
                    <button onclick="location.href='/boards/edit/${board.no}'">수정</button>
                    <form action="/boards/delete/${board.no}" method="post" style="display: inline;">
                        <button type="submit">삭제</button>
                    </form>
                </c:if>
            </div>
            </section>
        </main>
    </div>
</body>
<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    empno = ${user.empno};
$('#start').click(function(){
	deptno = ${user.deptno};
	$.getJSON("/startTime",{'empno':empno,'deptno':deptno},function(data){
		if (data){			
			$('#startTime').text(data+'/');						
		 }else{
			alert('이미 출근버튼을 누르셨습니다.')
			alert(date)
		} 
	})
})
$('#end').click(function(){
	$.getJSON('/endTime',{'empno':empno},function(data){
		$('#endTime').text(data)
	})
})
 function selectDate(date) {
	$.getJSON('/vacation',{'date':date},function(data){
		$('#vlist').append(datea)
	})
}
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
    <script>
    function updateTime() {
        const now = new Date();
        const options = { 
            year: 'numeric', 
            month: '2-digit', 
            day: '2-digit', 
            weekday: 'long', 
            hour: '2-digit', 
            minute: '2-digit', 
            second: '2-digit'
        };
        const currentTimeString = now.toLocaleDateString('ko-KR', options);
        document.getElementById('current-time').innerText = currentTimeString;
    }

    // 처음 페이지 로드 시 시간을 표시
    updateTime();

    // 매 초마다 시간을 업데이트
    setInterval(updateTime, 1000);
</script>
<script type="text/javascript"> 
empno = ${user.empno};
deptno = ${user.deptno};
</script>
<script type="text/javascript" src="/js/main.js"></script>
</html>