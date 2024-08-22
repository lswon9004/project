package commet.hwon.user.security.hatecount;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HatecountService {
	
	  @Autowired
	   HatecountDao hateDao;
	  
	  //주어진 게시글 번호(no)에 대한 총 '싫어요' 수를 조회
	  public int hateCount(int no) {
		  return hateDao.hateCount(no);
	  }
	  
	  //특정 사용자가 게시글에 대해 '싫어요'를 추가, 취소
	  public int increaseHateCount(int no, int empno) {
		  int i = hateDao.hatecountCheck(empno, no);
		  if(i>0) {
			   hateDao.decreasehateCount(empno, no);
		  }else {
			  if(hateDao.shcount(empno, no)>0) {
				  hateDao.increasehateCount(empno, no);
			  }else {
			   hateDao.inserthateCount(empno, no);
			  }
		  }
			  
		  return hateDao.hateCount(no);
	  }
	  
	 //모든 게시글에 대한 '싫어요' 수를 조회하여 리스트 반환 
	 public  List<Map<String, Integer>> hateCountList(){
			 return hateDao.hateCountList();
	 }

}

