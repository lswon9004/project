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
        /* 스타일 추가 */
        .approval-form-container {
            max-width: 1000px;
            margin-left: 270px;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .approval-form-container h1 {
            text-align: center;
            margin-bottom: 20px;
            margin-left: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .approval-form-container table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .approval-form-container table th {
          padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .approval-form-container table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .approval-form-container table th {
            background-color: #f9f9f9;
            font-weight: bold;
        }

        .approval-form-container textarea {
            width: 100%;
            height: 200px;
            padding: 10px;
            border: 1px solid #ddd;
            resize: none;
        }

        .approval-form-container .form-actions {
            text-align: right;
        }

        .approval-form-container .form-actions button {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .approval-form-container .form-actions button.cancel {
            background-color: #ccc;
        }

        .approval-form-container select {
            width: 100%;
            padding: 4px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .approval-form-container .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" /></c:if><c:if test="${startTime==null}">00:00</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a></c:if>
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a></c:if>                    
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/searchCustomers">통합업무</a></li>
                    <li><a href="/attendance/managementList">근태현황</a></li>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status"  class="active">결재승인</a></li></c:if>
                    <c:if test="${user.right>=2 }"> <li><a href="/emp_manage" >직원관리</a></li></c:if>
                </ul>
            </aside>
            <section class="main-content">
                <div class="approval-form-container">
                    <h1>결재내용</h1>
                        <table>
                            <tr>
                                <th>문서번호</th>
                                <td>${dto.approval_no}</td>
                                <th>기안일자</th>
                                <td><fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                            <tr>
                                <th>서류 종류</th>
                                 <td>
                                    <c:choose>
                                        <c:when test="${dto.approval_type == 1}">연차/휴가신청</c:when>
                                        <c:when test="${dto.approval_type == 2}">출장신청</c:when>
                                        <c:when test="${dto.approval_type == 3}">문서결재</c:when>
                                        <c:when test="${dto.approval_type == 4}">비품신청</c:when>
                                    </c:choose>
                                    </td>
                                <th>사원 번호</th>
                                <td>${dto.empno }</td>
                            </tr>
                           <tr>
                                <th>결재 제목</th>
                                <td>${dto.approval_title}</td>
                                <th>담당자</th>
                                <td>${dto.approver1_empno}</td>
                            </tr>
                        </table>
                        <div class="section-title">결재내용</div>
                        <textarea style="width: 100%; height: 100px; pointer-events: none;" readonly="readonly">${dto.approval_content}</textarea>
                       <form method="get" action="/approval/statusForm/${dto.approval_no}">
        				<table>
        					<tr>
        						<td style="font-weight: bold">결재 처리</td>
        						<td>
        							<label for="1">승인</label> :
        							<label for="2">반려 </label> :
        						</td>
        					</tr>
        					<tr>
        						<td style="font-weight: bold">결재 의견</td>
        						<td style="margin: 0 0;padding: 0 0;">
        							<textarea  style="width: 100%; font-size: 20px; border: 0px solid #ddd" name="approval_comm"></textarea>
        						</td>
        					</tr>
        				</table>
        				<button>결재</button>
        				<input class="button" type="button"  onclick="window.location.href='/approval/status'" value="취소" />
        				</form>
   					 </div>
            </section>
        </main>
    </div>
    <footer>
        <p class="footer-text">현재시간 : <span id="current-time"></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
    </footer>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
</body>
</html>