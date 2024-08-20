<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        .form-container {
            margin-bottom: 20px;
        }
        .form-container input {
            margin-right: 10px;
        }
        .form-container button {
            margin-right: 10px;
        }
         .ck.ck-editor{

        width: 100%;
        }
        .ck-editor__editable {
            min-height: 200px;
        }
        select {
    font-size: 18px;
}
        input {
    font-size: 18px;
}
    </style>   
</head>
<body>
     <div class="container">
        <header>
            <div class="user-info">
                <img src="" alt="User Profile">
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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">00:00/</c:if></p>
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
                    <li><a href="#">통합업무</a></li>
                    <li><a href="#">게시판</a></li>
                    <li><a href="/approval">전자결재</a></li>
                    <li><a href="#">결재승인</a></li>
                    <li><a href="#">캘린더</a></li>
                    <li><a href="#">직원관리</a></li>
                    <li><a href="#">관찰관리</a></li>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            <section class="main-content">
                <div class="status-overview">
                    <div class="form-container">
        				<h1 style="text-align: center;">결재 신청</h1>
        				<table>
        				<colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
        					<tr>
        						<td>문서번호</td>
        						<td>${dto.approval_no}</td>
        						<td>기안일자</td>
        						<td><fmt:formatDate value="${dto.created_date}" pattern="yyyy-MM-dd" /></td>
        					</tr>
        					<tr>
        					<td>서류 종류</td>
        						<td style="margin: 0 0;padding: 0 0;"><c:choose>
									<c:when test="${dto.approval_type ==1 }">연차/휴가신청</c:when>
									<c:when test="${dto.approval_type ==2 }">출장신청</c:when>
									<c:when test="${dto.approval_type ==3 }">문서결재</c:when>
									<c:when test="${dto.approval_type ==4 }">비품신청</c:when>
								</c:choose></td>
        						<td>사원 번호</td>
        						<td>${dto.empno }</td>
        					</tr>
        					<tr>
        						<td>
        							결재 제목
        						</td>
        						<td > 
        							${dto.approval_title}
        						</td>
        						<td>
        							담당자
        						</td>
        						<td>
        							${dto.approver1_empno }
        						</td>
        					</tr>
        				</table>
        				<textarea style="width: 100%; height: 200px;" readonly="readonly">${dto.approval_content }</textarea>
        				<form method="post" action="/approval/statusForm">
        				<c:if test="${dto.approval_type ==1 }">
        				<input type="date" name="date">
        				</c:if>
        				<input type="hidden" name="empno" value="${dto.empno }">
        				<input type="hidden" name="approval_no" value="${dto.approval_no }">
        				<input type="hidden" name="approval_type" value="${dto.approval_type }">
        				<table>
        				<colgroup>
			<col style="width:25%;" />
			<col style="width:75%;" />
		</colgroup>
        					<tr>
        						<td>결재 처리</td>
        						<td>
        							<label for="1">승인</label> : <input type="radio" id="1" name="approval_status1" value="승인" checked="checked">
        							<label for="2">반려 </label>: <input type="radio" id="2" name="approval_status1" value="반려">
        						</td>
        					</tr>
        					<tr>
        						<td>결재 의견</td>
        						<td style="margin: 0 0;padding: 0 0;">
        							<textarea  style="width: 100%; font-size: 20px;" rows="5" name="approval_comm"></textarea>
        						</td>
        					</tr>
        				</table>
        				<button>등록</button>
        				<input type="button"  onclick="window.location.href='/approval/status'" value="취소" />
        				</form>
   					 </div>
   
                </div>
            </section>
        </main>
    </div>
    
</body>
</html>