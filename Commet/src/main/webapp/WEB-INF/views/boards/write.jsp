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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .prev-month, .next-month {
            color: #ccc;
        }

	/* 메인 컨텐츠 스타일 */
        main {
            padding: 20px;
            background: #fff;
            margin-top: 20px;
        }

        /* 글쓰기 폼 스타일 */
        .write-form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        textarea {
            height: 200px;
        }

        /* 액션 버튼 스타일 */
        .actions {
            text-align: right;
        }

        .actions button {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background: #333;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .actions button[type="submit"] {
            background: #77a1d3;
        }	
    </style>
</head>
<body>
     <div class="container">
        <header>
            <div class="user-info">
               <img src="/upload/${user.imgPath}" alt="User Profile">
                <div>
                    <p>이름: ${user.ename }</p>
                    <p>직책: ${user.position }</p>
                    <p>사번: ${user.empno }</p>
                    <p>${user.ename }님 환영합니다.</p>
                </div>
            </div>
            <h1>코멧 업무포털</h1>
            <div class="header-right">
                <button id="start">업무시작</button>
                <button id="end">업무종료</button>
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">0d:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a> </c:if><!--다른 jsp 파일에서 적용할거 -->
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a> </c:if> <!--다른 jsp 파일에서 적용할거 -->                    <a href="#">개인정보수정</a>
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/searchCustomers">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=2 }"> <li><a href="/emp_manage" class="active">직원관리</a></li></c:if>
                </ul>
            </aside>
            <section class="main-content">
       <div class="container"> <!-- 페이지의 컨테이너 역할 -->
        <header> <!-- 페이지의 헤더 영역 -->
            <h1>글쓰기</h1>
        </header>
        <main> <!-- 메인 컨텐츠 영역 -->
            <form action="/boards/write" method="post"> <!-- 글쓰기 폼 -->
                <div class="form-group"> <!-- 작성자 번호 입력 필드 -->
                    <label for="empno">작성자 번호</label>
                    <input type="text" id="empno" name="empno" required readonly="readonly" value="${user.empno}">
                </div>
                <div class="form-group"> <!-- 제목 입력 필드 -->
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group"> <!-- 내용 입력 필드 -->
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="actions"> <!-- 액션 버튼들 -->
                    <button type="submit">저장</button> <!-- 저장 버튼 -->
                    <button type="button" onclick="window.location.href='/boards'">취소</button> <!-- 취소 버튼 -->
                </div>
            </form>
        </main>
    </div>
            </section>
        </main>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
datea= ${user.att.startTime}
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
</script>
</html>