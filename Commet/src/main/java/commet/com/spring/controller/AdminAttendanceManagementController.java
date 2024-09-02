package commet.com.spring.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import commet.attendance.AttendanceService;
import commet.com.spring.dto.AttendanceManagementDto;
import commet.com.spring.dto.CustomerInfoDTO;
import commet.com.spring.service.AdminAttendanceManagementService;
import commet.nowon.user.security.manage.ManageDto;
import commet.nowon.user.security.manage.ManageService;
import commet.swon.emp.EmpDto;
import commet.swon.emp.EmpService;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/attendance")
@SessionAttributes("user")
public class AdminAttendanceManagementController {
	
    		@Autowired
    		private AdminAttendanceManagementService service;
    		
    		@Autowired
    		AttendanceService aservice;
    		
    		@Autowired
    		EmpService eservice;
    		
    		@Autowired 
    		ManageService Service;
    		
    		// @SessionAttributes 로그인정보 받아 오는 메서드
    		@ModelAttribute("user") 
    		public EmpDto getDto() {
    			return new EmpDto();
    		}
    
    		//관리자근태현황 페이징
    		@GetMapping("/adminManagementList")
    		public String getAllAttendance(@ModelAttribute("user")EmpDto dto,
    											@RequestParam(name = "p", defaultValue = "1") int page,Model m) {
    			if(dto.getRight()<3) {
    			return "redirect:/main";
    		}	
    	
    		int acount = service.acount(dto.getDeptno());
    		if (acount > 0) {
			int perPage = 8;
			int startRow = (page - 1) * perPage;
    	
			List<AttendanceManagementDto> allAttendance = service.getAllAttendance(startRow, dto.getDeptno()); // 페이징 처리된 모든 사원의 근태 현황
			m.addAttribute("allAttendance", allAttendance);
			m.addAttribute("start", startRow+1);
             int pageNum = 5;
             int totalPages = acount / perPage + (acount % perPage > 0 ? 1 : 0);
             int begin = (page - 1) / pageNum * pageNum + 1;
             int end = begin + pageNum - 1;
             if (end > totalPages) {
                 end = totalPages;
             }
             List<EmpDto> alist = eservice.alist(); //연차 . 잔여연차 받아 오는 부분
             m.addAttribute("alist", alist);
             List<Map<String, Integer>> leaveCount = service.leaveCount(dto.getEmpno());
             m.addAttribute("leaveCountlist", leaveCount); //연차 . 잔여연차 받아 오는 부분

             m.addAttribute("begin", begin);
             m.addAttribute("end", end);
             m.addAttribute("pageNum", pageNum);
             m.addAttribute("totalPages", totalPages);
    		}
			m.addAttribute("count", acount);
			return "amc/adminmanagementList";
    		}
    
    		// 관리자 검색페이징
    		@GetMapping("/search")
    		public String search(@ModelAttribute("user")EmpDto dto,
    										@RequestParam(name = "empno", required = false) Integer empno,
    											@RequestParam(name = "p", defaultValue = "1") int page, 
    	   Model model) {
    	   if(dto.getRight()<3) {
		   return "redirect:/main";
    	   }	
        
    	   int count = service.aSCount(empno);
    	   if (count > 0) {
            int perPage = 10;
            int startRow = (page - 1) * perPage;
            List<AttendanceManagementDto> filteredAttendanceList = service.getAttendanceByEmpNo(empno,  startRow);

            int pageNum = 5;
            int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0);
            int begin = (page - 1) / pageNum * pageNum + 1;
            int end1 = begin + pageNum - 1;
            if (end1 > totalPages) {
                end1 = totalPages;
            }
            
            List<EmpDto> alist = eservice.alist();//연차 . 잔여연차 받아 오는 부분
            model.addAttribute("alist", alist);
            List<Map<String, Integer>> leaveCount = service.leaveCount(dto.getEmpno());
            model.addAttribute("leaveCountlist", leaveCount);//연차 . 잔여연차 받아 오는 부분   a
         
            model.addAttribute("begin", begin);
            model.addAttribute("end", end1);
            model.addAttribute("pageNum", pageNum);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("attendanceList", filteredAttendanceList);
        }
        model.addAttribute("empno", empno);
        model.addAttribute("count", count);
        return "amc/adminsearchList";
    }
    
    // 엑셀 다운로드
    @GetMapping("/downloadExcel3") 
	public void downloadExcel(HttpServletResponse response) throws IOException {
		List<AttendanceManagementDto> attendanceList = service.getAllManagement2();

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Attendance");

		// 헤더행
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("사원명");
		headerRow.createCell(1).setCellValue("사원번호");
		headerRow.createCell(2).setCellValue("출근일자");
		headerRow.createCell(3).setCellValue("출근시간");
		headerRow.createCell(4).setCellValue("퇴근시간");
		headerRow.createCell(5).setCellValue("근무유형");
		headerRow.createCell(6).setCellValue("연차사용");
		headerRow.createCell(7).setCellValue("잔여연차");
		
		// 날짜 형식 지정
	    CellStyle dateCellStyle = workbook.createCellStyle();
	    CreationHelper createHelper = workbook.getCreationHelper();
	    dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("yyyy-MM-dd"));
	    
	    // 시간 형식 지정
	    CellStyle timeCellStyle = workbook.createCellStyle();
	    timeCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("HH:mm:ss"));
		

	    // 데이터행
	    int rowNum = 1;
	    for (AttendanceManagementDto attendance : attendanceList) {
	        Row row = sheet.createRow(rowNum++);
	        
	        row.createCell(0).setCellValue(attendance.getEname());
	        
	        row.createCell(1).setCellValue(attendance.getEmpno());

	        Cell dateCell = row.createCell(2);
	        dateCell.setCellValue(attendance.getDate());
	        dateCell.setCellStyle(dateCellStyle);

	        Cell checkInCell = row.createCell(3);
	            checkInCell.setCellValue(attendance.getCheck_in());
	            checkInCell.setCellStyle(timeCellStyle);

	        Cell checkOutCell = row.createCell(4);
	            checkOutCell.setCellValue(attendance.getCheck_out());
	            checkOutCell.setCellStyle(timeCellStyle);

	        row.createCell(5).setCellValue(attendance.getWorktype());
	        row.createCell(6).setCellValue(attendance.getAnnual_leave());
	        // 잔여연차는 추가로 설정
	        row.createCell(7).setCellValue("");
		}//attendance

		// 콘텐츠 유형과 첨부 파일 헤더를 설정
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=customers.xlsx");

		// 출력 스트림에 통합 문서 쓰기
		workbook.write(response.getOutputStream());
		workbook.close();
		
	}
    
    //결근처리 empno 이름이 같아서 버튼을 클릭시 계속 정보가 변경됨 그래서 eno 로 변경
    @PostMapping("/markAbsent2")
    public String markAsAbsent(@RequestParam("eno") int no, @ModelAttribute("user") EmpDto user, Model model) {
        String resultMessage = service.markAsAbsent2(no, user.getDeptno());
        model.addAttribute("message", resultMessage);
        return "redirect:/attendance/adminManagementList";
    }
    
  
    
    
}//class