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
        
        
         /*         여기서부터 customerList */
         
        body {
            font-family: Arial, sans-serif;
            
        }
        h2 {
            text-align: center;
            margin: 20px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            border: 1px solid #e0e0e0;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f8f8f8;
            color: #333;
            font-weight: bold;
        }
        td {
            background-color: #fff;
        }
        tr:nth-child(even) td {
            background-color: #f2f2f2;
        }
        input[type="checkbox"] {
            transform: scale(1.2);
        }
        
        .button {
            margin: 5px;
            padding: 10px 20px;
            background-color: #00bfff;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .button:hover {
            background-color: #ccc;
        }
        .dropdown {
            display: inline-block;
            position: relative;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a {
            margin: 0 5px;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            color: #007bff;
            border-radius: 4px;
        }
        .pagination a.active {
            font-weight: bold;
            background-color: #007bff;
            color: white;
        }
        .pagination a:hover {
            background-color: #0056b3;
            color: white;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .search-form {
            display: flex;
            align-items: center;
        }
        .search-form input {
            padding: 5px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
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