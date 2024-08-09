package commet.hwon.user.security.likecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LikecountController {
	
	 @Autowired
	    private LikecountService likeService;

	    @PostMapping("/like")
	    public String saveLike(LikecountDto likeDto) {
	        likeService.saveLike(likeDto);
	        return "redirect:/content/" + likeDto.getNo();
	    }

	    @GetMapping("/like/{no}")
	    public String getLike(@PathVariable("no") int no, Model model) {
	        return "/like";
	    }

}
