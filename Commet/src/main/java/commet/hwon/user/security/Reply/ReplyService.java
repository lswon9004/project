package commet.hwon.user.security.Reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDao replydao;

    public List<ReplyDto> selectreplies(int board_no){
     return replydao.selectReplies(board_no);
    }
    
    public int insertReply(ReplyDto replyDto) {
    	
    	return replydao.insertReply(replyDto);
    }
    
    public int deleteReply(int cno) {
    	
    	return replydao.deleteReply(cno);
    }
    
    public int updateReply(ReplyDto replyDto) {
    	return replydao.updateReply(replyDto);
    }
}
