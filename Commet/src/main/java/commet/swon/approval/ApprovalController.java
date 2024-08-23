package commet.swon.approval;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import commet.swon.emp.EmpDto;
import commet.swon.emp.EmpService;
import commet.swon.file.FilesDto;
import commet.swon.file.FilesService;
import commet.swon.img.ImgController;


@Controller
@SessionAttributes("user")
public class ApprovalController {
	@Autowired
	FilesService service;
	@ModelAttribute("user")
	   public EmpDto getDto() {
	      return new EmpDto();
	   }
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	@Autowired
	ApprovalService aService;
	@Autowired
	EmpService eService;
	@GetMapping("/approvalWrite")
	public String approvalWrite(@ModelAttribute("user")EmpDto dto, Model m) {
		int approval_no = aService.getApproval_no(dto.getEmpno());
		List<Integer> elist = eService.getNoList(dto.getDeptno());
		m.addAttribute("elist", elist);
		m.addAttribute("approval_no", approval_no);
		return "/approvalWrite";
	}
	@PostMapping("/approval/insert")
	public String insert(ApprovalDto dto,@ModelAttribute("user")EmpDto edto,@RequestParam("file")MultipartFile file) {
		fileUpload(file, dto.getApproval_no());
		dto.setEmpno(edto.getEmpno());
		dto.setDeptno(edto.getDeptno());
		aService.insertApproval(dto);
		return "redirect:/approval/"+edto.getEmpno();
	}
	@GetMapping("/approval/content/{no}")
	public String content(@PathVariable("no")int no, Model m) {
		FilesDto fDto = service.selectFile(no);
		m.addAttribute("fdto", fDto);
		ApprovalDto dto = aService.oneApproval(no);
		m.addAttribute("dto", dto);
		return "/approval/content";
	}
	@GetMapping("/approval/update/{no}")
	public String updatecontent(@PathVariable("no")int no, Model m) {
		FilesDto fDto = service.selectFile(no);
		ApprovalDto dto = aService.oneApproval(no);
		m.addAttribute("file", fDto);
		m.addAttribute("dto", dto);
		return "/approval/upadte";
	}
	@PostMapping("/approval/update/{no}")
	public String update(@PathVariable("no")int no,@ModelAttribute("user")EmpDto edto,
						 @RequestParam("approval_type")int approval_type,@RequestParam("approval_content")String approval_content) {
		aService.updateApproval(approval_content, no, approval_type);
		return"redirect:/approval/content/"+no;
	}
	@GetMapping("/approval/search")
	public String approvalSearch(@RequestParam(name = "approval_no")String approval_no,
								 @RequestParam(name = "approval_title")String approval_title,
								 @RequestParam(name = "approval_status1")String approval_status1,
								 @DateTimeFormat(pattern = "yyyy-MM-dd")@RequestParam(name = "startDate",required = false)Date startDate,
								 @DateTimeFormat(pattern = "yyyy-MM-dd")@RequestParam(name = "endDate",required = false)Date endDate,
								 @RequestParam(name="p", defaultValue = "1") int page,
								 @ModelAttribute("user")EmpDto dto, Model m) {
		approval_title = "%"+approval_title+"%";
		int no = 0;
		if(!approval_no.equals("")) {
		no = Integer.parseInt(approval_no);
		}
		int count = aService.searchCount(no, approval_title, approval_status1, startDate, endDate, dto.getEmpno());
		if(count>0) {
			int perPage = 10; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage;//인덱스 번호
			List<ApprovalDto> alist = aService.searchApproval(no, approval_title, approval_status1, startDate, endDate, dto.getEmpno(), startRow);
			m.addAttribute("alist", alist);
			int pageNum = 5;
			int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수	
			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum -1;
			if(end > totalPages) {
				end = totalPages;
			}
			m.addAttribute("approval_no", no);
			m.addAttribute("approval_title", approval_title);
			m.addAttribute("approval_status1", approval_status1);
			if(startDate !=null) {
			m.addAttribute("startDate", sdf.format(startDate));
			}
			if (endDate !=null) {							
			m.addAttribute("endDate", sdf.format(endDate));
			}
			m.addAttribute("begin", begin);
			m.addAttribute("end", end);
			m.addAttribute("pageNum", pageNum);
			m.addAttribute("totalPages", totalPages);
		}
		m.addAttribute("count", count);
		return "/approval/search";
	}
	@GetMapping("/approval/status")
	public void status(@RequestParam(name="p", defaultValue = "1") int page,
					   @ModelAttribute("user")EmpDto dto, Model m) {
		int count = aService.aStatusCount(dto.getEmpno());
		if (count>0){
			int perPage = 10; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage;//인덱스 번호
			List<ApprovalDto> alist = aService.aStatus(dto.getEmpno(),startRow);
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
	}
	@GetMapping("/approval/status/search")
	public String approvalStatusSearch(@RequestParam(name = "approval_title")String approval_title,
			 @RequestParam(name = "approval_status1")String approval_status1,
			 @DateTimeFormat(pattern = "yyyy-MM-dd")@RequestParam(name = "startDate",required = false)Date startDate,
			 @DateTimeFormat(pattern = "yyyy-MM-dd")@RequestParam(name = "endDate",required = false)Date endDate,
			 @RequestParam(name="p", defaultValue = "1") int page,@RequestParam("empno")String empno ,
			 @RequestParam("approval_empno")int approval_empno,Model m) {
		int no = 0;
		approval_title = "%"+approval_title+"%";
		if(!empno.equals("")) {
			no = Integer.parseInt(empno);
		}
		int count = aService.statusSearchCount(approval_title, startDate, endDate, no, approval_status1, approval_empno);
		if(count>0) {
			int perPage = 10; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage;//인덱스 번호
			List<ApprovalDto> alist = aService.statusSearchList(approval_title, startDate, endDate, no, approval_status1, approval_empno, startRow);
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
		return "/approval/statusSearch";
	}
	@GetMapping("/approval/statusForm/{no}")
	public String statusForm(@PathVariable("no")int no, Model m) {
		ApprovalDto dto = aService.oneApproval(no);
		m.addAttribute("dto", dto);
		return "/approval/statusForm";
	}
	@GetMapping("/approval/statusContent/{no}")
	public String statusContent(@PathVariable("no")int no, Model m) {
		FilesDto fDto = service.selectFile(no);
		m.addAttribute("fdto", fDto);
		ApprovalDto dto = aService.oneApproval(no);
		m.addAttribute("dto", dto);
		return "/approval/statusContent";
	}
	@PostMapping("/approval/statusForm")
	public String updateStatus(ApprovalDto dto,
							   @DateTimeFormat(pattern = "yyyy-MM-dd")@RequestParam(name = "date",required = false)Date date
							   ) {
		
		aService.updateStatus(dto.getApproval_status1(), dto.getApproval_comm(), dto.getApproval_no(),dto.getApproval_type(),date,dto.getEmpno());  
		return "redirect:/approval/status";
	}
	public boolean fileUpload(MultipartFile file,int no) {
		String newFileName = ImgController.makeFileName(file.getOriginalFilename());
		String fname = file.getOriginalFilename();
        File newFile = null;
        String path = null;
        try {
            path = ResourceUtils.getFile("classpath:static/upload/document/").toPath().toString();
            newFile = new File(path, newFileName);
            file.transferTo(newFile);
        } catch (IOException | IllegalStateException e) {
            e.printStackTrace();
        }
        if (newFile != null) {
        	service.insertfile(no, newFileName, fname);
        	return true;
        }else {
        	return false;
        }
	}
}
