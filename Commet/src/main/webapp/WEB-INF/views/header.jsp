<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <h1>
        코멧<c:if test="${user.right>=3}"> 관리자</c:if> 업무포털
    </h1>
    <div class="header-right">
        <button id="start">업무시작</button>
        <button id="end">업무종료</button>
        <p id="startTime">
            <c:if test="${user.check_in !=null}">
                <fmt:formatDate value="${user.check_in}" pattern="HH:mm" />/
            </c:if>
            <c:if test="${user.check_in==null}">00:00/</c:if>
        </p>
        <p id="endTime">
            <c:if test="${user.check_out !=null}">
                <fmt:formatDate value="${user.check_out}" pattern="HH:mm" />/
            </c:if>
            <c:if test="${user.check_out==null}">00:00/</c:if>
        </p>
        <nav>
            <c:if test="${user.right<3}"><a class="active" href="/main">Home</a></c:if>
            <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a></c:if>
            <a href="/staffModify">개인정보수정</a>
            <a href="/bullboard">익명게시판</a>
            <a href="/logout">로그아웃</a>
        </nav>
    </div>
</header>