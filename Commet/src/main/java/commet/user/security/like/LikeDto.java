package commet.user.security.like;

import lombok.Data;

@Data
public class LikeDto {
    private int lno; // 추천의 고유 번호
    private String table; // 추천이 적용된 테이블 이름
    private int empno; // 추천을 누른 사용자의 번호
    private int no; // 추천이 적용된 게시물의 번호
    private boolean count; // 좋아요 여부 (true : 추천, false : 추천 취소
}
