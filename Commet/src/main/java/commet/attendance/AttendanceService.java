package commet.attendance;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {
	@Autowired
	AttendanceDao dao;
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Calendar cal = Calendar.getInstance();
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH)+1;
    String startDateO = year+"-"+month+"-01";
    String endDateO = year+"-"+month+1+"-01";
    Date startDate =null;
    Date endDate = null;

	public int insertStartTmie(int empno,int deptno) {
		if(dao.scount(empno)>0) {
			return dao.updateStartTime(empno);
		}else {
		
			return dao.insertStartTmie(empno,deptno);
		}
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
	public int getAttCount(int empno) {
		try {
			startDate = formatter.parse(startDateO);
	        endDate = formatter.parse(endDateO);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.AttCount(empno,startDate , endDate);
	}
	public int tCount(int empno) {
		try {
			startDate = formatter.parse(startDateO);
	        endDate = formatter.parse(endDateO);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.TardinessCount(empno, startDate, endDate);
	}
	public int sick_leaveCount(int empno) {
		try {
			startDate = formatter.parse(startDateO);
	        endDate = formatter.parse(endDateO);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.sick_leaveCount(empno, startDate, endDate);
	}
	public int leaveCount(int empno) {
		try {
			startDate = formatter.parse(startDateO);
	        endDate = formatter.parse(endDateO);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.leaveCount(empno, startDate, endDate);
	}
	public int abCount(int empno) {
		try {
			startDate = formatter.parse(startDateO);
	        endDate = formatter.parse(endDateO);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.abCount(empno, startDate, endDate);
	}
}
