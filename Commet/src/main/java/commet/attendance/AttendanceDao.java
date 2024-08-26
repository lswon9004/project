package commet.attendance;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface AttendanceDao {
	@Insert("insert into Attendance_Management(empno,deptno,check_in,date,worktype, employee_attendance_no) values(#{empno},#{deptno},now(),current_date, case when time(now()) < '09:20:00' then '정상출근' when time(now()) >= '09:21:00' then '지각' end,#{employeeAttendanceNo})")
	int insertStartTmie(@Param("empno")int empno,@Param("deptno")int deptno,@Param("employeeAttendanceNo") int employeeAttendanceNo);
	@Select("select check_in from Attendance_Management where empno = #{empno} and date = current_date() ")
	Date startTime(int empno);
	@Update("update Attendance_Management set "
	        + "check_out = now(), "
	        + "worktype = case "
	        + "when time(check_in) > '09:21:00' and time(now()) < '18:19:00' then '지각/조퇴' "
	        + "when time(check_in) > '09:21:00' and time(now()) > '18:19:00' then '지각/정상퇴근' "
	        + "when time(now()) < '18:19:00' then '조퇴' "
	        + "else '정상퇴근' "
	        + "end "
	        + "where empno = #{empno} and date = current_date()")
	int updateEndtime(int empno);
	@Select("select check_out from Attendance_Management where empno = #{empno} and date = current_date() ")
	Date endTime(int empno);
	@Select("select empno from Attendance_Management where date = #{date}")
	List<Integer> vacationList(Date date);
	@Insert("insert into Attendance_Management(empno,deptno,date,worktype) values(#{empno},#{deptno},#{date},'휴가')")
	int insertdata(@Param("empno")int empno,@Param("deptno")int deptno,@Param("date")Date date);
	@Update("Update Attendance_Management set worktype = '휴가' where empno = #{empno} and date = #{date}")
	int updatedata(@Param("empno")int empno,@Param("date")Date date);
	@Select("SELECT COUNT(*) AS work_days "
			+ "FROM attendance_management "
			+ "WHERE empno = #{empno} "
			+ "AND check_in IS NOT NULL "
			+ "AND date BETWEEN #{startDate} AND #{endDate}")
	int AttCount(@Param("empno")int empno,@Param("startDate")Date startDate,@Param("endDate")Date endDate);
	@Select("SELECT COUNT(*) AS work_days "
			+ "FROM attendance_management "
			+ "WHERE empno = #{empno} "
			+ "AND worktype ='지각' "
			+ "AND date BETWEEN #{startDate} AND #{endDate}")
	int TardinessCount(@Param("empno")int empno,@Param("startDate")Date startDate,@Param("endDate")Date endDate);
	@Select("select count(*) from attendance_management where empno = #{empno} and date = current_date")
	int scount(int empno);
	@Update("update attendance_management set check_in = now() where empno =#{empno} and date = current_date")
	int updateStartTime(int empno);
	@Select("select count(*) from attendance_management where empno = #{empno} and worktype = '병가' AND date BETWEEN #{startDate} AND #{endDate}")
	int sick_leaveCount(@Param("empno")int empno,@Param("startDate")Date startDate,@Param("endDate")Date endDate);
	@Select("select count(*) from attendance_management where empno = #{empno} and worktype = '휴가' AND date BETWEEN #{startDate} AND #{endDate}")
	int leaveCount(@Param("empno")int empno,@Param("startDate")Date startDate,@Param("endDate")Date endDate);
	@Select("select count(*) from attendance_management where empno = #{empno} and worktype = '결근' AND date BETWEEN #{startDate} AND #{endDate}")
	int abCount(@Param("empno")int empno,@Param("startDate")Date startDate,@Param("endDate")Date endDate);
}
