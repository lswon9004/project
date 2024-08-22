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
	
	//게시글에 새로운 좋아요 추가
	@Insert("insert into likecount(`table`, empno, no,count) values('Bulletin_Board',#{empno},#{no},1)")
	int insertlikeCount(@Param("empno") int empno,@Param("no") int no);
	
	//특정 사용자가 특정 게시글에 대해 이미 좋아요를 했는지 확인
	@Select("select count(*) from likecount where `table` = 'Bulletin_Board' and no = #{no} and empno = #{empno} and count = 1")
	int likecountCheck(@Param("empno") int empno,@Param("no") int no);
	
	@Select("select count(*) from likecount where `table` = 'Bulletin_Board' and no = #{no} and empno = #{empno}")
	int slcount(@Param("empno") int empno,@Param("no") int no);
	
	//특정 사용자의 특정 게시글에 대한 좋아요를 활성화
     @Update("UPDATE likecount SET count =  1 WHERE no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
     int increaseLikeCount(@Param("empno") int empno,@Param("no") int no);
	
     //특정 사용자의 특정 게시글에 대한 좋아요를 비활성화
	 @Update("UPDATE likecount SET count =  0 WHERE no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
	 int decreaseLikeCount(@Param("empno") int empno,@Param("no") int no);
	 
	 //특정 게시글의 총 좋아요 수를 조회
	 @Select("select count(*) from likecount where count = 1 and `table` = 'Bulletin_Board' and no =#{no}")
	 int likeCount(int no);
	 
	 //모든 게시글에 대한 총 좋아요 수 목록 조회
	 @Select("select count(*) as count,no from likecount where count = 1 and `table` = 'Bulletin_Board'  group by no")
	 List<Map<String, Integer>> likeCountList();
}
