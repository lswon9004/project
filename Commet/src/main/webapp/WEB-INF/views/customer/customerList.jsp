<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Calendar" %>
<!-- CSS는 Main 으로 이동 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management Portal</title>
        <link rel="stylesheet" type="text/css" href="/css/main.css" />
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
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a> </c:if> <!--다른 jsp 파일에서 적용할거 -->                    
                    <a href="#">개인정보수정</a>
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
                 
      <!-- 여기서부터 가운데 메인 -->
      <section class="main-content">
    		<h2>고객정보</h2>
    	<form action="${pageContext.request.contextPath}/deleteCustomer" method="post">
        <div class="button-container">
            <div class="search-form">
                			<input type="text" name="customerName" placeholder="고객명" id="customerName">
                            <input type="text" name="contact" placeholder="연락처 (전체입력시 - 포함)" id="contact">
                            <input type="text" name="empno" placeholder="접수사번" id="empno">
                            <button type="button" class="button" id="searchButton">검색</button>
            
        <!-- 변경된 부분: dropdown 대신 select 사용 -->
        
        <select id="statusSelect" class="cbutton" onchange="filterByStatus(this.value)">
            <option class="dropdown" value="전체">전체</option>
            <option class="dropdown" value="Received">접수완료</option>
            <option class="dropdown" value="Consulted">상담완료</option>
            <option class="dropdown" value="Complaint">민원인</option>
        </select>
        
            </div>
            <div>
                <button type="button" class="button" onclick="location.href='/info'">등록</button>
                <button type="button" class="button" onclick="location.href='/downloadExcel'">엑셀다운로드</button>
                <button type="submit" class="button" >삭제</button>
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>접수번호</th>
                    <th>고객명</th>
                    <th>생년월일</th>
                    <th>연락처</th>
                    <th>진행상태</th>
                    <th>접수일자</th>
                    <th>접수사번</th>
                </tr>
            </thead>
            <tbody>
             <c:if test="${count == 0}">
					<tr>
						<td colspan="8" class="tac">고객 정보가 없습니다.</td>
					</tr>
				</c:if>
                <c:forEach var="customer" items="${blist}">
                    <tr>
                        <td><input type="checkbox" name="customerIds" value="${customer.customerID}"></td>
                        <td>${customer.customerID}</td>
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
                           <td>${customer.empno}</td>
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
        </c:if>
    </div>
</section><!-- 가운데 메인 끝나는 곳 -->
        </main>
    </div>
</body>
<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>

	<!--메인화면에서 출근 버튼을 눌렀을때 발생 되는 스크립트문-->
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

 <!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가 및 검색 기능 -->
    <script type="text/javascript">
        $(document).ready(function(){
            $("#selectAll").click(function(){
                $("input[type=checkbox]").prop('checked', this.checked);
            });
            
        	 // 엔터 키를 눌렀을 때 검색이 되도록 추가된 부분
            $('#customerName, #contact , #empno').keypress(function(event) {
                if (event.which === 13) { // 엔터 키의 키 코드는 13입니다.
                    $('#searchButton').click(); // 검색 버튼을 클릭합니다.
                }
            });

            // 검색 버튼 클릭 이벤트
            $('#searchButton').click(function() {
                const customerName = $('[name=customerName]').val();
                const contact = $('[name=contact]').val();
                const empno = $('[name=empno]').val();
                location.href = '/searchCustomers?customerName=' + customerName + '&contact=' + contact + '&empno=' + empno;
            });
        });
    </script>
    
    <!-- 삭제 버튼에 대한 클릭 이벤트를 처리하는 스크립트 추가 -->
	<script type="text/javascript">
    	$(document).ready(function(){	
        	$("button[type=submit]").click(function(event){
            	// 고객 ID 체크박스가 하나도 선택되지 않았으면 아무 동작도 하지 않음
            if ($("input[name='customerIds']:checked").length === 0) {
                event.preventDefault(); // 기본 동작(폼 제출) 취소
        		 /*alert('삭제할 항목을 선택하세요.');  알러트 창이 검색 할때도 나타나서 주석처리함*/
            	}
        	});
    	});
	</script>

    <!-- 고객명을 입력 했을때 새로 팝업이 열리는 스크립트 추가 -->
    <script type="text/javascript">
    	function openPopup(customerID) {
        window.open('${pageContext.request.contextPath}/customerDetail/' + customerID, 'CustomerDetail', 'width=1000,height=1000,scrollbars=yes,resizable=yes');
    	}
	</script>
	
	<!-- 진행상태 별 선택한 값에 따라 필터링 동작 구현 -->
	<script type="text/javascript">
	function filterByStatus(status) {
	    if (status === "전체") {
	        location.href = '${pageContext.request.contextPath}/searchCustomers';
	    } else if (status) {
	        location.href = '${pageContext.request.contextPath}/filterByStatus?status=' + status;
	    }
	}
	</script>

	<!--현재시간 -->
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
	</html>