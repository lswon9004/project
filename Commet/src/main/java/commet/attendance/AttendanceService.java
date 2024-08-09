package commet.attendance;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {
	@Autowired
	AttendanceDao dao;
	
	public int insertStartTmie(int empno,int deptno) {
		return dao.insertStartTmie(empno,deptno);
	}
	public Date startTime(int empno) {
		return dao.startTime(empno);
	}
	public Date endTime(int empno) {
		dao.updateEndtime(empno);
		return dao.endTime(empno);
	}
	public List<Integer> vacationList(Date date){
		return dao.vacationList(date);
	}
}
