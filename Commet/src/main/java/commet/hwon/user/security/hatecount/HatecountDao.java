package commet.hwon.user.security.hatecount;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface HatecountDao {
	
	@Insert("INSERT INTO hateCount (table, empno, board_no, count) VALUES (Bulletinboard, #{empno}, #{board_no}, 1)")
	 void saveHate(HatecountDto hateDto);
     
	@Select("SELECT count(*) FROM hateCount WHERE board_no = #{board_no} and table = Bulletinboard and count =1")
	 int findByNo(int no);
	 
	@Select("select count(*) as count ,board_no from hateCount WHERE `table` = 'Bulletinboard' and count =1 group by board_no")
	 List<Map<String, Integer>> hateList();

}
