package commet.com.spring.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import commet.com.spring.dao.AdminAttendanceManagementDao;
import commet.com.spring.dto.AttendanceManagementDto;

@Service
public class AdminAttendanceManagementService {
    
	 	@Autowired//연차 . 잔여연차 받아 오는 부분
	    private AdminAttendanceManagementDao dao;
	 	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    int year = cal.get(Calendar.YEAR);
	    int month = cal.get(Calendar.MONTH)+1;
	    String startDateO = year+"-"+month+"-01";
	    String endDateO = year+"-"+month+1+"-01";
	    Date startDate =null;
	    Date endDate = null;
	    
	    // 부서번호가 일치하는 모든 사원의 근태현황 가져오기
	    public List<AttendanceManagementDto> getAllAttendance(int start ,int deptno) {
	    	Map<String, Object> m = new HashMap<String, Object>();
			m.put("start", start);
			m.put("count", 8);
			m.put("empno", deptno);
	        return dao.getAllAttendance(start,deptno);
	    }
	    
	    //관리자 근태현황카운팅
	    public int acount(int deptno) {
	    	 return dao.acount(deptno);
	    }
	
		//관리자 검색 된 리스트
	    public List<AttendanceManagementDto> getAttendanceByEmpNo(Integer empno, int start) {
	        return dao.getAttendanceByEmpNo(empno, start);
	    }
		
		// 검색시 전체 글갯수
	    public int aSCount(int empno) {
	        return dao.getAttendanceCountByEmpNo(empno);
	    }
	    
	    //결근사원등록
	    public String markAsAbsent2(int empno, int deptno) {
	    	int checkedInCount = dao.checkIfCheckedInToday(empno);
	        if (checkedInCount > 0) {  // 이미 출근한 경우
	            return "이미 출근한 사원은 결근 처리할 수 없습니다.";
	        }
	        
	        int absentCount = dao.checkIfAbsentToday(empno);
	        if (absentCount > 0) {  // 이미 결근 처리된 경우
	            return "이미 결근 처리가 되어 있습니다.";
	        }
	        
	        dao.insertAbsentRecord2(empno, deptno); //결근처리
	        return "결근 처리가 완료되었습니다.";
	    }
	    
	    
	    // 엑셀 다운로드할때 필요한 값
	    public List<AttendanceManagementDto> getAllManagement2() {
	        	return dao.getAllManagement2();
	    }
		
	    //연차 . 잔여연차 받아 오는 부분
	    public List<Map<String, Integer>> leaveCount(int empno) {
			try {
				startDate = formatter.parse(startDateO);
		        endDate = formatter.parse(endDateO);

			} catch (ParseException e) {
			
			}
			return dao.leaveCount(empno, startDate, endDate);
		}
	  
}