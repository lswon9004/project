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
        .main-content { /* 메인 콘텐츠 영역 스타일 설정 */
    width: 75%;
    padding: 20px;
    background: #fff;
}
.board-title { /* 게시글 제목의 스타일 정의 */
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    border-bottom: 2px solid #ddd;
    padding-bottom: 10px;
}
.board-detail { /* 게시글 상세 내용의 스타일 설정 */
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 5px;
    background: #f9f9f9;
}
.board-detail .section { /* 내부의 섹션 스타일 정의 */
    margin-bottom: 20px;
}
.board-detail .section-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}
.board-detail .section-content {
    padding: 10px;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
}
.board-detail .inline-section { /* 인라인 레이아웃 설정 */
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.board-detail .inline-section .section-content {
    margin-right: 20px; /* 공백 추가 */
}
.board-detail .right { /* 오른쪽 정렬 설정 */
    margin-left: auto;
}
.section-inline-section{
    margin-bottom: 0;
    float: right;
}
.section-inline-section>.right{
    display: flex;
}
.section-inline-section>.right>div{
    padding:0 10px;
}
.like-dislike { /* 추천 버튼과 관련된 스타일 설정 */
    display: flex;
    align-items: center;
    margin-top: 20px;
}
.like-dislike form { /* 추천 버튼 폼의 레이아웃 설정 */
    display: flex;
    align-items: center;
    margin-right: 10px;
}
.like-dislike button { /* 추천 버튼의 스타일 설정 */
    padding: 5px 10px;
    border: none;
    background: #ff6347;
    color: #fff;
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
}
.comment-section { /* 댓글 섹션의 스타일 설정 */
    margin-top: 20px;
}
.comment-section .section-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}
.comment { /* 개별 댓글의 스타일 정의 */
    border-top: 1px solid #ddd;
    padding-top: 10px;
    margin-top: 10px;
    font-size: 14px; /* 댓글 크기 줄이기 */
}
.comment p {
    margin: 0;
    color: #333;
}
.comment .meta {
    font-size: 12px; /* 댓글 메타 정보 크기 줄이기 */
    color: #777;
}
.comment-actions { /* 댓글 액션 버튼의 스타일 설정 */
    margin-top: 5px; /* 댓글 액션 여백 줄이기 */
}
.comment-actions button {
    padding: 3px 5px; /* 댓글 액션 버튼 크기 줄이기 */
    border: none;
    background: #333;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
    font-size: 12px;
}
.comment-form { /* 댓글 입력 폼의 스타일 설정 */
    display: flex;
    flex-direction: column;
    margin-top: 20px;
}
.comment-form textarea {
    width: 100%;
    height: 40px; /* 댓글 입력 창 높이 줄이기 */
    padding: 5px; /* 댓글 입력 창 패딩 줄이기 */
    border: 1px solid #ddd;
    border-radius: 5px;
    resize: none;
}
.comment-form .comment-button-container { /* 댓글 버튼 컨테이너의 스타일 설정 */
    display: flex;
    justify-content: flex-end;
    margin-top: 5px; /* 댓글 버튼 컨테이너 여백 줄이기 */
}
.comment-form button {
    padding: 5px 10px; /* 댓글 버튼 크기 줄이기 */
    border: none;
    background: #333;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
    font-size: 12px;
}
.actions { /* 게시글 상세보기 하단의 액션 버튼 */
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
.actions button, .actions form button {
    padding: 10px 20px;
    margin: 5px;
    border: none;
    background: #e0f7fa; /* view.jsp의 글쓰기 버튼 색 */
    color: #000;
    border-radius: 5px;
    cursor: pointer;
    font-family: 'Noto Sans KR', sans-serif; /* 글씨체 설정 */
    font-weight: bold; /* 테이블 헤더와 동일한 글씨체 설정 */
}
footer { /* 푸터 스타일 설정 */
    margin-top: 20px;
    text-align: center;
    color: #777;
    font-size: 14px;
}
</style>
</head>
<body>
     <div class="container">
        <header>
            <div class="user-info">
                <img src="profile.jpg" alt="User Profile">
                <div>
                    <p>이름: 김자바</p>
                    <p>직책: ${user.position }</p>
                    <p>사번: ${user.empno }</p>
                    <p>김자바 님 환영합니다.</p>
                </div>
            </div>
            <h1>코멧 업무포털</h1>
            <div class="header-right">
                <button id="start">업무시작</button>
                <button id="end">업무종료</button>
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">0d:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <a href="/main">Home</a>
                    <a href="/cleander">연봉계산기</a>
                    <a href="#">개인정보수정</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/customerList">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <li><a href="/approval/status">결재승인</a></li>
                    <li><a href="/bullboard">익명게시판</a></li>
                    <li><a href="/emp_manage">직원관리</a></li>
                    <li><a href="#">관찰관리</a></li>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            <section class="main-content">
                <!-- 메인 콘텐츠 영역 -->
	<div class="board-title">게시판</div> <!-- 게시판 제목 지정 -->
            <div class="board-detail"> <!-- 게시글 상세 내용 표시 -->
            <div class="section-inline-section"> 
            <div class="right">
                      <div><strong>작성자:</strong> ${user.empno}</div>
                     <div><strong>작성일자:</strong>
                        <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH시mm분ss초" /></div>
                    </div>
                </div>
                <div class="section"> <!-- section 클래스는 게시글의 각 섹션 정의 -->
                    <div class="section-title">제목</div>
                    <div class="section-content">${board.title}</div>
                </div>
                <!-- 작성자와 작성일자를 인라인으로 표시 -->
                
                <div class="section-title">내용</div>
                    <textarea class="section-content" readonly="readonly" style="width: 1180px; height: 300px; resize: none;">${board.content}</textarea>
                
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
                        <div class="meta">작성자: ${comment.empno} | 작성일: ${comment.regdate}</div>
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
                <div class="comment-form"> <!-- 새로운 댓글을 작성하는 폼 -->
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
            <div class="actions"> <!-- 페이지 하단의 액션 버튼을 지정 -->
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
</html>