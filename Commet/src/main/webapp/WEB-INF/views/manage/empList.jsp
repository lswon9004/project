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
    <form action="/deleteEmp" method="post">
        <div class="button-container">
            <div class="search-form">

        		<select class="cbutton" id="searchType" name="searchType">
            		<option class="dropdown" value="empno">사원번호</option>
            		<option class="dropdown" value="ename">사원이름</option>
        		</select>
				<input type="text" id="searchInput" name="searchInput"/>
        		<button type="button" class="button" id="sButton" onclick="performSearch()">검색</button>
            </div>
<!--             1 -->
            <div>
                <input type="button" class="button" onclick="location.href='/insert'" value="등록"/> 
                <input type="button" class="button" onclick="downloadExcel()" value="엑셀다운로드"/>
                <input type="submit" class="button" value="삭제"/>
            </div>
        </div>
        <table>
            <thead><!-- 받아올 값의 이름들 -->
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>사원이름</th>
                    <th>사원번호</th>
                    <th>부서</th>
                    <th>부서번호</th>
                    <th>직급</th>
                    <th>입사일</th>
                    <th>주소</th>
                </tr>
            </thead>
            <tbody> <!-- 받아온 값을 표시 -->
                <c:forEach var="emp" items="${elist}">
                    <tr>
                        <td><input type="checkbox" name="empnos" value="${emp.empno}"></td>
                        <td><a href="/empDetail/${emp.empno}">${emp.ename}</a></td>
						<td>${emp.empno}</td>
                        <td>${emp.deptname}</td> <!-- dept에서 가저오는거 안해놔서 안가저옴 -->
                        <td>${emp.deptno}</td> 
                        <td>${emp.position}</td>
                        <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"/></td>
                        <td>${emp.address}</td>
                    </tr>
                </c:forEach>
            </tbody>
             <c:if test="${count == 0}">
					<tr>
						<td colspan="5" class="tac">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>
        </table>
    </form>
    
   <div class="pagination">
        <c:if test="${begin > 1}">
            <a href="emp_manage?p=${begin-1}">[이전]</a>
        </c:if>
        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="emp_manage?p=${i}">${i}</a>
        </c:forEach>
        <c:if test="${end < totalPages}">
            <a href="emp_manage?p=${end+1}">[다음]</a>
        </c:if>
    </div>

</script>
    <script>
        function performSearch() {
            const searchType = document.getElementById('searchType').value;
            const searchInput = document.getElementById('searchInput').value.trim();// 입력 값을 trim()으로 처리
            
            let url = '/searchEmps?';
            if (searchType === 'empno') {
                if (isNaN(searchInput) || searchInput === '') { // 숫자가 아니거나 빈 값인 경우 예외 처리
                    alert('정확한 사원번호를 입력하세요.');
                    return;
                }
                url += 'empno=' + searchInput;
            } else if (searchType === 'ename') {
            	 if (searchInput === '') { //빈 값인 경우 예외 처리
					System.out.print(ename);
            		 alert('정확한 사원이름을 입력하세요.');
                     return;
                 }
                url += 'ename=' + encodeURIComponent(searchInput);
            }
            location.href = url;
        }
    </script>
    
    <script>
    function downloadExcel() {
        // 체크박스에 체크된 것들만 엑셀 다운로드
        const checkboxes = document.querySelectorAll('input[name="empnos"]:checked');

        if (checkboxes.length === 0) {
            alert('다운로드할 항목을 선택해주세요.');
            return; // 함수 종료, 폼 제출하지 않음
        }
        
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/downloadEmpExcel';
        form.style.display = 'none';

        checkboxes.forEach((checkbox) => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'empnos';
            input.value = checkbox.value;
            form.appendChild(input);
        });

        document.body.appendChild(form);
        form.submit();
    }
	</script>
    
            </section>
        </main>
    </div>
</body>

<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	$("button[type=submit]").click(function(event){
    	// 고객 ID 체크박스가 하나도 선택되지 않았으면 아무 동작도 하지 않음
    if ($("input[name='empnos']:checked").length === 0) {
        event.preventDefault(); // 기본 동작(폼 제출) 취소
		 *alert('삭제할 항목을 선택하세요.');  알러트 창이 검색 할때도 나타나서 주석처리함*
    	}
	});
});

$(document).ready(function(){
	<!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가 및 검색 기능 -->
    $("#selectAll").click(function(){
        $("input[type=checkbox]").prop('checked', this.checked);
    });
    
	 // 엔터 키를 눌렀을 때 검색이 되도록 추가된 부분
    $("#searchInput").keypress(function(event) {
        if (event.which === 13) { // 엔터 키의 키 코드는 13입니다.
            $('#sButton').click(); // 검색 버튼을 클릭합니다.
        }
    });
    
	
	 
});
</script>

    <!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가했습니다. -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#selectAll").click(function(){
                $("input[type=checkbox]").prop('checked', this.checked);
            });
        });
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

    // 처음 페이지 로드 시 시간을 표시
    updateTime();

    // 매 초마다 시간을 업데이트
    setInterval(updateTime, 1000);
</script>
</html>