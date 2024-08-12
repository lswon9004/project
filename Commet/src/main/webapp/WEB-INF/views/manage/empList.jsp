<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>직원관리</title>
    <style>
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
        .search-form select {
            padding: 5px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
    
    <!-- jQuery를 사용하여 “전체 선택” 체크박스를 클릭하면 모든 체크박스를 선택하거나 선택 해제할 수 있도록 스크립트를 추가했습니다. -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#selectAll").click(function(){
                $("input[type=checkbox]").prop('checked', this.checked);
            });
        });
    </script>
</head>
<body>
    <h2>직원관리</h2>
    
    <form action="${pageContext.request.contextPath}/deleteEmp" method="post">
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
                <button type="button" class="button" onclick="location.href='${pageContext.request.contextPath}/insert'">등록
                <button type="button" class="button" onclick="downloadExcel()">엑셀다운로드</button>
                <button type="submit" class="button">삭제</button>
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
        const contextPath = '<%= request.getContextPath() %>';

        function performSearch() {
            const searchType = document.getElementById('searchType').value;
            const searchInput = document.getElementById('searchInput').value;
            
            let url = contextPath + '/searchEmps?';
            if (searchType === 'empno') {
                url += 'empno=' + searchInput;
            } else if (searchType === 'ename') {
                url += 'ename=' + searchInput;
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
    
</body>
</html>