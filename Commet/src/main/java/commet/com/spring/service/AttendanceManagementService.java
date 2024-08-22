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

import commet.com.spring.dao.AttendanceManagementDao;
import commet.com.spring.dto.AttendanceManagementDto;

@Service
public class AttendanceManagementService {
    
	 	
	 	
	 	@Autowired//연차 . 잔여연차 받아 오는 부분
	    private AttendanceManagementDao dao;
	 	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    int year = cal.get(Calendar.YEAR);
	    int month = cal.get(Calendar.MONTH)+1;
	    String startDateO = year+"-"+month+"-01";
	    String endDateO = year+"-"+month+1+"-01";
	    Date startDate =null;
	    Date endDate = null;
	 	
	 	
	 	
	    //사원별로 출근일수 따로 따로 저장
	 	public int generateNextAttendanceNo(int empno) {
	 		int maxAttendanceNo = dao.getMaxEmployeeAttendanceNo(empno); // 사원별로 가장 큰 출근번호를 조회합니다.
	 		 return maxAttendanceNo + 1; // 만약 출근번호가 없으면 1부터 시작합니다.
	 	}
	 	
	 	//출근
	 	public void checkIn(int empno, int deptno, int employeeAttendanceNo) {
	 	    
	 		if (hasCheckedInToday(empno)) {
	 			Date startTime = dao.startTime(empno);
	 			if(startTime==null) {
	 				dao.updateStartTime(empno);
	 			}
	 		}else {
	 			dao.insertStartTime(empno, deptno, employeeAttendanceNo);
	 		}
	 	}
	 	
	 	//퇴근
		public void checkOut(int empno) { 
		        dao.updateEndtime(empno);
		}
		
		//결근
		public void markAbsent(int empno) {
		        dao.markAbsent(empno);
		    }
		
		// 출근일자가 0보다 크면 출근 버튼 못누름
		public boolean hasCheckedInToday(int empno) { 
				return dao.hasCheckedInToday(empno) > 0;
	    }

		//일반 검색 된 리스트
	    public List<AttendanceManagementDto> getAttendanceByDateRange2(int empno, Date startDate, Date endDate,int start) { 
	        	return dao.getAttendanceByDateRange2(empno, startDate, endDate,start);
	    }
	    
	    //리스트 글 갯수
	    public int count(int empno) { 
	    		return dao.count(empno);
	    }
	    
	    // 엑셀 다운로드할때 필요한 값
	    public List<AttendanceManagementDto> getAllManagement() {
	        	return dao.getAllManagement();
	    }
	    
	    //페이징 카운팅
	    public int count2(int empno) { 
	    		return dao.count2(empno);
	    }
	    
	    //페이징 리스트
	    public List<AttendanceManagementDto>managementList(int start,int empno){ 
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("start", start);
				m.put("count", 8);
				m.put("empno", empno);
				return dao.managementList(m);
		}
	    
	    // 검색시 전체 글갯수
	    public int aSCount( int empno, Date startDate, Date endDate) {
	    		return dao.getAttendanceCount(empno, startDate, endDate);
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