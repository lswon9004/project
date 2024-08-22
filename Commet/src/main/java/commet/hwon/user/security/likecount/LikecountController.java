package commet.hwon.user.security.likecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class LikecountController {
	
	 @Autowired
	 private LikecountService likeService;
	 
	 //특정 게시글에 대한 사용자의 좋아요를 추가, 취소
	 @GetMapping("/bullboard/like")
	 @ResponseBody
	public String increaseLikeCount(@RequestParam("no")String no,@RequestParam("empno")int empno) {
		 System.out.println(no);
        int no1 = Integer.parseInt(no);
		Gson gson = new Gson();
			
		return gson.toJson(likeService.increaseLikeCount(no1,empno));
	}

	 //특정 게시글의 좋아요 수를 조회하는 메서드
	@GetMapping("/like/{no}")
	public int getLike(@PathVariable("no") int no) {
			return 1;
   }

}
