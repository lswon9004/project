package commet.hwon.user.security.likecount;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikecountService {
	
	 @Autowired
	    private LikecountDao likeDao;

	    public void saveLike(LikecountDto likeDto) {
	        likeDao.saveLike(likeDto);
	    }

	    public int getLike(int no) {
	        return likeDao.findByNo(no);
	    }
	    public List<Map<String, Integer>> likeList(){
	    	return likeDao.likeList();
	    }
}
