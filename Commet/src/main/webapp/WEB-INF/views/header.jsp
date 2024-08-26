<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
   <!-- Font Awesome CSS 파일 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>/* 메인CSS로 옮겨도됨 수정하기 편하게 따로 빼둠 */
        .nav-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 5px;
            font-size: 10px;
        }

        .nav-item i {
            font-size: 20px;
            margin-bottom: 3px;
       	/* color: #777; */
        }
    </style>
    
</head>

<header>
    <div class="user-info"><!-- 박선욱 a-->
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
            <c:if test="${user.check_in==null}">00:00 / </c:if>
        </p>
        <p id="endTime">
            <c:if test="${user.check_out !=null}">
                <fmt:formatDate value="${user.check_out}" pattern="HH:mm" />/
            </c:if>
            <c:if test="${user.check_out==null}">00:00</c:if>
        </p>
           <nav>
            <c:if test="${user.right<3}">
                <a class="nav-item active" href="/main">
                    <i class="fas fa-home"></i>
                    Home
                </a>
            </c:if>
            <c:if test="${user.right>=3}">
                <a class="nav-item active" href="/adminMain">
                    <i class="fas fa-home"></i>
                    Home
                </a>
            </c:if>
            <a class="nav-item" href="/staffModify">
                <i class="fas fa-user-cog"></i>
                개인정보수정
            </a>
            <a class="nav-item" href="/bullboard">
                <i class="fas fa-comments"></i>
                익명게시판
            </a>
            <a class="nav-item" href="/logout">
                <i class="fas fa-sign-out-alt"></i>
                로그아웃
            </a>
        </nav>
    </div>
</header>