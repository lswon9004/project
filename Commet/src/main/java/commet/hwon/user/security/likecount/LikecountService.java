package commet.hwon.user.security.likecount;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikecountService {
	
	 @Autowired
	 LikecountDao likeDao;
	 
	 //특정 게시글에 대한 총 좋아요 수를 반환
	 public int likeCount(int no) {
		return likeDao.likeCount(no);
	 }
	 
	 //특정 게시글에 대해 사용자가 좋아요를 추가, 취소
	 public int increaseLikeCount(int no, int empno) {
		int i = likeDao.likecountCheck(empno, no);
		if(i>0) {
			return likeDao.decreaseLikeCount(empno, no);
		}else {
			return likeDao.insertlikeCount(empno, no);
		}
	        
	    }

	 //모든 게시글에 대한 좋아요 수 목록 반환
	 public  List<Map<String, Integer>> likeCountList(){
		 return likeDao.likeCountList();
	 }
}
