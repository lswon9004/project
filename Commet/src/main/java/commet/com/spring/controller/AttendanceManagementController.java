package commet.com.spring.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import commet.attendance.AttendanceService;
import commet.com.spring.dto.AttendanceManagementDto;
import commet.com.spring.service.AttendanceManagementService;
import commet.swon.emp.EmpDto;
import commet.swon.emp.EmpService;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/attendance")
@SessionAttributes("user")
public class AttendanceManagementController {
	
    @Autowired
    private AttendanceManagementService service;
    
    @Autowired
  	AttendanceService aservice;
      @Autowired
      EmpService eservice;
    
    // @SessionAttributes 로그인정보 받아 오는 메서드
    @ModelAttribute("user") 
    public EmpDto getDto() {
       return new EmpDto();
    }
    
    
    // 일반 근태현황 페이징처리
    @GetMapping("/managementList") 
    public String getManagementList(@ModelAttribute("user") EmpDto dto,
    												@RequestParam(name = "p", defaultValue = "1") int page, Model model) {
    		int count = service.count2(dto.getEmpno());
    		if (count > 0) {
    		int perPage = 8;
        	int startRow = (page - 1) * perPage;

            List<AttendanceManagementDto> attendanceList = service.managementList(startRow, dto.getEmpno());
            model.addAttribute("attendanceList", attendanceList);
            model.addAttribute("start", startRow+1);
            int pageNum = 5;
            int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0);
            int begin = (page - 1) / pageNum * pageNum + 1;
            int end = begin + pageNum - 1;
            if (end > totalPages) {
                end = totalPages;
            }
            
            List<EmpDto> alist = eservice.alist(); //연차 . 잔여연차 받아 오는 부분
            model.addAttribute("alist", alist);
            List<Map<String, Integer>> leaveCount = service.leaveCount(dto.getEmpno());
            model.addAttribute("leaveCountlist", leaveCount); //연차 . 잔여연차 받아 오는 부분
            
            
            model.addAttribute("begin", begin);
            model.addAttribute("end", end);
            model.addAttribute("pageNum", pageNum);
            model.addAttribute("totalPages", totalPages);
    		}
    		model.addAttribute("count", count);
        
        
    		return "amc/managementList";
    }
    
    // 출근 일자가 입력 돼 있으면 출근 버튼 못누름
    @GetMapping("/checkInStatus") 
    @ResponseBody
    public Map<String, Object> checkInStatus(@ModelAttribute("user") EmpDto user) {
    	boolean hasCheckedIn = service.hasCheckedInToday(user.getEmpno());
        Map<String, Object> response = new HashMap<>();
        response.put("hasCheckedIn", hasCheckedIn);
        return response;
    }
    
    //출근
    @PostMapping("/checkIn")
    public String checkIn(@ModelAttribute("user") EmpDto user) {
    		    int employeeAttendanceNo = service.generateNextAttendanceNo(user.getEmpno()); // 사원별로 출근번호를 생성합니다.
    		    service.checkIn(user.getEname() , user.getEmpno(), user.getDeptno(), employeeAttendanceNo);// 출근 기록을 DB에 저장합니다.
    		    Date startTime = aservice.startTime(user.getEmpno()); // 현재출근시간 들고오는 메서드
    		return "redirect:/attendance/managementList";
    }
    
    // 퇴근
    @PostMapping("/checkOut") 
    public String checkOut(@ModelAttribute("user") EmpDto user) {
    		service.checkOut(user.getEmpno());
    		return "redirect:/attendance/managementList";
    }
    
    //결근
    @PostMapping("/markAbsent")
    public String markAbsent(@ModelAttribute("user") EmpDto user) {
        	service.markAbsent(user.getEmpno());
        	return "redirect:/attendance/managementList";
    }
    
    // 날짜검색일반
    @GetMapping("/search2") 
    public String search(@DateTimeFormat(pattern = "yyyy-MM-dd")
    							 @RequestParam(name ="startDate",required = false) Date startDate,
    							  @DateTimeFormat(pattern = "yyyy-MM-dd")
    							  @RequestParam(name="endDate",required = false) Date endDate,
            					  @ModelAttribute("user") EmpDto user,
            					  @RequestParam(name = "p", defaultValue = "1") int page, Model model) {
    	
    		int count = service.aSCount(user.getEmpno(), startDate, endDate);
    		if(count>0) {
    		int perPage = 10;
            int startRow = (page - 1) * perPage;
            List<AttendanceManagementDto> filteredAttendanceList = service.getAttendanceByDateRange2(user.getEmpno(), startDate, endDate,startRow);
            int pageNum = 5;
            int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0);
            int begin = (page - 1) / pageNum * pageNum + 1;
            int end1 = begin + pageNum - 1;
            if (end1> totalPages) {
                end1 = totalPages;
        }
        SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
        
        List<EmpDto> alist = eservice.alist(); //연차 . 잔여연차 받아 오는 부분
        model.addAttribute("alist", alist);
        List<Map<String, Integer>> leaveCount = service.leaveCount(user.getEmpno());
        model.addAttribute("leaveCountlist", leaveCount); //연차 . 잔여연차 받아 오는 부분
        
        model.addAttribute("startDate", sdf.format(startDate));
        model.addAttribute("endDate", sdf.format(endDate));
        model.addAttribute("begin", begin);

        model.addAttribute("end", end1);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("attendanceList", filteredAttendanceList);
        }
        model.addAttribute("count", count); //모델에 검색결과 추가 이 기능 추가로 검색 기능 해결 요소의 개수를 반환 즉 검색된 출근기록 반환
        return "amc/searchList";
        
    }//search2


    // 엑셀 다운로드
    @GetMapping("/downloadExcel2") 
	public void downloadExcel(HttpServletResponse response) throws IOException {
		List<AttendanceManagementDto> attendanceList = service.getAllManagement();

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Attendance");

		// 헤더행
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("출근일수");
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
	        row.createCell(0).setCellValue(attendance.getEmployee_attendance_no());

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
	
}