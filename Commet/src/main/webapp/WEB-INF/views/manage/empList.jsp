<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Calendar"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Task Management Portal</title>
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<style>
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

.search-form select {
	padding: 5px;
	width: 100px;
	margin-right: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

caption {
	caption-side: top;
	padding: 10px;
	font-weight: bold;
	text-align: middle;
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
			<section class="main-content">
				<h2>직원관리</h2>
				<div class="header-line"></div>
				<form method="post">
					<div class="button-container">
						<div class="search-form">

							<select class="cbutton" id="searchType" name="searchType">
								<option class="dropdown" value="deptname">부서이름</option>
								<option class="dropdown" value="ename">사원이름</option>
							</select> <input type="text" id="searchInput" name="searchInput" />
							<button type="button" class="button" id="sButton"
								onclick="performSearch()">검색</button>
						</div>
						<div>
							<input type="button" class="button"
								onclick="location.href='/insert'" value="등록" /> 
							<input type="button" class="button" id="downloadButton"
								onclick="downloadExcel()" value="엑셀 다운로드" />
						</div>
					</div>

					<c:forEach var="dept" items="${deptList}">
						<!-- 각 부서에 해당하는 직원이 있는지 확인 -->
						<c:set var="hasEmployees" value="false" />
						<c:forEach var="emp" items="${elist}">
							<c:if test="${emp.deptno == dept.deptno}">
								<c:set var="hasEmployees" value="true" />
							</c:if>
						</c:forEach>
						<!-- 직원이 있는 경우에만 부서 이름과 테이블을 출력 -->
						<c:if test="${hasEmployees}">
							<table>
								<caption>
									<input type="checkbox" class="dept-checkbox"
										name="deptnos" value="${dept.deptno}" /> ${dept.deptname}
								</caption>
								<tr>
								
									<c:forEach var="emp" items="${elist}">
										<c:if test="${emp.deptno == dept.deptno}">
											<th><img src="/upload/${emp.imgPath}"
												alt="Profile Image" width="100"> <br> <a
												href="/empDetail/${emp.empno}" name="empnos"
												value="${emp.empno}"> ${emp.ename} (${emp.position}) </a> </br></th>
										</c:if>
									</c:forEach>
								</tr>
							</table>
						</c:if>
					</c:forEach>

				</form>

				<div class="pagination">
					<c:if test="${begin > 1}">
						<a
							href="searchEmps?empno=${param.empno}&ename=${param.ename}&p=${begin-1}">[이전]</a>
					</c:if>
					<c:forEach begin="1" end="${totalPages}" var="i">
						<a
							href="searchEmps?empno=${param.empno}&ename=${param.ename}&p=${i}">${i}</a>
					</c:forEach>
					<c:if test="${end < totalPages}">
						<a
							href="searchEmps?empno=${param.empno}&ename=${param.ename}&p=${end+1}">[다음]</a>
					</c:if>
				</div>

			</section>
	</div>
</body>

<footer>
	<p class="footer-text">
		현재시간 : <span id="current-time" style=""></span>
	</p>
	&nbsp;
	<p class="footer-text">코멧업무포털</p>
</footer>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
        function performSearch() {
            const searchType = document.getElementById('searchType').value;
            const searchInput = document.getElementById('searchInput').value.trim();// 입력 값을 trim()으로 처리
            
            let url = '/searchEmps?';
            if (searchType === 'deptname') {
                if (searchInput === '') { // 숫자가 아니거나 빈 값인 경우 예외 처리
                    alert('정확한 부서이름을 입력하세요.');
                    return;
                }
                url += 'deptname=' + searchInput;
            } else if (searchType === 'ename') {
            	 if (searchInput === '') { //빈 값인 경우 예외 처리
            		 alert('정확한 사원이름을 입력하세요.');
                     return;
                 }
                url += 'ename=' + encodeURIComponent(searchInput);
            }
            location.href = url;
        }
    </script>

<script>
    // 엑셀 다운로드
    function downloadExcel() {
            
                const selectedCheckboxes = document.querySelectorAll('.dept-checkbox:checked');
                
                if (selectedCheckboxes.length === 0) {
                    alert('다운로드할 부서를 선택해주세요.');
                    return;
                }
                
                const deptnos = [];
                selectedCheckboxes.forEach(checkbox => {
                    deptnos.push(checkbox.value);
                });

                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '/downloadDeptExcel';
                form.style.display = 'none';

                deptnos.forEach(deptno => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'deptnos';
                    input.value = deptno;
                    form.appendChild(input);
                });

                document.body.appendChild(form);
                form.submit();
        }
    
	</script>

<script type="text/javascript"> 
empno = ${user.empno};
$('#start').click(function(){
	deptno = ${user.deptno};
	$.getJSON("/startTime",{'empno':empno,'deptno':deptno},function(data){
		if (data){			
			$('#startTime').text(data+'/');
			console.log(data)
		 }else{
			alert('이미 출근버튼을 누르셨습니다.')
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

$(document).ready(function(){
	 // 엔터 키를 눌렀을 때 검색이 되도록 추가된 부분
    $("#searchInput").keypress(function(event) {
        if (event.which === 13) { // 엔터 키의 키 코드는 13입니다.
        	event.preventDefault();// 기본 폼 제출x
            $('#sButton').click(); // 검색 버튼클릭
        }
    });
    
	
	 
});
</script>

<!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가했습니다. -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<script type="text/javascript"> 
empno = ${user.empno};
deptno = ${user.deptno};
</script>
<script type="text/javascript" src="/js/main.js"></script>
</html>