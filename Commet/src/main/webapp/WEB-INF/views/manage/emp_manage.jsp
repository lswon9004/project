<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Task Management Portal</title>
<link rel="stylesheet" type="text/css" href="/css/main.css" />

</head>
<body>
	<div class="container">
		<header>
			<div class="user-info">
				<img src="profile.jpg" alt="User Profile">
				<div>
					<p>이름: 김자바</p>
					<p>직책: 대리</p>
					<p>사번: 100100</p>
					<p>김자바 님 환영합니다.</p>
				</div>
			</div>
			<h1>코멧 업무포털</h1>
			<div class="header-right">
				<button>업무시작</button>
				<button>업무종료</button>
				<p>09:05</p>
				<p>18:05</p>
				<nav>
					<a href="#">Home</a> <a href="#">연봉계산기</a> <a href="#">개인정보수정</a> <a
						href="#">로그아웃</a>
				</nav>
			</div>
		</header>
		<main>
			<aside>
				<ul class="menu">
					<li><a href="#">통합업무</a></li>
					<li><a href="#">게시판</a></li>
					<li><a href="#">전자결재</a></li>
					<li><a href="#">결재승인</a></li>
					<li><a href="#">캘린더</a></li>
					<li><a href="/manage/emp_manage">직원관리</a></li>
					<li><a href="#">관찰관리</a></li>
				</ul>
				<p class="footer-text">현재시간 : 24/07/31 수요일 09:15</p>
				<p class="footer-text">코멧업무포털</p>
			</aside>
			<section>
				<div id="search" align="center">
					<form action="search">
						<select name="searchn">
							<option value="0">사원번호</option>
							<option value="1">이름</option>
						</select> <input type="text" name="search" size="15" maxlength="50" /> <input
							type="submit" value="검색" />
					</form>
				</div>
				
				<table>
					<tr>
						<th>사원 이름</th>
						<th>사원 번호</th>
						<th>부서</th>
						<th>직급</th>
						<th>입사일</th>
						<th>주소</th>
					</tr>
					<%-- <tr th:each="employee : ${employees}">
            			<td th:text="${employee.name}"></td>
            			<td th:text="${employee.id}"></td>
            			<td th:text="${employee.department}"></td>
            			<td th:text="${employee.position}"></td>
            			<td th:text="${employee.joinDate}"></td>
            			<td th:text="${employee.address}"></td>
       				 </tr> --%>
				</table>
			</section>
		</main>
	</div>
</body>
</html>