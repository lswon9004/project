<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="/css/UntitledPage22.css" />

</head>
<body class="flex-column">
<div class="untitled-page22 root">
<div class="container" style="margin: auto;">
<h2>비밀번호 5회 틀림</h2>
      <div class="flex_row" style="margin: auto;">
        <div class="content_box4">

    
    <form method="post" id="findpw">
        <input id="empno" type="number" name="empno" required="required" placeholder="사번"><br>
        <input type="email" name="email" id="email" placeholder="이메일">
        <input  type="button" id="btn" value="email확인" onclick="emailCheck()"><br>
        <button id="btn1">비밀번호 초기화</button>
    </form>
</div>
</div>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

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
