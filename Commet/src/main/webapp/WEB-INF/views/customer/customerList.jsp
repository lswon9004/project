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
            width: 100%; /* 테이블의 너비를 전체 화면에 맞춤 */
            border-collapse: collapse; /* 인접한 테이블 셀 간의 경계를 합침 */
        }
        
        /* 테이블 헤더 및 데이터 셀 스타일 */
        th, td {
            border: 1px solid #ddd; /* 셀 경계선에 색상 적용 */
            padding: 8px; /* 셀 내부에 여백 추가 */
            text-align: center; /* 텍스트를 중앙 정렬 */
        }
        
        /* 테이블 헤더 스타일 */
        th {
            background-color: #f2f2f2; /* 헤더 배경색 설정 */
			}
        
        /* 이전 달과 다음 달의 날짜 스타일 (달력) */
        .prev-month, .next-month {
            color: #ccc; /* 이전/다음 달 날짜를 흐리게 표시 */
        }
        
         /* 여기서부터 customerList */
         
         /* 고객 리스트 섹션의 전체적인 스타일 */
        body {
            font-family: Arial, sans-serif; /* 기본 글꼴 설정 */
        }
        
        /* 제목(h2) 스타일 */
        h2 {
            text-align: center; /* 제목을 중앙 정렬 */
            margin: 20px 0; /* 제목 위아래로 여백 추가 */
        }
        
        /* 고객 리스트 테이블 스타일 */
        table {
            width: 100%; /* 테이블 너비를 전체 화면에 맞춤 */
            border-collapse: collapse; /* 인접한 테이블 셀 간의 경계를 합침 */
            margin: 20px 0; /* 테이블 위아래로 여백 추가 */
            border: 1px solid #e0e0e0; /* 테이블 외곽에 경계선 추가 */
        }
        
        /* 테이블 헤더와 데이터 셀에 대한 추가 스타일링 */
        th, td {
            padding: 12px; /* 셀 내부에 여백 추가 */
            text-align: center; /* 텍스트를 중앙 정렬 */
        }
        
        /* 테이블 헤더에 대한 추가 스타일링 */
        th {
            background-color: #e0f7fa; /* 헤더의 배경색 설정 */
            color: #333; /* 헤더 텍스트 색상 설정 */
            font-weight: bold; /* 헤더 텍스트를 굵게 표시 */
        }
        
        /* 테이블 데이터 셀 스타일링 */
        td {
            background-color: #fff; /* 데이터 셀의 배경색 설정 */
        }
        
        /* 짝수 행의 데이터 셀 배경색 설정 */
        
      /*   tr:nth-child(even) td {
            background-color: #f2f2f2; }  */
         
        
        /* 체크박스 스타일링 */
        input[type="checkbox"] {
            transform: scale(1.2); /* 체크박스 크기를 1.2배로 확대 */
        }
        
        /* 버튼 스타일링 */
        button {
            margin: 5px; /* 버튼 주위에 여백 추가 */
    		padding: 10px 20px; /* 버튼 내부에 여백 추가 */
    		background-color: #00bfff; /* 버튼 배경색 설정 */
   			color: #fff; /* 버튼 텍스트 색상 설정 */
    		border: none; /* 버튼 경계선 제거 */
    		cursor: pointer; /* 마우스 커서를 손가락 모양으로 변경 */
    		border-radius: 4px; /* 버튼의 모서리를 둥글게 설정 */
        }
        
        /* 버튼 호버 시 스타일링 */
        .button:hover {
            background-color: #0056b3; /* 마우스를 올렸을 때 버튼의 배경색 변경 */
        }
        
        /* 드롭다운 메뉴 스타일링 */
        .dropdown {
            display: inline-block; /* 드롭다운을 인라인 블록으로 설정 */
            position: relative; /* 드롭다운 메뉴의 위치를 부모 요소에 상대적으로 설정 */
        }
        
        /* 드롭다운 내용 스타일링 */
		.dropdown-content {
    		display: none; /* 드롭다운 내용을 기본적으로 숨김 */
   		 	position: absolute; /* 드롭다운 내용을 절대 위치로 설정 */
    		background-color: #f9f9f9; /* 드롭다운 배경색 설정 */
    		min-width: 160px; /* 드롭다운 최소 너비 설정 */
    		box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /* 드롭다운 그림자 효과 */
    		z-index: 1; /* 드롭다운이 다른 요소들 위에 나타나도록 설정 */
		}

		/* 드롭다운 항목 스타일링 */
		.dropdown-content a {
    		color: black; /* 드롭다운 항목의 텍스트 색상 설정 */
    		padding: 12px 16px; /* 드롭다운 항목 내부 여백 설정 */
    		text-decoration: none; /* 드롭다운 항목의 밑줄 제거 */
    		display: block; /* 드롭다운 항목을 블록 요소로 설정 */
		}

		/* 드롭다운 항목 호버 시 스타일링 */
		.dropdown-content a:hover {
    		background-color: #f1f1f1; /* 마우스를 올렸을 때 드롭다운 항목의 배경색 변경 */
		}

		/* 드롭다운 메뉴 호버 시 드롭다운 내용 표시 */
		.dropdown:hover .dropdown-content {
    		display: block; /* 드롭다운 내용을 보이도록 설정 */
		}

		/* 페이지네이션 스타일링 */
		.pagination {
    		text-align: center; /* 페이지네이션을 중앙 정렬 */
    		margin: 20px 0; /* 페이지네이션 위아래로 여백 추가 */
		}

		/* 페이지네이션 링크 스타일링 */
		.pagination a {
    		margin: 0 5px; /* 링크 간에 좌우 여백 추가 */
    		padding: 8px 16px; /* 링크 내부에 여백 추가 */
   		 	text-decoration: none; /* 링크 밑줄 제거 */
    		border: 1px solid #ddd; /* 링크 주위에 경계선 추가 */
    		color: #007bff; /* 링크 텍스트 색상 설정 */
    		border-radius: 4px; /* 링크의 모서리를 둥글게 설정 */
		}

		/* 현재 활성화된 페이지 링크 스타일링 */
		.pagination a.active {
   	 		font-weight: bold; /* 활성화된 페이지 링크를 굵게 표시 */
    		background-color: #007bff; /* 활성화된 페이지 링크의 배경색 설정 */
    		color: white; /* 활성화된 페이지 링크의 텍스트 색상 설정 */
		}

		/* 페이지네이션 링크 호버 시 스타일링 */
		.pagination a:hover {
    		background-color: #0056b3; /* 마우스를 올렸을 때 링크의 배경색 변경 */
    		color: white; /* 마우스를 올렸을 때 링크의 텍스트 색상 변경 */
		}

		/* 버튼 컨테이너 스타일링 */
		.button-container {
    		display: flex; /* 버튼들을 플렉스 박스로 배치 */
    		justify-content: space-between; /* 버튼들 간의 공간을 균등하게 분배 */
    		align-items: center; /* 버튼들을 세로로 중앙 정렬 */
		}

		/* 검색 폼 스타일링 */
		.search-form {
    		display: flex; /* 검색 폼을 플렉스 박스로 배치 */
    		align-items: center; /* 검색 폼의 요소들을 세로로 중앙 정렬 */
		}

		/* 검색 폼 입력 필드 스타일링 */
		.search-form input {
    		padding: 5px; /* 입력 필드 내부에 여백 추가 */
    		margin-right: 10px; /* 입력 필드 간의 오른쪽 여백 추가 */
    		border: 1px solid #ccc; /* 입력 필드에 경계선 추가 */
    		border-radius: 4px; /* 입력 필드의 모서리를 둥글게 설정 */
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
                     <li><a href="/attendance/managementList">근태현황</a>
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
    		<h2>고객정보</h2>
    	<form action="${pageContext.request.contextPath}/deleteCustomer" method="post">
        <div class="button-container">
            <div class="search-form">
                <input type="text" name="customerName" placeholder="고객명">
                <input type="text" name="contact" placeholder="연락처">
                <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/searchCustomers?customerName=' + $('[name=customerName]').val() + '&contact=' + $('[name=contact]').val()">검색</button>
            <div class="dropdown">
                    <button type="button" class="button">진행상태</button>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/searchCustomers">전체</a>
                        <a href="${pageContext.request.contextPath}/filterByStatus?status=Received">접수완료</a>
                        <a href="${pageContext.request.contextPath}/filterByStatus?status=Consulted">상담완료</a>
                        <a href="${pageContext.request.contextPath}/filterByStatus?status=Complaint">민원인</a>
                    </div>
                </div>
            </div>
            <div>
                <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/info'">등록</button>
                <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/downloadExcel'">엑셀다운로드</button>
                <button type="submit" class="button">삭제</button>
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>고객번호</th>
                    <th>고객명</th>
                    <th>생년월일</th>
                    <th>연락처</th>
                    <th>진행상태</th>
                    <th>접수일자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="customer" items="${blist}">
                    <tr>
                        <td><input type="checkbox" name="customerIds" value="${customer.customerID}"></td>
                        <td>${customer.customerID}</td>
                        <%-- <td><a href="${pageContext.request.contextPath}/customerDetail/${customer.customerID}">${customer.customerName}</a></td> 클릭 했을때 기존--%>
                         <td><a href="javascript:void(0);" onclick="openPopup(${customer.customerID})">${customer.customerName}</a></td><!-- 클릭했을떄 새로운 윈도우 -->
                        <td>${customer.dateOfBirth}</td>
                        <td>${customer.contact}</td>
                        <td>
                            <c:choose>
                                <c:when test="${customer.status == 'Received'}">접수완료</c:when>
                                <c:when test="${customer.status == 'Consulted'}">상담완료</c:when>
                                <c:when test="${customer.status == 'Complaint'}">민원인</c:when>
                                <c:otherwise>${customer.status}</c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${customer.registrationDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>
    
   <div class="pagination">
        <c:if test="${currentPage > 1}">
        <a href="searchCustomers?page=${currentPage - 1}&pageSize=${pageSize}&customerName=${param.customerName}&contact=${param.contact}">[이전]</a>
    	 </c:if>
    	 <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="searchCustomers?page=${i}&pageSize=${pageSize}&customerName=${param.customerName}&contact=${param.contact}" class="${i == currentPage ? 'active' : ''}">${i}</a>
    	</c:forEach>
    	<c:if test="${currentPage < totalPages}">
        <a href="searchCustomers?page=${currentPage + 1}&pageSize=${pageSize}&customerName=${param.customerName}&contact=${param.contact}">[다음]</a>
    	</c:if>
        <c:if test="${count == 0}">
            아직 입력한 정보가 없습니다.
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
</script>

 <!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가했습니다. -->
    <script type="text/javascript">
        $(document).ready(function(){
            $("#selectAll").click(function(){
                $("input[type=checkbox]").prop('checked', this.checked);
            });
        });
    </script>
    
    <!-- 고객명을 입력 했을때 새로 팝업이 열리는 스크립트 추가 -->
    <script type="text/javascript">
    	function openPopup(customerID) {
        window.open('${pageContext.request.contextPath}/customerDetail/' + customerID, 'CustomerDetail', 'width=1000,height=1000,scrollbars=yes,resizable=yes');
    	}
	</script>
</html>