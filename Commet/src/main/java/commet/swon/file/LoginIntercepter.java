package commet.swon.file;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.servlet.HandlerInterceptor;

import commet.swon.emp.EmpDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginIntercepter implements HandlerInterceptor {
	public List<String> loginEssential = Arrays.asList("/amc/**","/approval/**","/boards/**","/bullboard/**","/customer/**","/manage/**","/approval","/globalError","/approvalWrite","/staffModify");

	public List<String> loginInessential = Arrays.asList("/main", "/findpw","/send","/emailCheck","/login","/loginform","/css/**","/js/**","/");

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		EmpDto dto = (EmpDto) request.getSession().getAttribute("user");

		if (dto != null && dto.getEmpno() != 0) {
			//request.getSession().setAttribute("result", true);
			return true;
		} else {
			request.getSession().setAttribute("result", false);
			response.sendRedirect("/loginform");
			return false;
		}
	}

}
