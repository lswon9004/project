package commet.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import commet.swon.approval.ApprovalDto;
import commet.swon.approval.ApprovalService;




@Controller
public class MainController {
	
	@Autowired
	ApprovalService aservice;
	
	@GetMapping("/approval/{empno}")
	public String approval(@PathVariable("empno")int empno,@RequestParam(name="p", defaultValue = "1") int page,Model m) {
		int count = aservice.Acount(empno);
		if(count>0) {
			int perPage = 10; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage;//인덱스 번호
			List<ApprovalDto> alist = aservice.alist(empno,startRow);
			m.addAttribute("alist", alist);
			int pageNum = 5;
			int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수	
			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum -1;
			if(end > totalPages) {
				end = totalPages;
			}
			m.addAttribute("begin", begin);
			m.addAttribute("end", end);
			m.addAttribute("pageNum", pageNum);
			m.addAttribute("totalPages", totalPages);
		}
		m.addAttribute("count", count);
		return "/approval";
	}
	
	
}
