package commet.hwon.user.security.likecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class LikecountController {
	
	 @Autowired
	    private LikecountService likeService;
	 
	 @GetMapping("/bullboard/like")
	 @ResponseBody
		public String increaseLikeCount(@RequestParam("no")String no,@RequestParam("empno")int empno) {
		 
		 	int no1 = Integer.parseInt(no);
			Gson gson = new Gson();
			
			return gson.toJson(likeService.increaseLikeCount(no1,empno));
		}

		@GetMapping("/like/{no}")
		public int getLike(@PathVariable("no") int no) {
			// Assuming that the 'likecount' table is used to store the likes
			return 1;
		}

}
