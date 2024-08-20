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
	
	//새로운 댓글을 삽입하고, 해당 게시글의 상세 페이지로 리다이렉트
	@PostMapping("/content/insert")
	public String insertReply(ReplyDto reply) {
		replyservice.insertReply(reply);
		return "redirect:/content/" + reply.getBoard_no();  
	}
	
	//특정 댓글의 내용을 수정하고 수정된 댓글 객체를 json형태 반환
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
	
	//특정 댓글을 삭제하고, 해당 게시글의 상세 페이지로 리다이렉트
	@PostMapping("/reply/delete")
	public String deleteReply(@RequestParam("cno") int cno,@RequestParam("no")int no) {
		replyservice.deleteReply(cno);
		return "redirect:/content/"+no;
	}
	
	  
}
