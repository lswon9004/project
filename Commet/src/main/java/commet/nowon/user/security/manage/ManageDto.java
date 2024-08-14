package commet.nowon.user.security.manage;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ManageDto {
	String ename;         //사원이름
	int empno;           //사원번호
	int deptno;     //부서번호     
	String jop;	//담당업무
	String position;   //관리자,대리,팀장
	String phone;		//전화번호
	String email;           //이메일      
	String address;                   //주소    
	String detailAddr;               //상세주소
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	Date birthday;                //생일
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	Date hiredate;            //입사일
	int sal;                    //급여
	int annual;  //연가(휴가) 저장하려고 만들어뒀던거
	String memo;	//메모
	String imgPath;	//사진경로
	String deptname;  //부서이름
	int authority; // 권한(랭크) 저장한공간
}
