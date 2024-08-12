package commet.hwon.user.security.Reply;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReplyDao {
	
	@Insert("""
	        INSERT INTO reply (id, board_no, content, ref, re_step, re_level, password)
	        VALUES (#{id}, #{board_no}, #{content}, #{ref}, #{re_step}, #{re_level}, #{password})
	    """)
	int insertReply(ReplyDto replyDto);  // 댓글 삽입
	    
	@Select("""
	        SELECT * 
	        FROM reply 
	        WHERE board_no = #{board_no}
	        ORDER BY ref ASC, re_step ASC
	    """)
	   List<ReplyDto> selectReplies(int board_no);// 특정 게시글의 모든 댓글 조회
	    
	// 댓글 삭제
    @Delete("DELETE FROM reply WHERE cno = #{cno}")
	   int deleteReply(int cno);
}
