package commet.hwon.user.security.bulletinboard;

import java.util.Date;

import lombok.Data;

@Data
public class BulletinboardDto {

	private int no; // 글번호
	private String title; // 글제목
	private String content; // 내용
	private String iid; // 작성자
	private String password; // 비번
	private Date ref_date; // 작성일
	private int readCount; // 조회수
	private int ref; // 답글을 달기 위한 참조번호 저장하는 정수형
	private int re_step; // 답글의 순서를 저장하는 정수형
	private int re_level; // 답글의 깊이를 저장하는 정수형
}
