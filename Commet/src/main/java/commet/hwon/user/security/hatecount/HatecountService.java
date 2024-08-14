package commet.hwon.user.security.hatecount;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HatecountService {
	
	  @Autowired
	   HatecountDao hateDao;
	  
	  public int hateCount(int no) {
		  return hateDao.hateCount(no);
	  }
	  
	  public int increaseHateCount(int no, int empno) {
		  int i = hateDao.hatecountCheck(empno, no);
		  if(i>0) {
			  return hateDao.decreasehateCount(empno, no);
		  }else {
			  return hateDao.inserthateCount(empno, no);
		  }
	  }
	  
	  public  List<Map<String, Integer>> hateCountList(){
			 return hateDao.hateCountList();
		 }

}

