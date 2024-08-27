<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>사원 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .modal {
            display: block;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .modal img {
            display: block;
            margin: auto;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #888;
            border-radius: 8px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
        }
		
        h2 {
            font-size: 24px;
            color: #333;
            margin: 0 0 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
        
        button, #addressSearchBtn { /* 주소검색 CSS   a*/
    	padding: auto;
    	margin-top: 5px;
    	border: none;
   		background-color: #00bfff;
    	color: #fff;
    	cursor: pointer;
    	border-radius: 4px;
    	align-self: flex-start;
		}
				
		button:hover, #addressSearchBtn:hover {
    	background-color: #ccc;
		}
		
        input[type="text"],
        input[type="email"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[readonly],
        textarea[readonly] {
            background-color: #f4f4f4;
            color: #666;
        }

		select[readonly] {
		  background-color: #f4f4f4;
		  color: #666;
		  pointer-events: none;
		}


        textarea {
            resize: none;
            height : 200px;
        }

        .buttons {
            text-align: right;
            margin-top: 20px;
        }

        .buttons button {
            padding: 10px 20px;
            margin-left: 5px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }
        
        .buttons button:last-child {
            background-color: #ccc;
        }
        
        /* 사진 미리보기 컨테이너 */
		.photo-preview {
    		text-align: center; /* 사진 미리보기를 가운데 정렬 */
    		margin-top: 1px; /* 상단에 20px의 여백 추가 */
		}

		.photo-preview img {
    		width: 180px; /* 미리보기 이미지의 너비 설정 */
    		height: 180px; /* 미리보기 이미지의 높이 설정 */
    		border-radius: 50%; /* 이미지를 동그랗게 보이도록 설정 */
    		object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 조정 */
    	}
        /* 생년월일 칸 사이즈 */
        .info#info__birth {
		  display: flex;
		}

		.info#info__birth select {
 		  margin-left : 7px;
		}

		.info#info__birth select:first-child {
		  margin-left : 0px;
		}
        
    </style>
    
</head>
<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="location.href='/emp_manage'">&times;</span>
        <h2>신입 사원정보 입력</h2>
        <div class="header">
            <!-- 사진 업로드 폼 -->
            <form action="/employee/uploadPhoto" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="photo"></label>
                    <input type="file" name="imgPath" id="imgPath" accept="image/*">
                </div>
                <div class="button-container">
                    <input type="submit" value="업로드">
                    <input type="hidden" name="redirectPage" value="newEmp">
                </div>
            </form>   

            <!-- 사진 미리보기 -->
            <div class="photo-preview">
                <c:if test="${not empty InserEmpDto.imgPath}">
                    <img id="previewImage" src="/upload/${InserEmpDto.imgPath}" alt="">
                </c:if>
            </div>
        </div>

         <form action="/saveinsert" method="post" modelAttribute="InserEmpDto" onsubmit="combineBirthday()">
            <input type="hidden" name="imgPath" value="${InserEmpDto.imgPath}"> 
            <input type="hidden" id="birthday" name="birthday">
            <table>
            <tr>
                <td>사원 이름:</td><td><input type="text" name="ename" required></td>
            </tr>
            <tr>
				<td>부서:</td> <!-- db에서 dept 부서와 번호 저장 안해두면 작동안할수있음-->
				<td>	
					<select name="deptno" required> 
						<option value="" disabled selected>선택하세요</option>
        				<c:forEach var="dept" items="${deptList}">
        				 	<option value="${dept.deptno}">${dept.deptname}</option>
    					</c:forEach>
					</select>
				</td>
				<td>직급:</td>
				<td>
				<select name="position" required>
					<option value="" disabled selected>선택하세요</option>
        				<c:forEach var="position" items="${positionList}">
        				 	<option value="${position.position}">${position.position}</option>
    					</c:forEach>
				</select>
				</td>
            </tr>
            <tr>
				<td>연락처:</td><td><input type="text" name="phone" oninput="autoHyphen(this)" maxlength="13" placeholder="010-1234-1234" required></td>
				<td>이메일:</td><td><input type="text" name="email" placeholder="abc@gmail.com" required></td>
            </tr>
            <tr>
 				<td>주소:</td><td><input type="text" id="address" name="address" required>
                <button type="button" onclick="execDaumPostcode()">주소 검색</button></td> 				
  				<td>상세주소:</td><td><input type="text" name="detailAddr" ></td>
            </tr>
            <tr>
	    		<td>생년월일:</td>
	    		<td>
	    		<div class="info" id="info__birth" name="birthday">
  				<select class="box" id="birth-year">
  				<option disabled selected>출생 연도</option>
 				</select>
 				<select class="box" id="birth-month">
  				<option disabled selected>월</option>
  				</select>
  				<select class="box" id="birth-day">
    			<option disabled selected>일</option>
  				</select>
				</div>
				</td>
