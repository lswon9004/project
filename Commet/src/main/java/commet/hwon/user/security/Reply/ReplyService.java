package commet.hwon.user.security.Reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyDao replydao;

	//특정 게시글(board_no)에 대한 모든 댓글을 조회
    public List<ReplyDto> selectreplies(int board_no){
     return replydao.selectReplies(board_no);
    }
    
    //새로운 댓글을 데이터베이스 삽입
    public int insertReply(ReplyDto replyDto) {
    	return replydao.insertReply(replyDto);
    }
    
    //특정 댓글(cno)을 데이터베이스 삭제
    public int deleteReply(int cno) {
    	return replydao.deleteReply(cno);
    }
    
    //특정 댓글의 내용을 데이터베이스에서 업데이트
    public int updateReply(ReplyDto replyDto) {
    	return replydao.updateReply(replyDto);
    }
}
