<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
   <!-- Font Awesome CSS 파일 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
   <style>/* 메인CSS로 옮겨도됨 수정하기 편하게 따로 빼둠 */
   	.menu a i {
    margin-right: 10px; /* 아이콘과 텍스트 사이의 간격 */
    font-size: 15px; /* 아이콘 크기 */
    /*  color: #00796b; 아이콘 색상 */
	}
   </style>
   
</head>

 <aside>  <!-- 각 a태그에 id값을 할당해서 스크립트로 현재상태 스타일링 -->
    <ul class="menu">
    
        <li><a href="/customerList" id="menu-searchCustomers"><i class="fas fa-users"></i>고객문의</a></li>
        <li><a href="/attendance/managementList" id="menu-managementList"><i class="fas fa-clock"></i>근태현황</a></li>
        <c:if test="${user.right >= 3}">
        <li><a href="/attendance/adminManagementList" id="menu-adminManagementList"><i class="fas fa-user-tie"></i>전체사원근태현황</a></li>
        </c:if>
        <li><a href="/boards" id="menu-boards"><i class="fas fa-comments"></i>공지사항</a></li>
        <li><a href="/approval/${user.empno}" id="menu-approval"><i class="fas fa-file-alt"></i>전자결재</a></li>
        <c:if test="${user.right >= 2}">
        <li><a href="/approval/status" id="menu-approvalStatus"><i class="fas fa-check-square"></i>결재승인</a></li>
       	</c:if>               
        <c:if test="${user.right >= 3}">
        <li><a href="/emp_manage" id="menu-empManage"><i class="fas fa-user-cog"></i>직원관리</a></li>
        </c:if>
    </ul>
</aside>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 현재 URL 경로를 가죠옴
        var currentPath = window.location.pathname;
        
        // 경로와 메뉴 항목을 비교하여 'active' 클래스를 추가합니다.
        if (currentPath.includes("/customerList")) {
            document.getElementById("menu-searchCustomers").classList.add("active");
        } else if (currentPath.includes("/attendance/managementList")) {
            document.getElementById("menu-managementList").classList.add("active");
        } else if (currentPath.includes("/attendance/adminManagementList")) {
            document.getElementById("menu-adminManagementList").classList.add("active");
        } else if (currentPath.includes("/boards")) {
            document.getElementById("menu-boards").classList.add("active");
        } else if (currentPath.includes("/approval") && !currentPath.includes("/status")) {
            document.getElementById("menu-approval").classList.add("active");
        } else if (currentPath.includes("/approval/status")) {
            document.getElementById("menu-approvalStatus").classList.add("active");
        } else if (currentPath.includes("/emp_manage")) {
            document.getElementById("menu-empManage").classList.add("active");
        }
    });
</script>