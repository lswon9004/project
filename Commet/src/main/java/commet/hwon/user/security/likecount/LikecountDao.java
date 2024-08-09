package commet.hwon.user.security.likecount;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface LikecountDao {
	
	@Insert("INSERT INTO likeCount (table, empno, no, count) VALUES (Bulletinboard, #{empno}, #{no}, 1)")
    void saveLike(LikecountDto likeDto);

    @Select("SELECT count(*) FROM likeCount WHERE no = #{no} and table = Bulletinboard and count =1")
    int findByNo(int no);
    
	@Select("select count(*) as count ,no from likeCount WHERE `table` = 'Bulletinboard' and count =1 group by no")
	List<Map<String, Integer>> likeList();

}
