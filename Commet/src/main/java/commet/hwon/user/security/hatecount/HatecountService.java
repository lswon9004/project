package commet.hwon.user.security.hatecount;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HatecountService {
	
	  @Autowired
	    private HatecountDao hateDao;

	    public void saveHate(HatecountDto hateDto) {
	        hateDao.saveHate(hateDto);
	    }

	    public int getHate(int no) {
	        return hateDao.findByNo(no);
	    }
	    public List<Map<String, Integer>> hateList(){
	    	return hateDao.hateList();
	    }

}
