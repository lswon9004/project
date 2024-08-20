package commet.user.security.board;

import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BoardDao {
	
	// 게시물을 저장하는 메서드
    @Insert("INSERT INTO board (empno, title, content, readcount, regdate) VALUES (#{empno}, #{title}, #{content}, #{readcount}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "no")
    int insert(BoardDto dto); // BoardDto 객체를 이용하여 게시물을 데이터베이스에 삽입
    						  // return -> 삽입된 행의 수를 반환
    // 모든 게시물을 조회하는 메서드
    @Select("SELECT * FROM board ORDER BY no DESC limit #{startRow}, 10")
    List<BoardDto> bAll(int startRow); // 데이터베이스에서 모든 게시물을 조회하여 리스트로 반환
    					   // return -> 게시물 목록 리스트
    // 특정 게시물을 조회하는 메서드
    @Select("SELECT * FROM board WHERE no = #{no}")
    BoardDto bOne(int no); // 게시물 번호(no)를 이용하여 특정 게시물을 조회
    					   // return -> 조회된 게시물 객체
    // 게시물을 수정하는 메서드
    @Update("UPDATE board SET title = #{title}, content = #{content} WHERE no = #{no}")
    int update(BoardDto dto); //BoardDto 객체를 이용하여 게시물의 제목과 내용을 수정
    						  //return -> 수정된 행의 수를 반환
    // 게시물을 삭제하는 메서드
    @Delete("DELETE FROM board WHERE no = #{no}")
    int delete(int no); // 게시물 번호(no)를 이용하여 특정 게시물을 삭제
    					// return -> 삭제된 행의 수를 반환
    // 총 게시물 수를 조회하는 메서드
    @Select("SELECT COUNT(*) FROM board")
    int count(); // 데이터베이스에서 총 게시물 수를 조회
    			 // return -> 총 게시물 수
    // 특정 게시물의 조회수를 증가시키는 메서드
    @Update("UPDATE board SET readcount = readcount + 1 WHERE no = #{no}")
    int addReadcount(int no); // 게시물 번호(no)를 이용하여 해당 게시물의 조회수를 1증가
    						  // return -> 업데이트된 행의 수를 반환
    // 검색 조건에 맞는 게시물 수를 조회하는 메서드
    @Select("<script>" +
            "SELECT count(*) FROM board WHERE 1=1" +
            "<if test='title != null and title != \"\"'> AND title LIKE CONCAT('%', #{title}, '%')</if>" +
            "<if test='empno != null and empno != \"\"'> AND empno LIKE CONCAT('%', #{empno}, '%')</if>" +
            "<if test='date != null and date != \"\"'> AND DATE(regdate) = #{date}</if>" +
            " ORDER BY no DESC" +
            "</script>")
    int searchBoardsCount(@Param("title") String title, @Param("empno") String author, @Param("date") String date);
    
    // 검색 조건에 맞는 게시물을 조회하는 메서드
    @Select("<script>" +
            "SELECT * FROM board WHERE 1=1" +
            "<if test='title != null and title != \"\"'> AND title LIKE CONCAT('%', #{title}, '%')</if>" +
            "<if test='empno != null and empno != \"\"'> AND empno LIKE CONCAT('%', #{empno}, '%')</if>" +
            "<if test='date != null and date != \"\"'> AND DATE(regdate) = #{date}</if>" +
            " ORDER BY no DESC limit #{startRow}, 10" +
            "</script>")
    
    List<BoardDto> searchBoards(@Param("title") String title, @Param("empno") String author, @Param("date") String date,@Param("startRow")int startRow);
}	// 제목, 작성자, 날짜를 기준으로 검색 조건에 맞는 게시물을 조회
	// return -> 검색된 게시물 목록 리스트
