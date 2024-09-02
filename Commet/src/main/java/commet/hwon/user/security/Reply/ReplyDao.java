package commet.hwon.user.security.Reply;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import commet.user.security.comment.CommentDto;


@Mapper
public interface ReplyDao {
	
	//새로운 댓글을 데이터베이스 삽입
	@Insert("INSERT INTO Reply (id, password, board_no, content)VALUES (#{id}, #{password}, #{board_no}, #{content})")
	int insertReply(ReplyDto replyDto);
	
	//특정 댓글의 내용을 업데이트
	@Update("UPDATE Reply SET content = #{content} WHERE cno = #{cno}")
	int updateReply(ReplyDto replyDto);
	
	//특정 게시글(board_no)에 속한 모든 댓글 조회
    @Select("SELECT * FROM Reply WHERE board_no = #{board_no}")
	List<ReplyDto> selectReplies(@Param("board_no") int board_no);
		
	//특정 댓글을 삭제    
	@Delete("DELETE FROM Reply WHERE cno = #{cno}")
	int deleteReply(@Param("cno") int cno);
}
