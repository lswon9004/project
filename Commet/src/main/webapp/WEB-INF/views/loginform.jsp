<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>

<html>

  <head>

    <meta charset="utf-8" />

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <link
      rel="stylesheet"
      type="text/css"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />

    <!-- Please DO NOT remove this line, all link and script tags will be merged to here -->
    <link rel="stylesheet" type="text/css" href="/css/UntitledPage22.css" />

  </head>

  <body class="flex-column">

    <div class="untitled-page22 root">
      <div class="flex_row">
        
        <div class="content_box4">
          <div class="flex_col">
            <div class="flex_col1">
              <h1 class="hero_title">WELCOME</h1>
              <div class="text11">사원 번호와 비밀번호를 입력하세요.</div>
            </div>
            
            <div class="content_box2">
              <div class="flex_col2">
                <p class="highlight2">사원번호</p>
                <div class="content_box"><input type="number" id="no" class="highlight11" style="border: none;" placeholder="202410012"></div>
              </div>
            </div>
            <div class="content_box21">
              <div class="flex_col2">
                <p class="highlight2">비밀번호</p>
                <div class="content_box"><input type="password" id="pw" class="highlight11" style="border: none;" placeholder="password"></div>
              </div>
            </div>
            <div class="text"><a href="/findpw"  style="margin-left: 290px">비밀번호 찾기</a></div>
            <button class="btn" onclick="move()">
              <!-- TODO --> 
              로그인
            </button>
          </div>
        </div>
      </div>
    </div>

  </body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function move(){	
	no = $('#no').val()
	pw = $('#pw').val()
	if (!no){
		alert('사번 입력바람');
		return false;
	}
	if (!pw){
		alert('pw 입력하세요');
		return false;
	}
	$.getJSON('/login',{'no':no,'pw':pw},function(data){
		if(data ==='/'){
			alert('failed')
		}else{
		location.href=data
		}
	})
} 
</script>
</html>
