package commet.com.spring.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import commet.com.spring.dto.AttendanceManagementDto;

@Mapper
public interface AttendanceManagementDao {
	//관리자가 볼 페이지 메서드 근태현황 전체출력 페이징처리
	@Select("SELECT * FROM Attendance_Management WHERE deptno = #{deptno} ORDER BY employee_attendance_no DESC LIMIT #{start}, 8")
	List<AttendanceManagementDto> getAllAttendance(@Param("start") int start, @Param("deptno") int deptno);
	
	//관리자 전체 페이지 출력될 카운팅
	@Select("select count(*) from Attendance_Management  where deptno = #{deptno}")
	int acount(int deptno); 
	
	// 목록 카운팅 글 목록이 없을때 글이 없다고 표시함
	@Select("select count(*) from Attendance_Management where empno = #{empno}")
		int count(@Param("empno")int empno); 
	
	//사원별로 최대 출근번호를 가져오는 메서드
	@Select("select coalesce(max(employee_attendance_no), 0) from Attendance_Management WHERE empno = #{empno}")
	Integer getMaxEmployeeAttendanceNo(@Param("empno") int empno);

	//출근버튼 클릭시 입력 될 값들
	@Insert("INSERT INTO Attendance_Management (empno, deptno, employee_attendance_no, date, check_in, worktype) VALUES (#{empno}, #{deptno}, #{employeeAttendanceNo}, current_date(), now(), "
	        + "CASE "
	        + "WHEN TIME(now()) < '09:20:00' THEN '정상출근' "
	        + "WHEN TIME(now()) >= '09:21:00' THEN '지각' "
	        + "END)")
	int insertStartTime(@Param("empno") int empno, 
	                    @Param("deptno") int deptno, 
	                    @Param("employeeAttendanceNo") int employeeAttendanceNo);
	
	//퇴근버튼 클릭 변경될 타입
	 @Update("update Attendance_Management set "
		        + "check_out = now(), "
		        + "worktype = case "
		        + "when time(check_in) > '09:21:00' and time(now()) < '18:19:00' then '지각/조퇴' "
		        + "when time(check_in) > '09:21:00' and time(now()) > '18:19:00' then '지각/정상퇴근' "
		        + "when time(now()) < '18:19:00' then '조퇴' "
		        + "else '정상퇴근' "
		        + "end "
		        + "where empno = #{empno} and date = current_date()")
		int updateEndtime(int empno); // 지각및 조퇴 
	 
	 //출퇴근 시간이 입력이 안됐을시 결근 표시지만 구현 안되고 잇음 자동으로 입력안됨
	 @Update("update Attendance_Management " 
	            + "set worktype = '결근' "
	            + "where empno = #{empno} and date = current_date() and check_in is null")
	    void markAbsent(int empno);
	 
	 // 출근체크 출근일자가 입력 돼 있으면 출근버튼 못누름
	 @Select("select count(*) from Attendance_Management where empno = #{empno} and date = current_date()")
	    int hasCheckedInToday(@Param("empno") int empno); 
	 
	//체크인시간 들고 오는
	@Select("select check_in from Attendance_Management where empno = #{empno} and date = current_date() ")
	   Date startTime(int empno); 
   
	// 조건에 맞는 검색 기능
	@Select({
	    "<script>",
	    "SELECT * FROM Attendance_Management",
	    "WHERE 1=1",
	    "<if test='empno != null'>",
	    "AND empno = #{empno}",
	    "</if>",
	    "<if test='deptno != null'>",
	    "AND deptno = #{deptno}",
	    "</if>",
	    "<if test='startDate != null and endDate != null'>",
	    "AND date BETWEEN #{startDate} AND #{endDate}",
	    "</if>",
	    "ORDER BY employee_attendance_no DESC",
	    "LIMIT #{start}, 10",
	    "</script>"
	})
	List<AttendanceManagementDto> getAttendanceByDateRange(
	    @Param("empno") Integer empno,
	    @Param("deptno") Integer deptno,
	    @Param("startDate") Date startDate,
	    @Param("endDate") Date endDate,
	    @Param("start") int start
	);
   
    // 검색글 카운팅
    @Select("select count(*) from Attendance_Management where empno = #{empno} and date between #{startDate} and #{endDate} ") 
    int getAttendanceCount(@Param("empno") int empno, 
    									@Param("deptno") int deptno, 
    									@Param("startDate") Date startDate, 
    									@Param("endDate") Date endDate);

    // 글목록 리스트 최신글이 먼저 보이게 order by CustomerID desc 걸어둠
	@Select("select * from Attendance_Management  where empno = #{empno} order by employee_attendance_no desc limit #{start}, #{count}")
	List<AttendanceManagementDto> managementList(Map<String,Object>m);
	
	//전체글 갯수
	@Select("select count(*) from Attendance_Management")
	int count2(); 
	
	// 고객정보조회 엑셀출력
	@Select("select * from Attendance_Management order by employee_attendance_no desc")
	List<AttendanceManagementDto> getAllManagement(); 
	
	@Update("update attendance_management set check_in = now() where empno =#{empno} and date = current_date")
	   int updateStartTime(int empno);
	
	}