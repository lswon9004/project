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
public interface AdminAttendanceManagementDao {
	//관리자가 볼 페이지 메서드 근태현황 전체출력 페이징처리
	@Select("SELECT * FROM Attendance_Management WHERE deptno = #{deptno} ORDER BY employee_attendance_no DESC LIMIT #{start}, 8")
	List<AttendanceManagementDto> getAllAttendance(@Param("start") int start, @Param("deptno") int deptno);
	
	//관리자 전체 페이지 출력될 카운팅
	@Select("select count(*) from Attendance_Management  where deptno = #{deptno}")
	int acount(int deptno); 
	
	// 목록 카운팅 글 목록이 없을때 글이 없다고 표시함
	@Select("select count(*) from Attendance_Management where empno = #{empno}")
		int count(@Param("empno")int empno); 
   
	// 사원번호로만 검색하는 메서드
    @Select({
        "SELECT * FROM Attendance_Management",
        "WHERE empno = #{empno}",
        "ORDER BY employee_attendance_no DESC",
        "LIMIT #{start}, 8"
    })
    List<AttendanceManagementDto> getAttendanceByEmpNo(
        @Param("empno") Integer empno,
        @Param("start") int start
    );
	
    // 검색 결과에 따른 글 카운팅
    @Select("select count(*) from Attendance_Management where empno = #{empno}")
    int getAttendanceCountByEmpNo(@Param("empno") int empno);
    
    // 엑셀출력
 	@Select("select * from Attendance_Management order by employee_attendance_no desc")
 	List<AttendanceManagementDto> getAllManagement2(); 
	
	}