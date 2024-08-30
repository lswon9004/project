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
            font-weight: bold; /* 글씨체를 굵게 설정 */
            color: #000; /* 기본 텍스트 색상 */
            transition: color 0.3s, background-color 0.3s; /* 부드러운 전환 효과 */
        }

        .nav-item i {
            font-size: 20px;
            margin-bottom: 3px;
             color: #000; /* 기본 아이콘 색상 */
            transition: color 0.3s; /* 부드러운 전환 효과 */
    
       	/* color: #777; */
        }
        
         /* Hover 시 스타일 */
        .nav-item:hover {
            color: #0056b3; /* Hover 시 텍스트 색상 변경 */
           
        }
        
        .nav-item:hover i {
            color: #0056b3; /* Hover 시 아이콘 색상 변경 */
        }
        
        /* 	로고부분 */
        .logo-container {
            display: flex;
            align-items: center;
            justify-content: flex-start; /* 왼쪽 정렬 */
        }

		
        .logo-container img {
            width: 25px;
            height: 25px;
            margin-right: 6px;
            margin-top: 15px;
        }

        .hero_title {
            font-size: 24px;
            font-weight: bold;
        }
        
    </style>
    
</head>

<header style="border-radius: 150px;">
    <div class="user-info"><!-- 박선욱 a-->
        <img src="/upload/${user.imgPath}" alt="User Profile">
        <div>
            <p>이름: ${user.ename }</p>
            <p>직책: ${user.position }</p>
            <p>사번: ${user.empno }</p>
            <p>${user.ename }님 환영합니다.</p>
        </div>
    </div> 
    <div class="flex_col1 logo-container">
    
    <h1><img src="/css/logo/logo.png" alt="Company Logo" >
        코멧<c:if test="${user.right>=3}"> 관리자</c:if> 업무포털
          
    </h1>
  
    
    </div>
    <div class="header-right">
        <button id="start">업무시작</button>
        <button id="end">업무종료</button>
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