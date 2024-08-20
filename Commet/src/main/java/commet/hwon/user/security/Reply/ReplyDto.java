package commet.hwon.user.security.Reply;

import lombok.Data;

@Data
public class ReplyDto {
	
	private int cno; //댓글의 고유번호
	private String id; //댓글 작성자
	private int board_no; // 댓글 속한 게시글 번호
	private String content; //댓글 내용 포함
	private int ref; // 댓글 속한 그룹 나타낸 필드
	private int re_step; // 같은 그룹 내에서 댓글의 순서
	private int re_level; // 댓글의 답급 레벨 
	private String password; //댓글 삭제 시 필요한 비밀번호

}
