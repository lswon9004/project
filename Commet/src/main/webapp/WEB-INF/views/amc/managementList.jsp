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
        /* 전체 테이블 스타일 */
		table {
    		width: 100%; /* 테이블의 너비를 화면에 꽉 차게 설정 */
    		border-collapse: collapse; /* 테이블 셀 간의 간격을 없앰 */
		}

		/* 테이블 헤더 및 셀 스타일 */
		th, td {
    		border: 1px solid #ddd; /* 셀 경계선의 색상과 두께를 설정 */
    		padding: 8px; /* 셀 내부 여백을 추가 */
    		text-align: center; /* 셀 내부 텍스트를 중앙 정렬 */
		}

		/* 테이블 헤더 스타일 */
		th {
    		background-color: #f2f2f2; /* 헤더 배경색을 회색으로 설정 */
		}

		/* 이전 달과 다음 달의 날짜 스타일 (달력) */
		.prev-month, .next-month {
    		color: #ccc; /* 이전/다음 달 날짜의 색상을 흐리게 설정 */
		}

		/*여기서 부터 managementList*/
				
		/* 전체 body 스타일 */
		body {
    		font-family: Arial, sans-serif; /* 기본 글꼴을 Arial로 설정 */
		}

		/* 제목 스타일 */
		h2 {
    		text-align: center; /* 제목을 중앙 정렬 */
    		color: #333; /* 제목 색상을 진한 회색으로 설정 */
    		margin-top: 2px; /* 상단에 20px의 여백을 추가 */
    		margin-bottom: 4px; /* 하단에 20px의 여백을 추가 */
    		
		}
		
		/* 폼 컨테이너 스타일 (버튼과 폼 정렬) */
		.form-container {
    		display: flex; /* 플렉스 박스를 사용하여 내부 요소를 배치 */
    		justify-content: space-between; /* 요소들 사이의 공간을 균등하게 분배 */
    		margin-bottom: 5px; /* 폼 컨테이너 아래에 여백을 추가 */
    		align-items: center; /* 요소들을 세로로 중앙 정렬 */
		}

		/* 폼 스타일 */
		.form-container form {
    		display: flex; /* 폼을 플렉스 박스로 설정하여 내부 요소를 배치 */
    		align-items: center; /* 폼 내부 요소들을 세로로 중앙 정렬 */
		}

		/* 라벨 스타일 */
		label {
    		margin: 0 10px; /* 라벨의 좌우에 여백을 추가 */
    		font-weight: bold; /* 라벨 텍스트를 굵게 설정 */
		}

		/* 날짜 입력 필드 스타일 */
		input[type="date"] {
    		padding: 5px; /* 입력 필드 내부 여백을 추가 */
    		margin: 0 10px; /* 입력 필드 좌우에 여백을 추가 */
    		border: 1px solid #ccc; /* 입력 필드 경계선을 회색으로 설정 */
    		border-radius: 4px; /* 입력 필드 모서리를 둥글게 설정 */
		}

		/* 버튼 스타일 */
