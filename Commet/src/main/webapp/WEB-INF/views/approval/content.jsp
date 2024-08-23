<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management Portal</title>
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <style>
        /* 스타일 추가 */
        .approval-form-container {
            max-width: 1000px;
            margin-left: 270px;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .approval-form-container h1 {
            text-align: center;
            margin-bottom: 20px;
            margin-left: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .approval-form-container table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .approval-form-container table th,
        .approval-form-container table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .approval-form-container table th {
            background-color: #f9f9f9;
            font-weight: bold;
        }

        .approval-form-container textarea {
            width: 100%;
            height: 200px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
            resize: none;
        }

        .approval-form-container .form-actions {
            text-align: right;
        }

        .approval-form-container .form-actions button {
            padding: 10px 20px;
            margin-left: 10px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }

        .approval-form-container .form-actions button.cancel {
            background-color: #ccc;
        }

        .approval-form-container select {
            width: 100%;
            padding: 4px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .approval-form-container .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
          .ck.ck-editor{

        max-width: 100%;
        }
        .ck-editor__editable {
            min-height: 200px;
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
                <div class="approval-form-container">
                    <h1>결재내용</h1>
                        <table>
                            <tr>
                                <th>문서번호</th>
                                <td>${dto.approval_no}</td>
                                <th>기안일자</th>
                                <td><fmt:formatDate value="${user.check_in}" pattern="yyyy-MM-dd" /></td>
                            </tr>
                            <tr>
                                <th>서류 종류</th>
                                 <td>
                                    <c:choose>
                                        <c:when test="${dto.approval_type == 1}">연차/휴가신청</c:when>
                                        <c:when test="${dto.approval_type == 2}">출장신청</c:when>
                                        <c:when test="${dto.approval_type == 3}">문서결재</c:when>
                                        <c:when test="${dto.approval_type == 4}">비품신청</c:when>
                                    </c:choose>
                                    </td>
                                <th>사원 번호</th>
                                <td>${user.empno}</td>
                            </tr>
                           <tr>
                                <th>결재 제목</th>
                                <td>${dto.approval_title}</td>
                                <th>담당자</th>
                                <td>${dto.approver1_empno}</td>
                            </tr>
                        </table>
                        <div class="section-title">결재내용</div>
                        <div>
                        	첨부파일
                        	<a href="/fileDownload/${fdto.file_no }">${fdto.fname } </a>
                        </div>
                        <textarea id="editor" style="width: 100%; height: 100px; pointer-events: none;" readonly="readonly">${dto.approval_content}</textarea>
                        <div class="section-title">결재 의견</div>
                        <textarea style="width: 100%; height: 100px;" readonly="readonly">${dto.approval_comm}</textarea>
                        <div class="form-actions">
                            <button onclick="location.href='/approval/update/${dto.approval_no}';">수정</button>
                            <button onclick="location.href='/approval/${user.empno}';">목록</button>
                        </div>
                    </div>
            </section>
        </main>
    </div>
    <footer>
        <p class="footer-text">현재시간 : <span id="current-time"></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
    </footer>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    
    <script>
    ClassicEditor.create(document.querySelector('#editor'), {
        language: "ko",
        ckfinder: { uploadUrl: 'http://localhost:8083/img/upload' }
    }).then(editor => {
        window.editor = editor;
        editor.enableReadOnlyMode('#editor'); // 읽기 전용 모드 설정
    }).catch(error => {
        console.error(error);
    });

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

        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
