package commet.com.spring.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import commet.com.spring.dto.AttendanceManagementDto;
import commet.com.spring.service.AdminAttendanceManagementService;
import commet.swon.emp.EmpDto;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/attendance")
@SessionAttributes("user")
public class AdminAttendanceManagementController {

    @Autowired
    private AdminAttendanceManagementService service;
    
    // @SessionAttributes 로그인정보 받아 오는 메서드
    @ModelAttribute("user") 
    public EmpDto getDto() {
       return new EmpDto();
    }
    
    //관리자근태현황 페이징
    @GetMapping("/adminManagementList")
    public String getAllAttendance(@ModelAttribute("user")EmpDto dto,
    											@RequestParam(name = "p", defaultValue = "1") int page,Model m) {
    	int acount = service.acount(dto.getDeptno());
		if (acount > 0) {
			int perPage = 5;
			int startRow = (page - 1) * perPage;
    	
    	 List<AttendanceManagementDto> allAttendance = service.getAllAttendance(startRow, dto.getDeptno()); // 페이징 처리된 모든 사원의 근태 현황
         m.addAttribute("allAttendance", allAttendance);

             int pageNum = 5;
             int totalPages = acount / perPage + (acount % perPage > 0 ? 1 : 0);
             int begin = (page - 1) / pageNum * pageNum + 1;
             int end = begin + pageNum - 1;
             if (end > totalPages) {
                 end = totalPages;
             }
             m.addAttribute("begin", begin);
             m.addAttribute("end", end);
             m.addAttribute("pageNum", pageNum);
             m.addAttribute("totalPages", totalPages);
             m.addAttribute("start", startRow + 1);
    	}
			m.addAttribute("count", acount);
			return "amc/adminmanagementList";
    	}
    
    // 날짜검색페이징 관리자
    @GetMapping("/search")
    public String search(
        @RequestParam(name = "empno", required = false) Integer empno,
        @RequestParam(name = "p", defaultValue = "1") int page, 
        Model model) {

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
		headerRow.createCell(0).setCellValue("사원번호");
		headerRow.createCell(1).setCellValue("출근일자");
		headerRow.createCell(2).setCellValue("출근시간");
		headerRow.createCell(3).setCellValue("퇴근시간");
		headerRow.createCell(4).setCellValue("근무유형");
		headerRow.createCell(5).setCellValue("연차사용");
		headerRow.createCell(6).setCellValue("잔여연차");
		
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
	        row.createCell(0).setCellValue(attendance.getEmpno());

	        Cell dateCell = row.createCell(1);
	        dateCell.setCellValue(attendance.getDate());
	        dateCell.setCellStyle(dateCellStyle);

	        Cell checkInCell = row.createCell(2);
	            checkInCell.setCellValue(attendance.getCheck_in());
	            checkInCell.setCellStyle(timeCellStyle);

	        Cell checkOutCell = row.createCell(3);
	            checkOutCell.setCellValue(attendance.getCheck_out());
	            checkOutCell.setCellStyle(timeCellStyle);

	        row.createCell(4).setCellValue(attendance.getWorktype());
	        row.createCell(5).setCellValue(attendance.getAnnual_leave());
	        // 잔여연차는 추가로 설정
	        row.createCell(6).setCellValue("");
		}//attendance

		// 콘텐츠 유형과 첨부 파일 헤더를 설정
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=customers.xlsx");

		// 출력 스트림에 통합 문서 쓰기
		workbook.write(response.getOutputStream());
		workbook.close();
		
	}
    
}//class