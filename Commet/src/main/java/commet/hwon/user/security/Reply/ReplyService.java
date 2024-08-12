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
    
    public List<ReplyDto> insertReply(ReplyDto replyDto) {
    	replydao.insertReply(replyDto);
    	return replydao.selectReplies(replyDto.getBoard_no());
    }
    
    public List<ReplyDto> deleteReply(int cno, int board_no) {
    	replydao.deleteReply(cno);
    	return replydao.selectReplies(board_no);
    }
}
