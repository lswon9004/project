package commet.hwon.user.security.likecount;

import lombok.Data;

@Data
public class LikecountDto {
	
	private int lno; // 좋아요 고유 식별자
	private String table; // 좋아요 속한 테이블
	private int empno; // 좋아요를 표시한 사용자의 id, 직원번호
	private int no; //좋아요가 속한 항목의 번호
	private int count; //해당 항목에 대한 좋아요 수를 나타내는 필드

}
