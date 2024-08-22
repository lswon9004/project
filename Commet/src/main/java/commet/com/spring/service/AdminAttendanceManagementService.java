package commet.com.spring.service;

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
    
	 	@Autowired
	    private AdminAttendanceManagementDao dao;
	 	
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
	    
	    // 엑셀 다운로드할때 필요한 값
	    public List<AttendanceManagementDto> getAllManagement2() {
	        	return dao.getAllManagement2();
	    }
		
	  
}