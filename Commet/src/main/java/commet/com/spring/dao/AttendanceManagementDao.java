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
	@Select("select count(*) from Attendance_Management where empno = #{empno}")
		int count(@Param("empno")int empno); // 목록 카운팅 글 목록이 없을때 글이 없다고 표시함
		  
	 @Insert("insert into Attendance_Management(empno, deptno, date, check_in, worktype) values(#{empno}, #{deptno}, current_date, now(), "
	            + "case "
	            + "when time(now()) < '09:20:00' then '정상출근' "
	            + "when time(now()) >= '09:21:00' then '지각' "
	            + "end)")
	    int insertStartTime(@Param("empno") int empno, 
	    					@Param("deptno") int deptno); // 출근
	
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
	 
	 @Update("update Attendance_Management " //결근
	            + "set worktype = '결근' "
	            + "where empno = #{empno} and date = current_date() and check_in is null")
	    void markAbsent(int empno);
	 
	
	 @Select("select count(*) from Attendance_Management where empno = #{empno} and date = current_date()")
	    int hasCheckedInToday(@Param("empno") int empno); // 출근체크 출근일자가 입력 돼 있으면 출근버튼 못누름
	 
	
	@Select("select check_in from Attendance_Management where empno = #{empno} and date = current_date() ")
	   Date startTime(int empno); //체크인시간 들고 오는
   
    @Select({"<script>select * FROM Attendance_Management",
    	" <where>",
    	"empno = #{empno}",
    	" <if test=\"startDate != null and endDate != null \"> and date between #{startDate} and #{endDate}</if> </where> limit #{start},10</script>"}) 
    List<AttendanceManagementDto> getAttendanceByDateRange(@Param("empno") int empno, 
    																							@Param("startDate") Date startDate, 
    																							@Param("endDate") Date endDate,
    																							@Param("start")int start);// 검색
   
    @Select("select count(*) from Attendance_Management where empno = #{empno} and date between #{startDate} and #{endDate} ") 
    int getAttendanceCount(@Param("empno") int empno, 
    									@Param("startDate") Date startDate, 
    									@Param("endDate") Date endDate);// 검색글 카운팅

    
	@Select("select * from Attendance_Management  where empno = #{empno} order by attendance_no desc limit #{start}, #{count}")
	List<AttendanceManagementDto> managementList(Map<String,Object>m); // 글목록 리스트 최신글이 먼저 보이게 order by CustomerID desc 걸어둠
	
	@Select("select count(*) from Attendance_Management")
	int count2(); //전체글 갯수
	
	@Select("select * from Attendance_Management order by attendance_no desc")
	List<AttendanceManagementDto> getAllManagement(); // 고객정보조회 엑셀출력
	
	}