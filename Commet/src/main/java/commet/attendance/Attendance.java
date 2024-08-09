package commet.attendance;

import java.util.Date;

import lombok.Data;

@Data
public class Attendance {
	int attendance_no;
	int empno;
	int deptno;
	Date date;
	Date check_in;
	Date check_out;
	Date working_hours;
	boolean check_in_status;
	boolean early_leave;
	boolean half_day_off;
	boolean annual_leave;
	boolean vacation;
	boolean late;
	boolean absence;
}
