package commet.com.spring.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commet.com.spring.dao.CustomerInfoDAO;
import commet.com.spring.dto.CustomerInfoDTO;

@Service
public class CustomerInfoService {
	
	 @Autowired
	    private CustomerInfoDAO dao;

	    public void saveCustomerInfo(CustomerInfoDTO customerInfo) { //고객등록
	    	dao.saveCustomerInfo(customerInfo);
	    }

	    public List<CustomerInfoDTO> getAllCustomers() { //전체리스트
	        return dao.getAllCustomers();
	    }

	    public CustomerInfoDTO getCustomerById(int id) { //특정고객 상태 보여주는 
	        return dao.getCustomerById(id);
	    }

	    public void deleteCustomers(int[] ids) { //삭제
	    	dao.deleteCustomers(ids);
	    }
	    public List<CustomerInfoDTO> getCustomersByStatus(String status) { //진행상태
	        return dao.getCustomersByStatus(status);
	    }
	    
	    public int count() { //글갯수
			return dao.count();
		}
	    
	    public List<CustomerInfoDTO>customerList(int start ,int count){ //전체글 페이징
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("start", start);
			m.put("count", 8);
			return dao.customerList(m);
		}
		
	    public int updateCustomer(CustomerInfoDTO dto) { // 고객 정보 수정
			return dao.updateCustomer(dto);
		}
	   
	    public List<CustomerInfoDTO> searchCustomersWithPaging(String customerName, String contact, Integer empno , int page, int pageSize) { //검색페이징
	        int start = (page - 1) * pageSize;
	        return dao.searchCustomersWithPaging(customerName, contact, empno ,  start, pageSize);
	    }
	    
	    public int countSearchCustomers(String customerName, String contact , Integer empno) { // 검색 글 갯수
	        return dao.countSearchCustomers(customerName, contact ,empno);
	    }

	    public int countCustomersByStatus(String status) { // 진행상태 글 갯수
	        return dao.countCustomersByStatus(status);
	    }
	    
	    public List<CustomerInfoDTO> getCustomersByStatusWithPaging(String status, int page, int pageSize) { //	진행 상태별 리스트
	        int start = (page - 1) * pageSize;
	        return dao.getCustomersByStatusWithPaging(status, start, pageSize);
	    }
	    
	    
	    
}