button {
    margin: 5px;
    padding: 9px 18px;
    background-color: #00bfff; /* 버튼 배경색 */
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    font-size: 13px; /* 버튼 글씨 크기 */
    font-weight: bold;
}
        
       

		/* 버튼 호버(마우스를 올렸을 때) 스타일 */
		button:hover {
    		background-color: #0056b3; /* 버튼 배경색을 어두운 파란색으로 변경 */
		}

		/* 테이블 스타일 */
		table {
    		width: 100%; /* 테이블의 너비를 화면에 꽉 차게 설정 */
    		border-collapse: collapse; /* 테이블 셀 간의 간격을 없앰 */
    		margin-top: 20px; /* 테이블 위쪽에 여백을 추가 */
		}

		/* 테이블, 헤더, 셀 경계선 스타일 */
		table, th, td {
    		border: 1px solid #ccc; /* 경계선을 회색으로 설정 */
		}

		/* 테이블 헤더 및 셀 내부 스타일 */
		th, td {
    		padding: 10px; /* 셀 내부 여백을 추가 */
    		text-align: center; /* 셀 내부 텍스트를 중앙 정렬 */
		}

		/* 테이블 헤더 배경색 스타일 */
		th {
    		background-color: #e0f7fa; /* 헤더 배경색을 연한 회색으로 설정 */
		}
		
		 /* 짝수 행의 데이터 셀 배경색 설정 */
      /*   tr:nth-child(even) td {
            background-color: #f2f2f2; 
        } */

		/* 버튼 그룹 스타일 */
		.button-group {
    		display: flex; /* 플렉스 박스를 사용하여 버튼들을 배치 */
		}

		/* 버튼 그룹 내 폼 스타일 */
		.button-group form {
    		margin: 0px; /* 버튼 그룹 내의 폼 여백을 제거 */
		}

		/* 페이지네이션 스타일 */
		.pagination {
   			text-align: center; /* 페이지네이션을 중앙 정렬 */
    		margin: 20px 0; /* 페이지네이션 위아래로 여백을 추가 */
		}

		/* 페이지네이션 링크 스타일 */
		.pagination a {
    		margin: 0 5px; /* 링크 좌우에 여백을 추가 */
    		padding: 8px 16px; /* 링크 내부 여백을 추가 */
    		text-decoration: none; /* 링크 밑줄을 제거 */
    		border: 1px solid #ddd; /* 링크 주위에 경계선을 추가 */
    		color: #007bff; /* 링크 텍스트 색상을 파란색으로 설정 */
    		border-radius: 4px; /* 링크 모서리를 둥글게 설정 */
		}

		/* 활성화된 페이지 링크 스타일 */
		.pagination a.active {
    		font-weight: bold; /* 활성화된 페이지 링크를 굵게 표시 */
    		background-color: #007bff; /* 활성화된 페이지 링크 배경색을 파란색으로 설정 */
    		color: white; /* 활성화된 페이지 링크 텍스트 색상을 흰색으로 설정 */
		}

		/* 페이지네이션 링크 호버 스타일 */
		.pagination a:hover {
    		background-color: #0056b3; /* 링크 배경색을 어두운 파란색으로 변경 */
    		color: white; /* 링크 텍스트 색상을 흰색으로 변경 */
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
                    <a href="#">개인정보수정</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/customerList">통합업무</a></li>
                     <li><a href="/attendance/managementList" class="active">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <li><a href="/approval/status">결재승인</a></li>
                    <li><a href="/bullboard">익명게시판</a></li>
                    <li><a href="/emp_manage">직원관리</a></li>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            
            <section class="main-content">
             <div class="container">
             
        	<h2>${user.empno}님의 근태현황 입니다.</h2>
        	
			<div class="form-container">
        	<form action="/attendance/search" method="get">
            <label for="startDate">출근일자:</label>
            <input type="date" id="startDate" name="startDate"required>
            <label for="endDate">~</label>
            <input type="date" id="endDate" name="endDate" required>
            <button type="submit">검색</button>
            <button type="button" onclick="location.href='/attendance/managementList?p=1'">초기화</button>
        	</form>
        
        	<div class="button-group">
            <form action="/attendance/checkIn" method="post" >
                <button type="submit">출근</button>
            </form>
            <form action="/attendance/checkOut" method="post" >
                <button type="submit">퇴근</button>
            </form>
            <button type="button" onclick="location.href='/attendance/downloadExcel2'">엑셀다운로드</button>
       		</div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>출근번호</th>
                    <th>출근일자</th>
                    <th>출근시간</th>
                    <th>퇴근시간</th>
                    <th>근무유형</th>
                    <th>연차사용</th>
                    <th>잔여연차</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${count == 0}">
                    <tr>
                        <td colspan="7" class="tac">저장된 근태현황이 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${count > 0}">
                    <c:forEach var="attendance" items="${attendanceList}">
                        <tr>
                            <td>${attendance.attendance_no}</td>
                            <td><fmt:formatDate value="${attendance.date}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${attendance.check_in}" pattern="HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${attendance.check_out}" pattern="HH:mm:ss"/></td>
                            <td>${attendance.worktype}</td>
                            <td>${attendance.early_leave}</td>
                            <td></td>
                    
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>

      <div class="pagination">
            <c:if test="${begin > pageNum}">
                <a href="managementList?p=${begin-1}">[이전]</a>
            </c:if>
            <c:forEach begin="${begin}" end="${end}" var="i">
                <a href="managementList?p=${i}" class="${i == page ? 'active' : ''}" >${i}</a>
            </c:forEach>
            <c:if test="${end < totalPages}">
                <a href="managementList?p=${end+1}">[다음]</a>
            </c:if>
            <c:if test="${count == 0}">
                아직 입력한 정보가 없습니다.
            </c:if>
        </div>
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
</script>

 
   	<script>
        $(document).ready(function() {
            $("#checkInButton").click(function(event) {
                event.preventDefault(); // 기본 동작을 막음
                $.ajax({
                    url: "/attendance/checkInStatus",
                    method: "GET",
                    success: function(data) {
                        if (data) {
                            alert("출근 버튼을 이미 눌렀습니다.");
                        } else {
                            $("#checkInForm").submit(); // 출근 폼 제출
                        }
                    }
                });
            });
        });
    </script>
</html>