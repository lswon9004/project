package commet.nowon.user.security.manage;

import java.io.IOException;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;


@Controller
@SessionAttributes("user")
public class ManageController {// 컨트롤러에서 사용안하는 중 나중에 사용할까 해서남겨둠
	
	
	@Autowired ManageService service;
	  
	@ModelAttribute("user")
	public ManageDto getDto() {
		return new ManageDto();
	}
	  
	@GetMapping("/insert") // get 방식으로 /insert 받으면 사원정보입력창으로 이동 
	public String empform(){
		return "manage/newEmp";
	}
	
	@PostMapping("/insert") // newEmp.jsp 에서 사원등록하면 리다이렉트로 /emp_manage 요청 empList.jsp 화면보여줌
	public String insert(@ModelAttribute("dto") ManageDto dto) {
		service.insertEmp(dto);
		return "redirect:/emp_manage"; 
	}
	
	@GetMapping("/empInfo") // 사원 정보 수정확인
	public String showForm() {
	    return "manage/empInfo";
	}

    @RequestMapping("/emp_manage")
    public String customerList(@RequestParam(name = "p", defaultValue = "1") int page, Model m) {
        // 글이 있는지 체크
        int count = service.count();
        if (count > 0) {
        	
        int perPage = 10; // 한 페이지에 보일 글의 갯수
        int startRow = (page - 1) * perPage;

        List<ManageDto> list = service.testmanagemain(startRow);
       
            m.addAttribute("elist", list);

            int pageNum = 5; // 보여질 페이지 번호 수
            int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); // 전체 페이지 수

            int begin = (page - 1) / pageNum * pageNum + 1;
            int end = begin + pageNum - 1;
            if (end > totalPages) {
                end = totalPages;
            }
            m.addAttribute("begin", begin);
            m.addAttribute("end", end);
            m.addAttribute("pageNum", pageNum);
            m.addAttribute("totalPages", totalPages);
          
        }
        m.addAttribute("count", count);
        return "manage/empList";
    }

    @GetMapping("/empDetail/{id}")//특정 고객의 상세 정보를 조회하여 모델에 추가하고, 고객 정보 입력 폼을표시합니다.
    public String showEmpDetail(@PathVariable("id") int id, Model model) { //고객아이디 저장할모델 m
    	ManageDto empInfo = service.getempByID(id); //ID에 해당하는 고객 정보를 조회
    	model.addAttribute("empInfo", empInfo); // 조회된 고객을 모델에 저장
    	return "manage/empInfo";
	}
    
    @PutMapping("/empInfo")//정보수정
    public String updateEmp(@ModelAttribute("empInfo") ManageDto dto) {
    	service.updateEmp(dto);
        return "redirect:/emp_manage";
    }
	
	  @PostMapping("/deleteEmp") //삭제 
	  public String deleteEmp(@RequestParam("empnos") int[] empnos) { //삭제할 고객ID배열에 해당하는 고객정보를 삭제 
		  service.deleteEmps(empnos);
		  return "redirect:/emp_manage";
	  }
	  
	  @GetMapping("/searchEmps")//고객명 / 연락처 입력하면 검색하는 메서드 
	  public String searchEmps(@RequestParam(value = "empno", defaultValue = "0") Integer empno,
			  						@RequestParam(value = "ename", required = false) String ename, Model model) {
	  List<ManageDto> searchResults = service.searchEmps(empno, ename);
	  model.addAttribute("elist", searchResults);
	  return "manage/empList";
	  }

	  @PostMapping("/downloadEmpExcel") // 엑셀 다운로드 
	  public void downloadEmpExcel(@RequestParam("empnos") int[] empnos, HttpServletResponse response) throws IOException {
	  List<ManageDto> empList = service.getEmpsByIds(empnos);
	  
	  Workbook workbook = new XSSFWorkbook(); Sheet sheet =
	  workbook.createSheet("Emps");
	  
	  // 헤더행 
	  Row headerRow = sheet.createRow(0);
	  headerRow.createCell(0).setCellValue("사원번호");
	  headerRow.createCell(1).setCellValue("사원이름");
	  headerRow.createCell(2).setCellValue("이메일");
	  headerRow.createCell(3).setCellValue("주소");
	  headerRow.createCell(4).setCellValue("생년월일");
	  headerRow.createCell(5).setCellValue("연락처");

	  
	  // 데이터행 
	  int rowNum = 1;
	  for (ManageDto emp : empList) { 
		  Row row = sheet.createRow(rowNum++);
		  row.createCell(0).setCellValue(emp.getEmpno());
		  row.createCell(1).setCellValue(emp.getEname());
		  row.createCell(2).setCellValue(emp.getEmail());
		  row.createCell(3).setCellValue(emp.getAddress());
		  row.createCell(4).setCellValue(emp.getBirthday());
	  	  row.createCell(5).setCellValue(emp.getPhone());
	  }

	  // 콘텐츠 유형과 첨부 파일 헤더를 설정 
	  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	  response.setHeader("Content-Disposition","attachment; filename=emps.xlsx");
	  
	  // 출력 스트림에 통합 문서 쓰기 
	  workbook.write(response.getOutputStream());
	  workbook.close(); 
	  		
	  }
	  
	  
	  
}
