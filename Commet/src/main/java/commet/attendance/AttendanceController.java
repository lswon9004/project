package commet.attendance;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import commet.com.spring.service.AttendanceManagementService;
import commet.swon.emp.EmpDto;
import commet.swon.emp.EmpService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@SessionAttributes("user")
public class AttendanceController {
	@Autowired
    private AttendanceManagementService aservice;
	@Autowired
	EmpService eService;
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
	public String startTime(@RequestParam("empno")int empno, @RequestParam("deptno")int deptno,
							@ModelAttribute("user")EmpDto dto) {
	    int employeeAttendanceNo = aservice.generateNextAttendanceNo(dto.getEmpno()); // 사원별로 출근번호를 생성합니다.

		Date startTime = service.startTime(empno);
		String formattedDate = null;
		if(startTime==null) {
			service.insertStartTmie(empno, deptno,employeeAttendanceNo);
			startTime = service.startTime(empno);
			formattedDate = sdf.format(startTime);
		}
		return gson.toJson(formattedDate);
	}
	@GetMapping("/endTime")
	@ResponseBody
	public String endTime(@RequestParam("empno")int empno,	@ModelAttribute("user")EmpDto dto) {
		Date endtime = service.endTime(empno);
		return gson.toJson(sdf.format(endtime));
	}
	@GetMapping("/vacation")
	@ResponseBody
	public String vacation(@RequestParam("date") @DateTimeFormat(pattern = "yyyy-MM-dd")Date date){
		List<EmpDto> getEname = eService.getEname();
		List<Integer> vlist = service.vacationList(date);
		List<String> elist = new ArrayList<>();
		for(int i:vlist) {
			for (EmpDto dto:getEname) {
				if (i==dto.getEmpno()) {
					elist.add(dto.getEname());
				}
			}
		}
		
		return gson.toJson(elist);
	}
}
