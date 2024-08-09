package commet.swon.emp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmpService {
	
	@Autowired
	Empdao dao;
	
	public EmpDto login(int no) {
		return dao.login(no);
	}
	public int getRight(String position) {
		return dao.getRight(position);
	}
	public int loginCount(int count) {
		return dao.loginCount(count);
	}
	public int getCount(int empno) {
		return dao.getLoginCount(empno);
	}
	public List<Integer> getNoList(int deotno){
		return dao.getEmpnolist(deotno);
	}
}
