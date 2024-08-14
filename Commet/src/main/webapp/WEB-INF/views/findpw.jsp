<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 초기화</title>
    <link rel="stylesheet" type="text/css" href="/css/UntitledPage22.css" />
    <style>
        /* Reset 기본 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* 페이지 전체 스타일 */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f8f8;
        }

        /* 컨테이너 스타일 */
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

        /* 제목 스타일 */
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        /* 입력 필드 스타일 */
        input[type="number"],
        input[type="email"],
        input[type="text"],
        input[type="password"],
        button {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 25px;
            font-size: 16px;
        }

        /* 버튼 스타일 */
        button, 
        input[type="button"] {
            background-color: #00bfff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* 버튼 hover 스타일 */
        button:hover, 
        input[type="button"]:hover {
            background-color: #0056b3;
        }

        /* 인증 번호 및 이메일 확인 버튼 스타일 */
        #btn,
        #btn2,
        #btn3 {
            width: auto;
            padding: 8px 20px;
            margin-left: 10px;
            border-radius: 20px;
        }

        /* 메시지 스타일 */
        .message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }

        /* 이메일 링크 스타일 */
        a {
            display: block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>비밀번호 5회 틀림</h2>
        <form method="post" id="findpw">
            <input id="empno" type="number" name="empno" required="required" placeholder="사번"><br>
            <input type="email" name="email" id="email" placeholder="이메일">
            <input type="button" id="btn" value="email확인" onclick="emailCheck()"><br>
            <button id="btn1">비밀번호 초기화</button>
        </form> 
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        var num;
        function emailCheck(){
            empno = $('#empno').val();
            email = $('#email').val();
              $.getJSON("/emailCheck",{'empno':empno,'email':email},function(data){
                  if(data){
                      $('#btn1').before("<input type='text' id='checknumber' name='checknumber' placeholder='인증번호'> ");
                      $('#btn1').before(" <input type='button' id='btn2' onclick='numberCheck()' value='인증번호 발급'><br>");
                  }else{
                      alert("이메일주소가 잘못되었습니다.")
                  }
                  
        }) 
        }
        function numberCheck(){
             $.getJSON("/send",{'email':email},function(data){
                 if(eval(data[1])){
                    num = data[0];
                    $('#btn2').before("<input type='button' id='btn3' onclick='numberCheck2()' value='인증번호 확인'> ")
                    alert("메일이 전송되었습니다. 인증번호를 입력하세요.")
                    
                 }
        })
        }
        function numberCheck2(){
            checknumber = $('#checknumber').val()
            if(checknumber == num){
                $('#btn1').after('<p class="message">인증성공</p>')
                $('#btn1').after("<input type='hidden' id='ck' value='1'>")
            }else{
                $('#btn1').after('<p class="message">인증실패</p>')
            }
        }
        $('#findpw').submit(function(){
            if($("#ck").val() != 1){
                alert("email 확인을 하셔야 합니다.")
                return false;
            }
            return true;
        })
        
    </script>
</body>
</html>
