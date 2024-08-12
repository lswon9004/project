package commet.hwon.user.security.likecount;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface LikecountDao {
	
	 // Insert a like count record
    @Insert("INSERT INTO likeCount (`table`, empno, no, `count`) VALUES ('Bulletinboard', #{empno}, #{no}, 1)")
    void saveLike(LikecountDto likeDto);

    // Find like count by post number
    @Select("SELECT COUNT(*) FROM likeCount WHERE no = #{no} AND `table` = 'Bulletinboard' AND `count` = 1")
    int findByNo(@Param("no") int no);
    
    // List like counts grouped by post number
    @Select("SELECT COUNT(*) AS count, no FROM likeCount WHERE `table` = 'Bulletinboard' AND `count` = 1 GROUP BY no")
    List<Map<String, Integer>> likeList();


}
