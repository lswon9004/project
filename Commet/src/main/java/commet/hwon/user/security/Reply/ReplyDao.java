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
	
	@Insert("INSERT INTO reply (cno, id, password, board_no, content, ref, re_step, re_level)VALUES (#{cno}, #{id}, #{password}, #{board_no}, #{content}, #{ref}, #{re_step}, #{re_level}")
	@Options(useGeneratedKeys = true, keyProperty = "cno")	
	int insertReply(ReplyDto replyDto);
	    
		@Select("SELECT * FROM reply WHERE board_no = #{board_no}")
	   List<ReplyDto> selectReplies(@Param("board_no") int board_no);
		
	    
		@Delete("DELETE FROM reply WHERE cno = #{cno}")
	   int deleteReply(@Param("cno") int cno);
}
