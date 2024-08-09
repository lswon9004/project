<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>사원검색</title>
</head>
<body>
<div id="search" align="center">
<form action="search">
<select name="searchn">
<option value="0">사원번호</option>
<option value="1">이름</option>
</select>
<input type="text" name="search" size="15" maxlength="50" /> 
<input type="submit" value="검색" />
</form>	
</div>
</body>
</html>