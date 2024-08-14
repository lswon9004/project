package commet.hwon.user.security.Reply;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;




@Controller
public class ReplyController {
	
	@Autowired
	 private ReplyService replyservice;
	
	@PostMapping("/content/insert")
	public String insertReply(ReplyDto reply) {
		
		replyservice.insertReply(reply);
		return "redirect:/content/" + reply.getBoard_no();  
	}
	
	@PostMapping("/content/update")
	@ResponseBody
	public ReplyDto updatereply(@RequestParam("cno") int cno,
			@RequestParam("content")String content) {
		ReplyDto reply = new ReplyDto();
		reply.setCno(cno);
		reply.setContent(content);
		replyservice.updateReply(reply);
		return reply;
	}
	
	@PostMapping("/reply/delete")
	public String deleteReply(@RequestParam("cno") int cno,@RequestParam("no")int no) {
		replyservice.deleteReply(cno);
		return "redirect:/content/"+no;
	}
	
	  
}
