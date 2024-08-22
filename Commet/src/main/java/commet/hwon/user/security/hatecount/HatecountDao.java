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
	
	//특정 게시글에 대해 사용자가 '싫어요'를 클릭했을 때 '싫어요' 기록을 db 삽입
	@Insert("insert into hatecount(`table`, empno, board_no,count) values('Bulletin_Board',#{empno},#{no},1)")
	int inserthateCount(@Param("empno") int empno,@Param("no") int no);
	
	//특정 사용자가 특정 게시글에 대해 이미 '싫어요'를 클릭해쓴지 확인함
	@Select("select count(*) from hatecount where `table` = 'Bulletin_Board' and board_no = #{no} and empno = #{empno} and count = 1")
	int hatecountCheck(@Param("empno") int empno,@Param("no") int no);
	
	@Select("select count(*) from hatecount where `table` = 'Bulletin_Board' and board_no = #{no} and empno = #{empno}")
	int shcount(@Param("empno") int empno,@Param("no") int no);
	
	//특정 사용자가 특정 게시글에 대해 '싫어요'를 추가, 변경
	@Update("UPDATE hatecount SET count =  1 WHERE board_no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
    int increasehateCount(@Param("empno") int empno,@Param("no") int no);
	 
	//특정 사용자가 특정 게시글에 대해 '싫어요'를 취소
	@Update("UPDATE hatecount SET count =  0 WHERE board_no = #{no} and `table` = 'Bulletin_Board' and empno = #{empno}")
	int decreasehateCount(@Param("empno") int empno,@Param("no") int no);
	
	//특정 게시글에 대한 총 '싫어요' 수를 조회
	@Select("select count(*) from hatecount where `table` = 'Bulletin_Board' and board_no = #{no} and count = 1")
	int hateCount(int no);
	
	//모든 게시글에 대한 '싫어요' 수를 조회하여 리스트 형태 반환
	@Select("select count(*) as count, board_no from hatecount where count = 1 and `table` = 'Bulletin_Board'  group by board_no")
	List<Map<String, Integer>> hateCountList();
}
