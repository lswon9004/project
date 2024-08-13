package commet.hwon.user.security.Reply;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;



@Controller
public class ReplyController {
	
	@Autowired
	 private ReplyService replyservice;
	
	@PostMapping("/content/insert")
	public String insertreply(@RequestParam("cno") int cno,
			@RequestParam("id") String id, @RequestParam("password") String password) {
		ReplyDto reply = new ReplyDto();
		reply.setCno(cno);
		reply.setId(id);
		reply.setPassword(password);
		replyservice.insertReply(reply);
		return "redirect:/bullboard/" + cno;  
	}
	
	@GetMapping("/content/select")
	@ResponseBody
	public String getReplies(@RequestParam("board_no") int board_no,
			@RequestParam("content") String content) {
		ReplyDto reply = new ReplyDto();
		reply.setBoard_no(board_no);
		reply.setContent(content);
		replyservice.selectreplies(board_no);
		return "reply";
	}
	
	@PostMapping("/reply/delete")
	public String deleteReply(@RequestParam("cno") int cno,
			@RequestParam ("board_no") int board_no) {
		
		replyservice.deleteReply(cno, board_no);
		return "redirect:/bullboard/" + cno;
	}

	  
}
