<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <style>
    	/* 전체적인 스타일 설정 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
		/* 컨테이너 스타일 */
        .container {
            width: 90%;
            margin: auto;
            overflow: hidden;
        }
		/* 헤더 스타일 */
        header {
            background: #e6e6e6;
            color: #000;
            padding: 20px 0;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
		/* 사용자 정보 스타일 */
        .user-info {
            display: flex;
            align-items: center;
            margin-left: 20px;
        }
		/* 사용자 이미지 스타일 */
        .user-info img {
            border-radius: 50%;
            margin-right: 10px;
            width: 50px;
            height: 50px;
        }
        .user-info p {
            margin: 0;
            padding: 0;
        }
        h1 {
            margin: 0;
            padding: 0;
            font-size: 24px;
        }
		/* 로그아웃 링크 스타일 */
        .logout a {
            color: #333;
            text-decoration: none;
            font-size: 16px;
            margin-right: 20px;
        }
		/* 네비게이션 바 스타일 */
        nav {
            margin-top: 20px;
            background: #333;
            color: #fff;
        }
        nav ul {
            padding: 0;
            list-style: none;
            display: flex;
            justify-content: space-around;
        }
        nav ul li {
            display: inline;
            margin: 0;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
            padding: 15px 20px;
            display: inline-block;
        }
        nav ul li a:hover, .active {
            background: #77a1d3;
        }
		/* 메인 콘텐츠 스타일 */
        main {
            display: flex;
            margin-top: 20px;
        }
		/* 사이드바 스타일 */
        aside {
            width: 25%;
            padding: 20px;
            background: #fff;
            border-right: 1px solid #ddd;
        }
        aside .menu {
            padding: 0;
            list-style: none;
        }
        aside .menu li {
            margin-bottom: 10px;
        }
        aside .menu li a {
            color: #333;
            text-decoration: none;
            display: block;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        aside .menu li a:hover {
            background: #77a1d3;
            color: #fff;
        }
        aside .footer-text {
            margin-top: 20px;
            color: #777;
            font-size: 14px;
        }
		/* 메인 콘텐츠 내부 스타일 */
        .main-content {
            width: 75%;
            padding: 20px;
            background: #fff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .form-group textarea {
            resize: vertical;
            height: 150px;
        }
        .form-actions {
            text-align: right;
        }
        .form-actions button {
            padding: 10px 20px;
            border: none;
            background: #333;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }
        footer {
            margin-top: 20px;
            text-align: center;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container"> <!-- 모든 콘텐츠를 포함하고 중앙 정렬된 컨테이너 -->
        <header> <!-- 페이지의 헤더를 표시하며, 사용자 정보와 로그아웃 링크를 포함 -->
            <div class="user-info">
                <img src="profile_picture_url" alt="Profile Picture" width="50" height="50">
                <div class="profile-info">
                    <div class="name">Java Park</div>
                    <div class="rank">Lv.5</div>
                    <div>Java Park님 환영합니다.</div>
                </div>
            </div>
            <a href="/logout" class="logout">로그아웃</a>
        </header>
        <main>
            <aside>
                <p class="footer-text">현재시간 : 2024/07/29 수요일 09:15</p>
                <p class="footer-text">코멧업무포털</p>
            </aside>
            <section class="main-content">
                <h2>게시글 수정</h2> <!-- 페이지 콘텐츠의 제목 표시 -->
                <!-- 수정된 게시글 내용 제출 폼 -->
                <form action="/boards/edit/${board.no}" method="post">
                    <div class="form-group"> <!-- 폼 요소 그룹화 -->
                        <label for="title">제목</label> <!-- 제목 입력 필드 레이블 -->
                        <!-- 게시글 제목 입력 필드. 현재 게시글 제목이 기본값으로 설정 -->
                        <input type="text" id="title" name="title" value="${board.title}" required>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label> <!-- 내용 입력 필드 레이블 -->
                        <!-- 게시글 내용을 입력하는 텍스트 영역. 현재 게시글 내용이 기본값으로 설정 -->
                        <textarea id="content" name="content" required>${board.content}</textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit">수정</button> <!-- 폼 제출 버튼 -->
                    </div>
                </form>
            </section>
        </main>
        <footer>
            <p>&copy; 2022 Brand, Inc. Privacy · Terms · Sitemap</p>
            <p>USD</p>
        </footer>
    </div>
</body>
</html>