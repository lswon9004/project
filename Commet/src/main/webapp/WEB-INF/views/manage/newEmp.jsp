<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>회원정보등록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            position: relative;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        label {
            margin: 5px 0;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="date"],
        select,
        textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        .photo-container {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .photo-container img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        .button-container {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            border: none;
            background-color: #00bfff;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #ccc;
        }

        .message {
            grid-column: 1 / -1;
            color: #ff0000;
            text-align: center;
            margin-top: 20px;
        }

        .authority-container {
            display: flex;
            align-items: center;
        }

        .authority-container select {
            margin-left: 10px;
            flex-grow: 1;
        }

    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    <title>직원 정보 입력</title>
     <style>
        /* 전체 페이지의 폰트와 배경색, 레이아웃 중앙 정렬 */
body {
    font-family: Arial, sans-serif; /* 페이지 전체에 적용할 기본 폰트 설정 */
    background-color: #f9f9f9; /* 페이지 배경색 설정 */
    margin: 0; /* 페이지의 기본 여백 제거 */
    padding: 0; /* 페이지의 기본 패딩 제거 */
    display: flex; /* 페이지를 플렉스 컨테이너로 설정하여 중앙 정렬에 사용 */
    justify-content: center; /* 수평 방향으로 중앙 정렬 */
    align-items: center; /* 수직 방향으로 중앙 정렬 */
    height: 100vh; /* 화면 높이의 100%를 차지 */
}

/* 페이지 제목 스타일 */
h2 {
    text-align: center; /* 텍스트를 중앙에 정렬 */
    color: #333; /* 텍스트 색상 설정 */
}

/* 메인 폼 컨테이너 스타일: 크기, 배경, 테두리, 그림자 효과 */
.container {
    width: 800px; /* 컨테이너의 최대 너비 설정 */
    margin: 50px auto; /* 위, 아래 50px의 여백을 두고, 좌우는 중앙 정렬 */
    padding: 20px; /* 컨테이너 내부에 20px의 패딩을 추가 */
    border: 1px solid #ddd; /* 컨테이너 테두리 설정 */
    border-radius: 8px; /* 모서리를 둥글게 설정 */
    background-color: #fff; /* 컨테이너 배경색을 흰색으로 설정 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 효과 추가 */
}

/* 헤더 부분(프로필 사진) 스타일 */
.header {
    text-align: center; /* 헤더 내부의 모든 요소를 중앙에 정렬 */
    margin-bottom: 20px; /* 아래쪽에 20px의 여백 추가 */
}

/* 프로필 사진 스타일: 크기 및 모양 조정 */
.header img {
    border-radius: 50%; /* 이미지의 모서리를 둥글게 만들어 원형으로 보이게 함 */
    width: 120px; /* 이미지의 너비 설정 */
    height: 120px; /* 이미지의 높이 설정 */
    object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 조정 */
    display: block; /* 이미지를 블록 요소로 처리 */
    margin: 0 auto; /* 이미지가 중앙에 오도록 좌우 마진 설정 */
}

/* 각 입력 필드 그룹의 스타일: 유연한 배치와 하단 여백 */
.form-group {
    display: flex; /* 수평 정렬을 위해 플렉스 박스 사용 */
    justify-content: space-between; /* 레이블과 입력 필드 간의 균등한 공간 배분 */
    align-items: center; /* 레이블과 입력 필드를 수직으로 중앙 정렬 */
    margin-bottom: 15px; /* 각 입력 필드 그룹 하단에 여백 추가 */
}

.form-group label {
    width: 150px; /* 레이블의 고정 너비 설정 */
    text-align: right; /* 텍스트를 오른쪽 정렬 */
    font-weight: bold; /* 텍스트를 굵게 표시 */
    color: #333; /* 텍스트 색상 설정 */
}

label {
    margin-left: -50px;
}

.form-group input[type="text"],
.form-group input[type="date"],
.form-group textarea {
    flex: 1; /* 입력 필드가 남은 공간을 채우도록 설정 */
    padding: 8px; /* 입력 필드 내부에 패딩 추가 */
    border: 1px solid #ddd; /* 입력 필드 테두리 설정 */
    border-radius: 4px; /* 입력 필드 모서리를 둥글게 설정 */
}

.address-group {
    display: flex; /* 주소 입력란과 버튼을 나란히 배치 */
    gap: 10px; /* 입력란과 버튼 사이의 간격 설정 */
    flex: 1; /* 입력란이 남은 공간을 채우도록 설정 */
}

.address-group input {
    flex: 1; /* 주소 입력란이 남은 공간을 채우도록 설정 */
}

/* 버튼 컨테이너 스타일: 버튼들의 오른쪽 정렬 */
.button-container {
    display: flex; /* 플렉스 컨테이너로 설정하여 버튼을 정렬 */
    justify-content: flex-end; /* 버튼들을 오른쪽으로 정렬 */
    gap: 10px; /* 버튼들 사이에 10px의 간격 추가 */
    margin-top: 20px; /* 상단에 20px의 여백 추가 */
}

/* 기본 버튼 스타일 */
.button-container button {
    padding: 10px 20px; /* 버튼 내부에 10px 위아래, 20px 좌우의 패딩 추가 */
    border: none; /* 버튼의 기본 테두리 제거 */
    border-radius: 4px; /* 버튼의 모서리를 둥글게 설정 */
    background-color: #00bfff; /* 버튼의 배경색 설정 */
    color: #fff; /* 버튼의 텍스트 색상 설정 */
    cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능함을 표시 */
}

/* 버튼 호버 상태 스타일 */
.button-container button:hover {
    background-color: #009acd; /* 마우스 호버 시 버튼의 배경색 변경 */
}

/* 마지막 버튼(닫기 버튼) 스타일 */
.button-container button:last-child {
    background-color: #ccc; /* 닫기 버튼의 배경색 설정 */
    color: #333; /* 닫기 버튼의 텍스트 색상 설정 */
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

    </style>
    
</head>
<body>

    <div class="container">

        <h2>직원 정보 등록</h2>
        <div class="header">
            <!-- 사진 업로드 폼 -->
            <form action="/employee/uploadPhoto" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="photo"></label>
                    <input type="file" name="imgPath" id="imgPath" accept="image/*">
                </div>
                <div class="button-container">
                    <input type="submit" value="업로드">
                </div>
            </form>

            <!-- 사진 미리보기 -->
            <div class="photo-preview">
                <c:if test="${not empty photoPath}">
                    <img id="previewImage" src="${photoPath}" alt="">
                </c:if>
            </div>
        </div>

        <form action="/saveinsert" method="post" modelAttribute="InserEmpDto">
            <div class="form-group">
                <label for="ename">사원이름 :</label>
                <input type="text" id="ename" name="ename" required>

                <label for="empno">사원번호 :</label>
                <input type="text" id="empno" name="empno" required>
            </div>

            <div class="form-group">
                <label for="deptno">부서번호 :</label>
                <input type="text" id="deptno" name="deptno" required>

                <label for="position">직급 :</label>
                <input type="text" id="position" name="position" required>
            </div>

            <div class="form-group">
                <label for="phone">연락처 :</label>
                <input type="text" id="phone" name="phone" required>

                <label for="email">이메일 :</label>
                <input type="text" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="zipcode">주소입력 :</label>
                <div class="address-group">
                    <input type="text" id="zipcode" name="zipcode" placeholder="우편번호"   readonly>
                </div>
                <label for="address">주소 :</label>
                <input type="text" id="address" name="address" required>
                <button type="button" onclick="execDaumPostcode()">주소 검색</button>
            </div>

            <div class="form-group">
                <label for="birthday">생년월일 :</label>
                <input type="date" id="birthday" name="birthday" required>

                <label for="annual">연차 :</label>
                <input type="text" id="annual" name="annual" required>
            </div>

            <div class="form-group">
                <label for="hiredate">입사일 :</label>
                <input type="date" id="hiredate" name="hiredate" required>

                <label for="sal">연봉 :</label>
                <input type="text" id="sal" name="sal" required>
            </div>

            <div class="form-group">
                <label for="memo">메모 :</label>
                <textarea id="memo" name="memo"></textarea>
            </div>

            <div class="button-container">
                <button type="submit">등록</button>
                <button type="button" onclick="location.href='/emp_manage'">닫기</button>
            </div>
        </form>
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress; // 도로명 주소
                    var jibunAddr = data.jibunAddress; // 지번 주소
                    document.getElementById('address').value = roadAddr || jibunAddr;
                    document.getElementById('zipcode').value = data.zonecode; // 우편번호
                }
            }).open();
        }
    </script>
    
     <script>
        // 사진 미리보기 기능
        function readImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = (e) => {
                    const previewImage = document.getElementById('previewImage');
                    previewImage.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 파일 선택 시 미리보기 기능 연결
        document.getElementById('imgPath').addEventListener('change', (e) => {
            readImage(e.target);
        });
    </script>

</body>
</html>
