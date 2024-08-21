package commet.com.spring.service;

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
    
	 	@Autowired
	    private AttendanceManagementDao dao;
	 	
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
	 	
	    //사원별로 출근일수 따로 따로 저장
	 	public int generateNextAttendanceNo(int empno) {
	 		int maxAttendanceNo = dao.getMaxEmployeeAttendanceNo(empno); // 사원별로 가장 큰 출근번호를 조회합니다.
	 		 return maxAttendanceNo + 1; // 만약 출근번호가 없으면 1부터 시작합니다.
	 	}
	 	
	 	//출근
	 	public void checkIn(int empno, int deptno, int employeeAttendanceNo) {
	 	    
//	 		if (hasCheckedInToday(empno)) {
//	 			Date startTime = dao.startTime(empno);
//	 			if(startTime==null) {
//	 				dao.updateStartTime(empno);
//	 			}
//	 		}else {
	 			dao.insertStartTime(empno, deptno, employeeAttendanceNo);
//	 		}
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

		//검색 된 리스트
		public List<AttendanceManagementDto> getAttendanceByDateRange(Integer empno, Integer deptno, Date startDate, Date endDate, int start) {
		    return dao.getAttendanceByDateRange(empno, deptno, startDate, endDate, start);
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
	    public int count2() { 
	    		return dao.count2();
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
	    public int aSCount( int empno, int deptno, Date startDate, Date endDate) {
	    		return dao.getAttendanceCount(empno, deptno, startDate, endDate);
	    }
}