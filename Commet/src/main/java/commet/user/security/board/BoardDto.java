package commet.user.security.board;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDto {
    private int no; // 게시물의 고유 번호
    private int empno; // 작성자 번호를 저장하는 필드
    private String title; // 게시물 제목을 저장하는 필드
    private String content; // 게시물 내용을 저장하는 필드
    private int readcount; // 게시물 조회수를 저장하는 필드
    private Date regdate; // 게시물 작성일자를 저장하는 필드
}