<!-- 	    		<input type="date" name="birthday" required></td> -->
    			<td>입사일:</td><td><input type="date" name="hiredate" required></td>
            </tr>
             <tr>
	    		<td>급여:</td><td><input type="text" name="sal" required></td>
            </tr>
            <tr>
            	<td>메모:</td>
                <td colspan="5">
                    <textarea name="memo"></textarea>
                </td>
            </tr> 
            </table>
            <div class="buttons">
                <button type="submit">등록</button>
                <button type="button" onclick="location.href='/emp_manage'">닫기</button>
               
            </div>
        </form>
    </div>
</div>

    <!-- Daum 주소 검색 API 스크립트 추가 -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>    
    <script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; 
                var jibunAddr = data.jibunAddress; 

                document.getElementById('address').value = roadAddr || jibunAddr;
            }
        }).open();
    }
    </script>
    <script>
	const autoHyphen = (target) =>{
		target.value = target.value
			.replace(/[^0-9]/g, '')
			.replace(/^(\d{3})(\d{3,4})(\d{4})$/, "$1-$2-$3")
	}
    </script>
    
    <script>
 	// '출생 연도' 셀렉트 박스 option 목록 동적 생성
    const birthYearEl = document.querySelector('#birth-year')
    // option 목록 생성 여부 확인
    isYearOptionExisted = false;
    birthYearEl.addEventListener('focus', function () {
      // year 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isYearOptionExisted) {
        isYearOptionExisted = true
        for(var i = 1940; i <= 2024; i++) {
          // option element 생성
          const YearOption = document.createElement('option')
          YearOption.setAttribute('value', i)
          YearOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(YearOption);
        }
      }
    });
    
 	//  '월' 셀렉트 박스 option 목록 동적 생성
    const birthMonthEl = document.querySelector('#birth-month')
    // option 목록 생성 여부 확인
    isMonthOptionExisted = false;
    birthMonthEl.addEventListener('focus', function () {
      // month 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isMonthOptionExisted) {
        isMonthOptionExisted = true
        for(var i = 1; i <= 12; i++) {
          // option element 생성
          const MonthOption = document.createElement('option')
          MonthOption.setAttribute('value', i)
          MonthOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(MonthOption);
        }
      }
    });
    
 	//  '일' 셀렉트 박스 option 목록 동적 생성
    const dayMonthEl = document.querySelector('#birth-day')
    // option 목록 생성 여부 확인
    isDayOptionExisted = false;
    dayMonthEl.addEventListener('focus', function () {
      // day 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isDayOptionExisted) {
        isDayOptionExisted = true
        for(var i = 1; i <= 31; i++) {
          // option element 생성
          const DayOption = document.createElement('option')
          DayOption.setAttribute('value', i)
          DayOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(DayOption);
        }
      }
    });
    </script>

	<script>
		function combineBirthday() {
    		const year = document.getElementById('birth-year').value;
    		const month = document.getElementById('birth-month').value;
    		const day = document.getElementById('birth-day').value;

    		if (year && month && day) {
        		const birthday = year + '-' + (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day;
       		 	document.getElementById('birthday').value = birthday;
    		}
		}
</script>

</body>
</html>