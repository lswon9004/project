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
        .form-container {
            margin-bottom: 20px;
        }
        .form-container input {
            margin-right: 10px;
        }
        .form-container button {
            margin-right: 10px;
        }
         .ck.ck-editor{

        width: 100%;
        }
        .ck-editor__editable {
            min-height: 200px;
        }
        select {
    font-size: 18px;
}
        input {
    font-size: 18px;
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
                <div class="status-overview">
                    <div class="form-container">
        				<h1 style="text-align: center;">결재 신청</h1>
        				<form method="post" action="/approval/update/${dto.approval_no}" name="approvalDto">
        				<table>
        				<colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
        					<tr>
        						<td>문서번호</td>
        						<td>${dto.approval_no}</td>
        						<td>기안일자</td>
        						<td><fmt:formatDate value="${dto.created_date}" pattern="yyyy-MM-dd" /></td>
        					</tr>
        					<tr>
        					<td>서류 종류</td>
        						<td style="margin: 0 0;padding: 0 0;"><select name="approval_type" style="width: 100%;">
        							<option value="1">연차/휴가신청</option>
        							<option value="2">출장신청</option>
        							<option value="3">문서결재</option>
        							<option value="4">비품신청</option>
        						</select></td>
        						<td>사원 번호</td>
        						<td>${dto.empno }</td>
        					</tr>
        					<tr>
        						<td>
        							결재 제목
        						</td>
        						<td > 
        							${dto.approval_title}
        						</td>
        						<td>
        							담당자
        						</td>
        						<td>
        							${dto.approver1_empno }
        						</td>
        					</tr>
        				</table>
        				<textarea id="editor" style="width: 100%; height: 200px;" name="approval_content">${dto.approval_content }</textarea>
        				<input type="submit" value="등록"> <input type="button" value="목록" onclick="location.href='/approval/${user.empno}'">
        				</form>
        				
   					 </div>
   
                </div>
            </section>
        </main>
    </div>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    
    <script>
    ClassicEditor.create( document.querySelector( '#editor' ), {
        language: "ko"
      } );
    </script>
</body>
</html>