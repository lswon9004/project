package commet.com.spring.controller;

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

import commet.com.spring.dto.CustomerInfoDTO;
import commet.com.spring.service.CustomerInfoService;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomerInfoController {

	@Autowired
	private CustomerInfoService Service;

	@GetMapping("/customerForm") // 새로운 CustomerInfoDTO 객체를 모델에 추가하여 고객 정보 입력 폼을 표시
	public String showForm(Model model) {
		model.addAttribute("customerInfo", new CustomerInfoDTO()); // 새로운DTO 객체를 모델이 추가
		return "customer/customerForm";
	}

	@PostMapping("/saveCustomer") // 입력된 고객 정보를 저장하고, 고객 목록 페이지로 리다이렉트
	public String saveCustomer(@ModelAttribute("customerInfo") CustomerInfoDTO customerInfo) {
		Service.saveCustomerInfo(customerInfo);
		return "redirect:/customerList";
	}

	@GetMapping("/info") // 새로운 CustomerInfoDTO 객체를 모델에 추가하여 정보 페이지를 표시
	public String showInfoPage(Model model) {
		model.addAttribute("customerInfo", new CustomerInfoDTO());
		return "customer/info";
	}

	@PostMapping("/deleteCustomer") // 삭제
	public String deleteCustomer(@RequestParam("customerIds") int[] customerIds) { // 삭제할 고객 ID배열에 해당하는 고객정보를 삭제
		Service.deleteCustomers(customerIds);
		return "redirect:/customerList";
	}

	@PutMapping("/customerForm") // 정보수정
	public String updateCustomer(@ModelAttribute("customerInfo") CustomerInfoDTO dto) {
		Service.updateCustomer(dto);
		return "redirect:/customerList";
	}

	@GetMapping("/customerDetail/{id}") // 특정 고객의 상세 정보를 조회하여 모델에 추가하고, 고객 정보 입력 폼을 표시합니다.
	public String showCustomerDetail(@PathVariable("id") int id, Model model) { // 고객아이디 저장할모델 m
		CustomerInfoDTO customerInfo = Service.getCustomerById(id); // ID에 해당하는 고객 정보를 조회
		model.addAttribute("customerInfo", customerInfo); // 조회된 고객을 모델에 저장
		return "customer/customerForm";
	}

	@GetMapping("/downloadExcel") // 엑셀 다운로드
	public void downloadExcel(HttpServletResponse response) throws IOException {
		List<CustomerInfoDTO> customerList = Service.getAllCustomers();

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Customers");

		// 헤더행
		Row headerRow = sheet.createRow(0);
		headerRow.createCell(0).setCellValue("고객번호");
		headerRow.createCell(1).setCellValue("고객명");
		headerRow.createCell(2).setCellValue("이메일");
		headerRow.createCell(3).setCellValue("주소");
		headerRow.createCell(4).setCellValue("생년월일");
		headerRow.createCell(5).setCellValue("연락처");
		headerRow.createCell(6).setCellValue("진행상태");
		headerRow.createCell(7).setCellValue("접수일자");

		// 데이터행
		int rowNum = 1;
		for (CustomerInfoDTO customer : customerList) {
			Row row = sheet.createRow(rowNum++);
			row.createCell(0).setCellValue(customer.getCustomerID());
			row.createCell(1).setCellValue(customer.getCustomerName());
			row.createCell(2).setCellValue(customer.getEmail());
			row.createCell(3).setCellValue(customer.getAddress());
			row.createCell(4).setCellValue(customer.getDateOfBirth().toString());
			row.createCell(5).setCellValue(customer.getContact());
			String progress = ""; // DB에 enum 으로 값이 영어로 저장돼 있어서 한글로 바꿔주는 메서드를 만듬
			if (customer.getStatus().equals("Received")) {
				progress = "접수완료";
			} else if (customer.getStatus().equals("Consulted")) {
				progress = "상담완료";
			} else {
				progress = "민원인";
			}
			row.createCell(6).setCellValue(progress);
			row.createCell(7).setCellValue(customer.getRegistrationDate().toString());
		}

		// 콘텐츠 유형과 첨부 파일 헤더를 설정
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=customers.xlsx");

		// 출력 스트림에 통합 문서 쓰기
		workbook.write(response.getOutputStream());
		workbook.close();
	}

	@RequestMapping("/customerList") // 페이지 페이징처리
	public String customerList(@RequestParam(name = "p", defaultValue = "1") int page, Model m) {
		int count = Service.count();
			if (count > 0) {
			int perPage = 10;
			int startRow = (page - 1) * perPage;

			List<CustomerInfoDTO> list = Service.customerList(startRow);
			m.addAttribute("blist", list);

			int pageNum = 5;
			int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0);

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

		return "customer/customerList";
	}

	
	@GetMapping("/searchCustomers") // 고객명 / 연락처 입력하면 검색하는 메서드 페이징처리
	public String searchCustomers(@RequestParam(value = "customerName", required = false) String customerName,
	        										@RequestParam(value = "contact", required = false) String contact,
	        											@RequestParam(value = "page", required = false, defaultValue = "1") int page,
	        												@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,Model model) {
	    
		int start = (page - 1) * pageSize;
		List<CustomerInfoDTO> searchResults = Service.searchCustomersWithPaging(customerName, contact, page, pageSize);
		int totalCustomers = Service.countSearchCustomers(customerName, contact);
	    int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);
	    
	    
	    model.addAttribute("blist", searchResults);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("pageSize", pageSize);
	    
		return "customer/customerList";
	}
	
	@GetMapping("/filterByStatus") // 특정 상태에 해당하는 고객 정보를 조회하여 모델에 추가하고, 고객 목록 페이지를 표시 페이징
	public String filterByStatus( @RequestParam(value = "status", required = false) String status,
											@RequestParam(value = "page", required = false, defaultValue = "1") int page,
											@RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,Model model) {
		 	
			int start = (page - 1) * pageSize;
		 	int totalCustomers = Service.countCustomersByStatus(status);
		    int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

		    List<CustomerInfoDTO> filteredCustomers = Service.getCustomersByStatusWithPaging(status, page, pageSize);

		    model.addAttribute("blist", filteredCustomers);
		    model.addAttribute("currentPage", page);
		    model.addAttribute("totalPages", totalPages);
		    model.addAttribute("status", status);
		    model.addAttribute("pageSize", pageSize);
		    
		return "customer/filtercustomerList";
	}

}