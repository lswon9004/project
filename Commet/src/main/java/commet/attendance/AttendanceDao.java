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
	@Insert("insert into Attendance_Management(empno,deptno) values(#{empno},#{deptno})")
	int insertStartTmie(@Param("empno")int empno,@Param("deptno")int deptno);
	@Select("select check_in from Attendance_Management where empno = #{empno} and date = current_date() ")
	Date startTime(int empno);
	@Update("update Attendance_Management set check_out = now() where empno = #{empno} and date = current_date()")
	int updateEndtime(int empno);
	@Select("select check_out from Attendance_Management where empno = #{empno} and date = current_date() ")
	Date endTime(int empno);
	@Select("select empno from Attendance_Management where date = #{date}")
	List<Integer> vacationList(Date date);
}
