package commet.hwon.user.security.hatecount;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HatecountController {
	 @Autowired
	    private HatecountService hateService;

	    @PostMapping("/hate")
	    public String saveHate(HatecountDto hateDto) {
	        hateService.saveHate(hateDto);
	        return "redirect:/content/" + hateDto.getBoard_no();
	    }

	    @GetMapping("/hate/{no}")
	    public String getHate(@PathVariable("no") int no, Model model) {
	        
	        return "/hate";
	    }

}
