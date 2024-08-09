package commet.hwon.user.security.Reply;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReplyDao {
	
	@Insert("INSERT INTO reply (cno, id, board_no, content, ref, re_step, re_level, password)VALUES (#{cno}, #{id}, #{board_no}, #{content}, #{ref}, #{re_step}, #{re_level}, #{password})")
	int insertReply(ReplyDto replyDto);
	    
	   @Select("SELECT * FROM reply WHERE board_no = #{board_no}")
	   List<ReplyDto> selectReplies(int board_no);
	    
	   @Delete("DELETE FROM reply WHERE cno = #{cno}")
	   int deleteReply(int cno);
}
