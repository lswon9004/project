package commet.hwon.user.security.Reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {
	
	@Autowired
    private ReplyDao replydao;

	  public ReplyService(ReplyDao replydao) {
	        this.replydao = replydao;
	    }

	    public void addReply(ReplyDto replydto) {
	        replydao.insertReply(replydto);
	    }

	    public List<ReplyDto> getReplies(int board_no) {
	        return replydao.selectReplies(board_no);
	    }

	    public void removeReply(int cno, String password) {
	        replydao.deleteReply(cno);
	    }
}
