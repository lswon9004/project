package commet.user.security.comment;

import java.util.Date;

import lombok.Data;

@Data
public class CommentDto {
    private int cno; // 댓글의 고유 번호를 저장하는 필드
    private int empno; // 작성자 번호를 저장하는 필드
    private int no; // 해당 댓글이 달린 게시물의 번호를 저장하는 필드
    private String text; // 댓글 내용을 저장하는 필드
    private Date regdate; // 댓글 작성일자를 저장하는 필드
}
