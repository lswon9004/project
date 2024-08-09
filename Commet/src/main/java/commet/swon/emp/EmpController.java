package commet.swon.emp;

import java.util.Date;

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
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestBody;


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
					service.loginCount(0);
					m.addAttribute("user", dto);
					if (noCheck(dto.position) < 3) {
						result = "/main";
					} else {
						result = "/adminMain";
					}
				} else {
					result = "/";
					service.loginCount(dto.loginCount + 1);
				}
			}
		}

		return gson.toJson(result);
	}

	@GetMapping("/main")
	public String main(@ModelAttribute("user") EmpDto dto) {
		if(dto.empno != 0) {
			return "/main";
		}else {
			return "/loginform";
		}
		
	}

	@GetMapping("/adminMain")
	public String adminMain(@ModelAttribute("user") EmpDto dto) {
		if(dto.empno != 0) {
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
	public String postMethodName() {
		service.loginCount(0);		
		return "redirect:/loginform";
	}
	@GetMapping("/loginform")
	public void getMethodName() {
	}
	
}
