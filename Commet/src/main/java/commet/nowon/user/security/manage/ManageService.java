package commet.nowon.user.security.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commet.swon.emp.EmpDto;






@Service
public class ManageService {
	
	@Autowired
	ManageDao dao;
	
	public int insertEmp(ManageDto dto) {
		return dao.insertEmp(dto); // emp 저장할서비스
	}
	
    public int count() {
		return dao.count();
	}
    
    public List<ManageDto>managemain(int start, int empno){
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("count", 10);
		m.put("empno", empno);
		return dao.managemain(m);
    }
   
    public ManageDto getempByID(int id) {
        return dao.getempByID(id);
    }
    
    public int updateEmp(ManageDto ModifyDto) {
		return dao.updateEmp(ModifyDto);
	}
    
    public List<ManageDto> getEmpsByIds(int[] empnos) {
        return dao.getEmpsByIds(empnos);
    }
    
    public List<ManageDto> searchEmps(int empno, String ename) {
        return dao.searchEmps(empno, ename);
    }
    
    public void deleteEmps(int[] emps) {
    	dao.deleteEmps(emps);
    }
    public List<ManageDto> searchDept(){
    	return dao.searchDept();
    }
    public List<ManageDto> searchPosition(){
    	return dao.searchPosition();
    }

}
