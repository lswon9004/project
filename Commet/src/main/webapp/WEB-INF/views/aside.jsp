<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

  			<aside>
                <ul class="menu"><!-- 박선욱 a-->
                    <li><a href="/searchCustomers">고객문의</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                     <c:if test="${user.right>=2 }"> <li><a href="/attendance/adminManagementList">전체사원근태현황</a></li></c:if>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=2 }"> <li><a href="/emp_manage" >직원관리</a></li></c:if>
                </ul>
            </aside>