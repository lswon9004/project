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
          <!--   여기서부터 가운데 메인 -->
            <section class="board-main-content">
                <div class="board-viewtitle" style="margin-right: 10px;">게시글 수정</div>
                <div class="board-title"></div>
                <div class="board-detail">
                    <div class="section-inline-section">
                        <div class="right">
                            <div><strong>작성자:</strong> ${user.empno}</div>
                            <div><strong>작성일자:</strong>
                                <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH시mm분ss초" /></div>
                        </div>
                    </div>
                    <form action="/boards/edit/${board.no}" method="post">
                        <div class="section" style="height: 530px;">
                            <div class="section-title">제목</div>
                                <input class= "title-text" type="text" id="title" name="title" value="${board.title}" required>
                            <div class="section-title">내용</div>
                                <textarea id="editor" class="text" id="content" name="content">${board.content}</textarea>
                        </div>
                        <div class="form-actions" style="display: ruby-text;">
                        <button onclick="location.href='/boards'">목록</button>
                        <button type="submit">완료</button>
                        </div>
                		
                    </form>
                </div>
            </section>
        </main>
    </div>
</body>
<footer>
    <p class="footer-text">현재시간 : <span id="current-time"></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
$('#end').click(function() {
    $.getJSON('/endTime', {
        'empno': empno
    }, function(data) {
        $('#endTime').text(data)
    })
})

function selectDate(date) {
    $.getJSON('/vacation', {
        'date': date
    }, function(data) {
        $('#vlist').append(datea)
    })
}
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

    updateTime();
    setInterval(updateTime, 1000);
</script>
</html>
