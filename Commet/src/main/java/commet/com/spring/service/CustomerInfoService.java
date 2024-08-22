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
	 	//고객등록
	    public void saveCustomerInfo(CustomerInfoDTO customerInfo) { 
	    	dao.saveCustomerInfo(customerInfo);
	    }
	    
	    //전체리스트
	    public List<CustomerInfoDTO> getAllCustomers() {
	        return dao.getAllCustomers();
	    }
	    
	    //특정고객 상태 보여주는 
	    public CustomerInfoDTO getCustomerById(int id) { 
	        return dao.getCustomerById(id);
	    }
	    
	    //삭제
	    public void deleteCustomers(int[] ids) { 
	    	dao.deleteCustomers(ids);
	    }
	    
	    //진행상태
	    public List<CustomerInfoDTO> getCustomersByStatus(String status) { 
	        return dao.getCustomersByStatus(status);
	    }
	    
	    //글갯수
	    public int count() { 
			return dao.count();
		}
	    
	    //전체글 페이징
	    public List<CustomerInfoDTO>customerList(int page ,int pageSize){ 
	    	int start = (page - 1) * pageSize;
			
			return dao.customerList(start , pageSize);
		}
		
	    // 고객 정보 수정
	    public int updateCustomer(CustomerInfoDTO dto) {
			return dao.updateCustomer(dto);
		}
	   
	    //검색페이징
	    public List<CustomerInfoDTO> searchCustomersWithPaging(String customerName, String contact, Integer empno , int page, int pageSize) { 
	        int start = (page - 1) * pageSize;
	        return dao.searchCustomersWithPaging(customerName, contact, empno ,  start, pageSize);
	    }
	    
	    // 검색 글 갯수
	    public int countSearchCustomers(String customerName, String contact , Integer empno) { 
	        return dao.countSearchCustomers(customerName, contact ,empno);
	    }
	    
	    // 진행상태 글 갯수
	    public int countCustomersByStatus(String status) { 
	        return dao.countCustomersByStatus(status);
	    }
	    
	    // 진행 상태별 리스트
	    public List<CustomerInfoDTO> getCustomersByStatusWithPaging(String status, int page, int pageSize) { 
	        int start = (page - 1) * pageSize;
	        return dao.getCustomersByStatusWithPaging(status, start, pageSize);
	    }
	    
	    
	    
}
