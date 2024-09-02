package commet.com.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AttendanceManagementDto {
    
	private int attendance_no; // 출퇴근번호
	private String ename;//사원이름
    private int empno; // 사원번호
    private int deptno; // 부서번호
    private Date date; // 날짜
    private Date check_in; // 출근시간
    private Date check_out; // 퇴근시간
    private int working_hours; // 근로시간
    private int check_in_status; //출근
    private int early_leave; // 조퇴
    private int half_day_off; // 반차
    private int annual_leave; // 연차
    private int vacation; // 휴가
    private int late; // 지각
    private int absence; // 결근
    private String worktype; // 출근현황
    private int employee_attendance_no; // 출근번호
  
    
  
}