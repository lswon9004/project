package commet.hwon.user.security.Reply;

import lombok.Data;

@Data
public class ReplyDto {
	
	private int cno;
	private String id;
	private int board_no;
	private String content;
	private int ref;
	private int re_step;
	private int re_level;
	private String password;

}
