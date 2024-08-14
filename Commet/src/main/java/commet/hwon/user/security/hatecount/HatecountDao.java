package commet.hwon.user.security.hatecount;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface HatecountDao {
	
	@Insert("insert into hatecount(`table`, empno, board_no,count) values('Bulletin_Board',#{empno},#{no},1)")
	int inserthateCount(@Param("empno") int empno,@Param("no") int no);
	
	@Select("select count(*) from hatecount where `table` = 'Bulletin_Board' and board_no = #{no} and empno = #{empno} and count = 1")
	int hatecountCheck(@Param("empno") int empno,@Param("no") int no);
	
	 @Update("UPDATE hatecount SET count =  1 WHERE board_no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
		    int increasehateCount(@Param("empno") int empno,@Param("no") int no);
	 
	 @Update("UPDATE hatecount SET count =  0 WHERE board_no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
	    int decreasehateCount(@Param("empno") int empno,@Param("no") int no);
	 
	 @Select("select count(*) from hatecount where `table` = 'Bulletin_Board' and board_no = #{no} and count = 1")
	 int hateCount(int no);
	 
	 @Select("select count(*) as count, no from hatecount where count = 1 and `table` = 'Bulletin_Board'  group by no")
	 List<Map<String, Integer>> hateCountList();
}
