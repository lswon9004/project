package commet.hwon.user.security.Reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {
	
	private final ReplyDao replyDao;

    @Autowired
    public ReplyService(ReplyDao replyDao) {
        this.replyDao = replyDao;
    }

    // 댓글 추가
    public void addReply(ReplyDto replyDto) {
        replyDao.insertReply(replyDto);
    }

    // 특정 게시글의 댓글 목록 조회
    public List<ReplyDto> getReplies(int boardNo) {
        return replyDao.selectReplies(boardNo);
    }

    // 댓글 삭제 (비밀번호 검증 추가)
    public void removeReply(int cno, String password) {
        ReplyDto reply = replyDao.selectReplies(cno)
                .stream()
                .filter(r -> r.getCno() == cno)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("댓글을 찾을 수 없습니다."));

        // 비밀번호 검증
        if (!reply.getPassword().equals(password)) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        replyDao.deleteReply(cno);
    }
}
