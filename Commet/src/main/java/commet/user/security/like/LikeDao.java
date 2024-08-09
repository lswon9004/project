package commet.user.security.like;

import org.apache.ibatis.annotations.*;

@Mapper
public interface LikeDao {
	
	// 게시물 추천을 추가하는 메서드
    @Insert("INSERT INTO likeCount (`table`, empno, `no`, `count`) VALUES ('board', #{empno}, #{no}, true)")
    void like(@Param("no") int boardNo, @Param("empno") int empno);
    // INSERT INTO likeCount 쿼리를 실행하여 추천 정보를 likeCount 테이블에 삽입
    
    // 게시물 추천을 취소하는 메서드
    @Delete("DELETE FROM likeCount WHERE `table` = 'board' AND `no` = #{no} AND empno = #{empno}")
    void unlike(@Param("no") int boardNo, @Param("empno") int empno);
    // DELETE FROM likeCount 쿼리를 실행하여 likeCount 테이블에서 해당 추천 정보를 삭제

    // 특정 게시물의 총 추천 수를 조회하는 메서드
    @Select("SELECT COUNT(*) FROM likeCount WHERE `table` = 'board' AND `no` = #{no} AND `count` = true")
    int likeCount(@Param("no") int boardNo);
    // SELECT COUNT(*) FROM likeCount 쿼리를 실행하여 likeCount 테이블에서 해당 게시물의 추천 수를 조회
    
    // 특정 사용자가 특정 게시물에 추천을 눌렀는지 확인하는 메서드
    @Select("SELECT COUNT(*) > 0 FROM likeCount WHERE `table` = 'board' AND `no` = #{no} AND empno = #{empno} AND `count` = true")
    boolean hasLiked(@Param("no") int boardNo, @Param("empno") int empno);
    // SELECT COUNT(*) > 0 FROM likeCount 쿼리를 실행하여 likeCount 테이블에서 해당 게시물과 사용자의 추천 여부를 확인
}
