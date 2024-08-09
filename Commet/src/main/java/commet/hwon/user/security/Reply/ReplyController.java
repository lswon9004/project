package commet.hwon.user.security.Reply;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class ReplyController {
	
	@Autowired
	ReplyService replyservice;
	
	 
	  // 댓글 등록
    @PostMapping("/content/{no}/replies")
    public String addReply(@PathVariable("no") int no, @RequestParam(value = "content", required = false)String content) {
        // 수정: 변수명을 replyservice에서 replyService로 변경
        return "redirect:/content/" + no;
    }

    // 댓글 삭제
    @DeleteMapping("/content/{no}/reply/{cno}/delete")
    public String deleteReply(@PathVariable("no") int no, @PathVariable("cno") int cno,
            @RequestParam("password") String password) {
        replyservice.removeReply(cno, password); 
        return "redirect:/content/" + no;
    }

    

}
