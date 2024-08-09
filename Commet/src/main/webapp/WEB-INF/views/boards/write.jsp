<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- 메타데이터 설정 -->
    <meta charset="UTF-8">
    <title>게시판 글쓰기</title>
    <!-- 폰트 스타일링 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <style>
        /* 전체 페이지 스타일 */
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

        /* 제목 스타일 */
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

        /* 네비게이션 스타일 */
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

        /* 메인 컨텐츠 스타일 */
        main {
            padding: 20px;
            background: #fff;
            margin-top: 20px;
        }

        /* 글쓰기 폼 스타일 */
        .write-form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        textarea {
            height: 200px;
        }

        /* 액션 버튼 스타일 */
        .actions {
            text-align: right;
        }

        .actions button {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background: #333;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .actions button[type="submit"] {
            background: #77a1d3;
        }
    </style>
</head>
<body>
    <div class="container"> <!-- 페이지의 컨테이너 역할 -->
        <header> <!-- 페이지의 헤더 영역 -->
            <h1>글쓰기</h1>
        </header>
        <main> <!-- 메인 컨텐츠 영역 -->
            <form action="/boards/write" method="post"> <!-- 글쓰기 폼 -->
                <div class="form-group"> <!-- 작성자 번호 입력 필드 -->
                    <label for="empno">작성자 번호</label>
                    <input type="text" id="empno" name="empno" required readonly="readonly" value="${user.empno}">
                </div>
                <div class="form-group"> <!-- 제목 입력 필드 -->
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group"> <!-- 내용 입력 필드 -->
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="actions"> <!-- 액션 버튼들 -->
                    <button type="submit">저장</button> <!-- 저장 버튼 -->
                    <button type="button" onclick="window.location.href='/boards'">취소</button> <!-- 취소 버튼 -->
                </div>
            </form>
        </main>
    </div>
</body>
</html>