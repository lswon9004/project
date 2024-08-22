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
       .form-container form {
    display: flex;
    flex: 1;
    align-items: center;
}

.form-container form select, 
.form-container form input,
.form-container form button {
    margin-right: 10px;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ddd;
}

button[type="submit"] {
    background: #00bfff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

.form-container button:last-child {
    margin-left: auto;
    background: #00bfff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

        .paging{text-align:center;margin:15px 0;}
		.paging strong{display:inline-block;width:25px;height:25px;line-height:24px;marging-right:5px;border:1px solid #ccc;color:#666;text-align:cetner;}
		.paging .page{display:inline-block;width:25px;height:25px;line-height:24px;margin-right:5px;background:#49be5a;color:#fff;text-align:center;}
       
    </style>   
</head>
<body>
      <div class="container">
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
            <h1>코멧 업무포털</h1>
            <div class="header-right">
                <button id="start">업무시작</button>
                <button id="end">업무종료</button>
                <p id="startTime"><c:if test="${startTime !=null}"><fmt:formatDate value="${startTime}" pattern="HH:mm" />/</c:if><c:if test="${startTime==null}">0d:00/</c:if></p>
                <p id="endTime">00:00</p>
                <nav>
                    <c:if test="${user.right<3}"><a class="active" href="/main">Home</a> </c:if><!--다른 jsp 파일에서 적용할거 -->
                    <c:if test="${user.right>=3}"><a class="active" href="/adminMain">Home</a> </c:if> <!--다른 jsp 파일에서 적용할거 -->                    
                    <a href="#">개인정보수정</a>
                    <a href="/bullboard">익명게시판</a>
                    <a href="/logout">로그아웃</a>
                </nav>
            </div>
        </header>
        <main>
            <aside>
                <ul class="menu">
                    <li><a href="/searchCustomers">통합업무</a></li>
                     <li><a href="/attendance/managementList">근태현황</a>
                    <li><a href="/boards">게시판</a></li>
                    <li><a href="/approval/${user.empno}">전자결재</a></li>
                    <c:if test="${user.right>=2 }"> <li><a href="/approval/status">결재승인</a></li></c:if>
                    <c:if test="${user.right>=2 }"> <li><a href="/emp_manage" class="active">직원관리</a></li></c:if>
                </ul>
            </aside>
            
            
            <section class="main-content">
                <div class="status-overview">
                    <div class="form-container">
        				<h1 >결재 신청</h1>
        				<form method="post" action="/approval/insert" name="approvalDto" enctype="multipart/form-data">
        				<table>
        				<colgroup>
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
			<col style="width:25%;" />
		</colgroup>
        					<tr>
        						<td>문서번호</td>
        						<td>${approval_no}</td>
        						<td>기안일자</td>
        						<td><fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd" /></td>
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
        						<td>${user.empno }</td>
        					</tr>
        					<tr>
        						<td>
        							결재 제목
        						</td>
        						<td style="margin: 0 0;padding: 0 0;"> 
        							<input type="text" style="width: 100%;" placeholder="제목을 입력하세요" name="approval_title" required="required">
        						</td>
        						<td>
        							담당자
        						</td>
        						<td style="margin: 0 0;padding: 0 0;">
        							<select name="approver1_empno" style="width: 100%;">
        								<c:forEach items="${elist}" var="deptno">
        									<option value="${deptno }">${deptno }</option>
        								</c:forEach>
        							</select>
        						</td>
        					</tr>
        				</table>
        				<input type="hidden" name="approval_no" value="${approval_no}">
        				<input type="file" name="file">
        				<textarea id="editor" style="width: 100%; height: 200px;" name="approval_content"></textarea>
        				<input type="submit" value="등록">
        				</form>
        				<button onclick="history.go(-1)">취소</button>
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
        language: "ko", ckfinder:{uploadUrl:'http://localhost:8083/img/upload'}
      }).then(editer => {
    	  window.editer = editer
      }).catch(error => {
    	  console.error(error)
      });
    </script>
</body>
<footer>
<p class="footer-text">현재시간 : <span id="current-time" style=""></span></p>&nbsp;<p class="footer-text">코멧업무포털</p>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <script>
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

    // 처음 페이지 로드 시 시간을 표시
    updateTime();

    // 매 초마다 시간을 업데이트
    setInterval(updateTime, 1000);
</script>

</html>