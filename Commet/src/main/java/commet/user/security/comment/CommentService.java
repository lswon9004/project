package commet.user.security.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentDao commentDao; // CommnetDao 의존성 주입

    public int insertComment(CommentDto comment) {
        return commentDao.insertComment(comment);
    } // 객체를 받아서 새로운 댓글을 데이터베이스에 삽입하는 메서드
      // return -> 삽입된 행의 수를 반환

    public int updateComment(CommentDto comment) {
        return commentDao.updateComment(comment);
    } // 객체를 받아서 기존 댓글을 업데이트 하는 메서드
      // return -> 업데이트된 행의 수를 반환

    public int deleteComment(int cno) {
        return commentDao.deleteComment(cno);
    } // 댓글의 번호(cno)를 받아서 해당 댓글을 삭제하는 메서드
      // return -> 삭제된 행의 수를 반환

    public List<CommentDto> getCommentsByBoardNo(int no) {
        return commentDao.selectCommentsByBoardNo(no);
    } // 게시물 번호(no)를 받아서 해당 게시물에 달린 모든 댓글을 조회하는 메서드
      // return -> 댓글 목록을 리스트로 반환
}
