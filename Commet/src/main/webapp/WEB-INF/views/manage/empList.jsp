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
        body {
            font-family: Arial, sans-serif;
        }
        h2 {
    		text-align: center; /* 제목을 중앙 정렬 */
    		color: #333; /* 제목 색상을 진한 회색으로 설정 */
    		margin-top: 2px; /* 상단에 20px의 여백을 추가 */
    		margin-bottom: 4px; /* 하단에 20px의 여백을 추가 */
    		
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
        .search-form select {
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
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">00:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a> </c:if><!--다른 jsp 파일에서 적용할거 -->
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a> </c:if> <!--다른 jsp 파일에서 적용할거 -->
                    
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
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
					<c:if test="${user.right>=3 }"> <li><a href="/emp_manage" class="active">직원관리</a></li></c:if>
                </ul>
                <p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            <section class="main-content">
         <h2>직원관리</h2>
    
    <form action="/deleteEmp" method="post">
        <div class="button-container">
            <div class="search-form">
        		<select id="searchType" name="searchType">
            		<option value="empno">사원번호</option>
            		<option value="ename">사원이름</option>
        		</select>
				<input type="text" id="searchInput" name="searchInput" />
        		<button type="button" class="button" onclick="performSearch()">검색</button>
            </div>
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
                        <td><a href="${pageContext.request.contextPath}/empDetail/${emp.empno}">${emp.ename}</a></td>
						<td>${emp.empno}</td>
                        <td>${emp.deptname}</td> <!-- dept에서 가저오는거 안해놔서 안가저옴 -->
                        <td>${emp.deptno}</td> 
                        <td>${emp.position}</td>
                        <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"/></td>
                        <td>${emp.address}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>
    
   <div class="pagination">
        <c:if test="${begin > pageNum}">
            <a href="customerList2?p=${begin-1}">[이전]</a>
        </c:if>
        <c:forEach begin="${begin}" end="${end}" var="i">
            <a href="customerList2?p=${i}">${i}</a>
        </c:forEach>
        <c:if test="${end < totalPages}">
            <a href="customerList2?p=${end+1}">[다음]</a>
        </c:if>
        <c:if test="${count == 0}">
            아직 입력한 정보가 없습니다.
        </c:if>
    </div>

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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
empno = ${user.empno};
datea= ${user.att.startTime}
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
</html>