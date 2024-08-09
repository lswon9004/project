package commet.attendance;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;

import commet.swon.emp.EmpDto;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@SessionAttributes("user")
public class AttendanceController {
	@Autowired
	AttendanceService service;
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	Gson gson = new Gson();
	@ModelAttribute("user")
	   public EmpDto getDto() {
	      return new EmpDto();
	   }
	@GetMapping("/startTime")
	@ResponseBody
	public String startTime(@RequestParam("empno")int empno, @RequestParam("deptno")int deptno, HttpServletRequest req) {
		Date startTime = service.startTime(empno);
		String formattedDate = null;
		if(startTime==null) {
			service.insertStartTmie(empno, deptno);
			startTime = service.startTime(empno);
		}
		formattedDate = sdf.format(startTime);
		req.getSession().setAttribute("startTime", startTime);
		return gson.toJson(formattedDate);
	}
	@GetMapping("/endTime")
	@ResponseBody
	public String endTime(@RequestParam("empno")int empno,HttpServletRequest res) {
		Date endtime = service.endTime(empno);
		res.getSession().setAttribute("endTime", endtime);
		return gson.toJson(sdf.format(endtime));
	}
	@GetMapping("/vacation")
	@ResponseBody
	public String vacation(@RequestParam("date") @DateTimeFormat(pattern = "yyyy-MM-dd")Date date){
		List<Integer> vlist = service.vacationList(date);
		return gson.toJson(vlist);
	}
}
