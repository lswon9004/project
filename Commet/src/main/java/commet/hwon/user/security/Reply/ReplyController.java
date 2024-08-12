package commet.hwon.user.security.Reply;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
@RequestMapping("/content/{no}/replies")
public class ReplyController {
	
	@Autowired
	 private final ReplyService replyService;

	
	    public ReplyController(ReplyService replyService) {
	        this.replyService = replyService;
	    }

	    // 댓글 등록
	    @PostMapping
	    public String addReply(@PathVariable("no") int boardNo, @RequestParam("content") String content, 
	                           @RequestParam("id") String id, @RequestParam("password") String password) {
	        ReplyDto replyDto = new ReplyDto();
	        replyDto.setBoard_no(boardNo);
	        replyDto.setContent(content);
	        replyDto.setId(id);
	        replyDto.setPassword(password);

	        replyService.addReply(replyDto);
	        return "redirect:/content/" + boardNo;
	    }

	    // 댓글 삭제
	    @DeleteMapping("/{cno}/delete")
	    public String deleteReply(@PathVariable("no") int boardNo, @PathVariable("cno") int cno,
	                              @RequestParam("password") String password) {
	        replyService.removeReply(cno, password);
	        return "redirect:/content/" + boardNo;
	    }
    

}
