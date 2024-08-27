$('#start').click(function(){
   $.getJSON("/startTime",{'empno':empno,'deptno':deptno},function(data){
      if (data){
		alert("출근 완료")         
       }else{
         alert('이미 출근버튼을 누르셨습니다.')
      } 
   })
})
$('#end').click(function(){
   $.getJSON('/endTime',{'empno':empno},function(data){
		alert("퇴근 완료")
   })
})
