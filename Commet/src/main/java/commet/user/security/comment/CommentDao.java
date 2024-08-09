package commet.user.security.comment;

import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CommentDao {
	
	// 댓글을 삽입하는 메서드
    @Insert("INSERT INTO comment (no, empno, text, regdate) VALUES (#{no}, #{empno}, #{text}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "cno")
    int insertComment(CommentDto comment);
    // 주어진 CommentDto 객체의 내용을 사용하여 댓글을 데이터베이스에 삽입
    // 삽입된 댓글의 자동 생성된 기본 키(cno)를 반환
    
    // 댓글을 업데이트하는 메서드
    @Update("UPDATE comment SET text = #{text} WHERE cno = #{cno}")
    int updateComment(CommentDto comment);
    // 주어진 CommentDto 객체의 cno를 사용하여 데이터베이스에서 해당 댓글을 찾는다.
    // 주어진 CommentDto 객체의 text 필드 값을 사용하여 댓글 내용을 업데이트한다.
    
    // 댓글을 삭제하는 메서드
    @Delete("DELETE FROM comment WHERE cno = #{cno}")
    int deleteComment(@Param("cno") int cno);
    // 주어진 cno를 사용하여 데이터베이스에서 해당 댓글을 찾는다.
    // 해당 댓글을 데이터베이스에서 삭제
    
    // 게시글 번호로 댓글을 조회하는 메서드
    @Select("SELECT * FROM comment WHERE no = #{no}")
    List<CommentDto> selectCommentsByBoardNo(@Param("no") int no);
}	// 주어진 게시글 번호(no)를 사용하여 해당 게시글에 속한 모든 댓글을 데이터베이스에서 조회한다.
	// 조회된 댓글 목록을 반환한다.
