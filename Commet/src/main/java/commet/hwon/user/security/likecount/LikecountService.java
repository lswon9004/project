package commet.hwon.user.security.likecount;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikecountService {
	
	 @Autowired
	 LikecountDao likeDao;
	 
	 public int likeCount(int no) {
		 return likeDao.likeCount(no);
	 }
	 
	 public int increaseLikeCount(int no, int empno) {
		int i = likeDao.likecountCheck(empno, no);
		if(i>0) {
			return likeDao.decreaseLikeCount(empno, no);
		}else {
			return likeDao.insertlikeCount(empno, no);
		}
	        
	    }

	 public  List<Map<String, Integer>> likeCountList(){
		 return likeDao.likeCountList();
	 }
}
