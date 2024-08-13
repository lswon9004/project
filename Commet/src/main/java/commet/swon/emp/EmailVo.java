package commet.swon.emp;

import lombok.Data;

@Data
public class EmailVo {
	private String subject;
	private String content;
	private String date;
	private String receiver;
}
