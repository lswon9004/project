package commet.hwon.user.security.hatecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class HatecountController {
	
	@Autowired
	private HatecountService hateService;
	 
	//특정 게시글에 대해 사용자가 '싫어요'를 추가, 취소
	 @GetMapping("/bullboard/hate")
	 @ResponseBody
	public String increaseHateCount(@RequestParam("no")String no, @RequestParam("empno")int empno) {
		int no2 = Integer.parseInt(no);
		Gson gson = new Gson();
			
		return gson.toJson(hateService.increaseHateCount(no2, empno));
		 
	}
	 
    //특정 게시글의 '싫어요' 수를 조회하는 기능처리
	@GetMapping("/hate/{no}")
	public int getHate(@PathVariable("no") int no) {
			
	 return 1;
	}
	
}
