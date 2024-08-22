package commet.swon.emp;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.google.gson.Gson;

import commet.attendance.AttendanceService;



@Controller
@SessionAttributes("user")
public class EmpController {

	@Autowired
	EmpService service;
	@Autowired
	AttendanceService aservice;
	
	@ModelAttribute("user")
	public EmpDto getDto() {
		return new EmpDto();
	}
	
	public int noCheck(String position) {
		return service.getRight(position);
	}

	@GetMapping("/login")
	@ResponseBody
	public String login(@RequestParam("no") int no, @RequestParam("pw") String password, Model m) {

		Gson gson = new Gson();
		String result = "";
		EmpDto dto = service.login(no);
		if (dto == null) {
			result = "/";
		} else {
			if (service.getCount(no) > 4) {
				result = "/findpw";
			} else {
				if (dto.password.equals(password)) {
					service.loginCount(0,dto.getEmpno());
					dto.setRight(noCheck(dto.getPosition()));
					m.addAttribute("user", dto);
					if (noCheck(dto.position) < 3) {
						result = "/main";
					} else {
						result = "/adminMain";
					}
				} else {
					result = "/";
					service.loginCount(dto.getLoginCount() + 1,no);
				}
			}
		}
   
		return gson.toJson(result);
	}

	@GetMapping("/main")
	public String main(@ModelAttribute("user") EmpDto dto,Model m) {
		if(dto.empno != 0) {
			int attCount = aservice.getAttCount(dto.getEmpno());
			m.addAttribute("count", attCount);
			int Tcount = aservice.tCount(dto.getEmpno());
			m.addAttribute("Tcount", Tcount);
			int sick_leaveCount = aservice.sick_leaveCount(dto.getEmpno());
			int leaveCount = aservice.leaveCount(dto.getEmpno());
			m.addAttribute("sickCount", sick_leaveCount);
			m.addAttribute("leaveCount", leaveCount);
			return "/main";
		}else {
			return "/loginform";
		}
		
	}

	@GetMapping("/adminMain")
	public String adminMain(@ModelAttribute("user") EmpDto dto,Model m) {
		if(dto.empno != 0) {
			int attCount = aservice.getAttCount(dto.getEmpno());
			m.addAttribute("count", attCount);
			int Tcount = aservice.tCount(dto.getEmpno());
			m.addAttribute("Tcount", Tcount);
			int sick_leaveCount = aservice.sick_leaveCount(dto.getEmpno());
			int leaveCount = aservice.leaveCount(dto.getEmpno());
			int abcount = aservice.abCount(dto.getEmpno());
			m.addAttribute("abcount", abcount);
			m.addAttribute("sickCount", sick_leaveCount);
			m.addAttribute("leaveCount", leaveCount);
			return "/adminMain";
		}else {
			return "/loginform";
		}
	}
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/main";
	}

	@GetMapping("/findpw")
	public void findpw() {
  
	}
	
	@PostMapping("/findpw")
	public String postMethodName(@RequestParam("empno")int empno) {
		service.loginCount(0,empno);
		service.updatepw(empno);
		return "redirect:/loginform";
	}
	@GetMapping("/loginform")
	public void getMethodName() {
	}
	@GetMapping("/emailCheck")
	@ResponseBody
	public String getMethodName(@RequestParam("email") String email,@RequestParam("empno")String empno) {
		int no =0;
		if(empno != null) {
		no = Integer.parseInt(empno);
		}
		boolean emailCheck = service.emailCheck(no, email);
		
		Gson gson = new Gson();
		return gson.toJson(emailCheck);
	}
	
}
