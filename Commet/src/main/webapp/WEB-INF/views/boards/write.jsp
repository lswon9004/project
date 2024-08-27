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
    <style>
        /* 폼 컨테이너 스타일 */
        .write-form-container {
            width: 65%;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* 폼 그룹 스타일 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        /* 입력 필드 스타일 */
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
        }

        /* 텍스트 입력 필드 스타일 */
        .form-group textarea {
            height: 300px;
            resize: vertical;
        }

        /* 버튼 스타일 */
        .actions {
            text-align: right;
        }

        .actions button {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            background: #00bfff;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .actions button.cancel {
            background-color: #ccc;
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
      <!-- Include header -->
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <!-- Main content area -->
        <main>

            <!-- Include aside (sidebar) -->
            <jsp:include page="/WEB-INF/views/aside.jsp" />
            
            <section class="board-main-content">
            <div class="board-viewtitle">글쓰기</div>
            <div class="board-title"></div>
                <div class="board-detail">
                    <form action="/boards/write" method="post">
                        <div class="form-group">
                            <label for="empno">작성자 번호</label>
                            ${user.ename }
                            <input type="hidden" id="empno" name="empno" required readonly="readonly" style="pointer-events: none;" value="${user.empno}">
                        </div>
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input class="title-text" type="text" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="text" id="editor" name="content"  style="resize: none;"></textarea>
                        </div>
                        <div class="actions">
                            <button type="submit">등록</button>
                            <button onclick="location.href='/boards'">취소</button>
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
<script type="text/javascript">
ClassicEditor.create( document.querySelector( '#editor' ), {
    language: "ko", ckfinder:{uploadUrl:'http://localhost:8083/img/upload'}
  }).then(editer => {
	  window.editer = editer

  }).catch(error => {
	  console.error(error)
  });
</script>
<script type="text/javascript"> 
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
<script type="text/javascript"> 
empno = ${user.empno};
deptno = ${user.deptno};
</script>
<script type="text/javascript" src="/js/main.js"></script>
</html>
