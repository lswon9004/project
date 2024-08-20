package commet.hwon.user.security.hatecount;

import lombok.Data;

@Data
public class HatecountDto {
	
	private int no; // 싫어요 기록의 고유 식별 번호
	private String table; //싫어요 적용된 테이블
	private int count; // 현재 싫어요 수 
	private int board_no; // 싫어요 적용된 게시글 번호
	private int empno; // 싫어요 클릭한 사용자 id

}
