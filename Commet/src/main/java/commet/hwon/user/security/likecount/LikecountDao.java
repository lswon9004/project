package commet.hwon.user.security.likecount;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface LikecountDao {
	
	@Insert("insert into likecount(`table`, empno, no,count) values('Bulletin_Board',#{empno},#{no},1)")
	int insertlikeCount(@Param("empno") int empno,@Param("no") int no);
	
	@Select("select count(*) from likecount where `table` = 'Bulletin_Board' and no = #{no} and empno = #{empno} and count = 1")
	int likecountCheck(@Param("empno") int empno,@Param("no") int no);
	
	 @Update("UPDATE likecount SET count =  1 WHERE no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
		    int increaseLikeCount(@Param("empno") int empno,@Param("no") int no);
	
	 @Update("UPDATE likecount SET count =  0 WHERE no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
	    int decreaseLikeCount(@Param("empno") int empno,@Param("no") int no);
	 
	 @Select("select count(*) from likecount where count = 1 and `table` = 'Bulletin_Board' and no =#{no}")
	 int likeCount(int no);
	 
	 @Select("select count(*) as count,no from likecount where count = 1 and `table` = 'Bulletin_Board'  group by no")
	 List<Map<String, Integer>> likeCountList();
}
