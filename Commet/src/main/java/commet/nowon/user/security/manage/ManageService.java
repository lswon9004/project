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
		m.put("count", 30);
		m.put("empno", empno);
		return dao.managemain(m);
    }
    
    public int countSearchResults(String deptname, String ename) {
        return dao.countSearchResults(deptname, ename);
    }
   
    public ManageDto getempByID(int id) {
        return dao.getempByID(id);
    }
    
    public int updateEmp(ManageDto ModifyDto) {
		return dao.updateEmp(ModifyDto);
	}
    public int staffUpdateEmp(ManageDto staffModifyDto) {
		return dao.staffUpdateEmp(staffModifyDto);
	}
    
    public List<ManageDto> getEmpsByIds(Integer[] deptnos) {
        return dao.getEmpsByIds(deptnos);
    }

    public List<ManageDto> searchEmpsWithPagination(String deptname, String ename, int start, int count) {
        return dao.searchEmpsWithPagination(deptname, ename, start, count);
    }

   
    
    public void deleteEmps(int[] empnos) {
    	dao.deleteEmps(empnos);
    }
    public List<ManageDto> searchDept(){
    	return dao.searchDept();
    }
    public List<ManageDto> searchPosition(){
    	return dao.searchPosition();
    }

}
