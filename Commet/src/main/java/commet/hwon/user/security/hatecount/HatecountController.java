package commet.hwon.user.security.hatecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import commet.hwon.user.security.likecount.LikecountDto;

@Controller
public class HatecountController {
	
	@Autowired
	private HatecountService hateService;
	 
	 @GetMapping("/bullboard/hate")
	 @ResponseBody
		public String increaseHateCount(@RequestParam("no")String no, @RequestParam("empno")int empno) {
			int no2 = Integer.parseInt(no);
			Gson gson = new Gson();
			
			return gson.toJson(hateService.increaseHateCount(no2, empno));
		 
		}

		@GetMapping("/hate/{no}")
		public int getHate(@PathVariable("no") int no) {
			// Assuming that the 'hatecount' table is used to store the hates
			return 1;
		}
	
}
