package commet.user.security.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class CommentController {
	
	// CommentService 인스턴스를 주입
    @Autowired
    private CommentService commentService;
    
    // 댓글을 추가하는 메서드
    @PostMapping("/comments/add")
    public String addComment(@RequestParam("no") int no,
                             @RequestParam("empno") int empno,
                             @RequestParam("text") String text) {
        CommentDto comment = new CommentDto(); // 새로운 CommentDto 객체 생성
        comment.setNo(no); // 댓글 객체의 게시글 번호 설정
        comment.setEmpno(empno); // 댓글 객체의 작성자 번호 설정
        comment.setText(text); // 댓글 객체의 내용 설정
        commentService.insertComment(comment); // CommentService를 사용하여 댓글을 데이터베이스에 삽입
        return "redirect:/boards/" + no; // 해당 게시글의 상세 페이지로 리다이렉트
    }
    
    // 댓글을 업데이트 하는 메서드 (AJAX 요청)
    @PostMapping("/comments/update")
    @ResponseBody
    public CommentDto updateComment(@RequestParam("cno") int cno,
                                    @RequestParam("text") String text) {
        CommentDto comment = new CommentDto(); // 업데이트할 CommentDto 객체 생성
        comment.setCno(cno); // 댓글 객체의 댓글 번호 설정
        comment.setText(text); // 댓글 객체의 새로운 내용 설정
        commentService.updateComment(comment); //CommentService를 사용하여 댓글을 데이터베이스에 업데이트
        return comment; // 업데이트된 댓글 객체를 반환
    }
    
    // 댓글을 삭제하는 메서드
    @PostMapping("/comments/delete")
    public String deleteComment(@RequestParam("cno") int cno,
                                @RequestParam("no") int no) {
        commentService.deleteComment(cno); // CommentService를 사용하여 댓글을 데이터베이스에서 삭제
        return "redirect:/boards/" + no; // 해당 게시글의 상세 페이지로 리다이렉트
    }
}
