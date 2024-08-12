package commet.hwon.user.security.bulletinboard;

import java.util.List;


import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface BulletinboardDao {
	
	//데이터베이스에 새 게시글을 삽입하는 메서드
	@Insert("INSERT INTO BULLETIN_BOARD (title, content, iid, password)	VALUES(#{title}, #{content}, #{iid}, #{password})")
    void save(@Param("title")String title,@Param("content")String content,@Param("iid")String iid,@Param("password")String password);
   
    //데이터베이스에서 모든 게시글을 조회하는 메서드
    @Select("SELECT * FROM BULLETIN_BOARD order by ref_date")    
    List<BulletinboardDto> findAll(@Param("start")int start,@Param("count")int count);
    
    //페이지 처리
    @Select("select count(*) from BULLETIN_BOARD ")
    int count();
   
    //게시글 상세보기
    @Select("SELECT * FROM BULLETIN_BOARD WHERE no = #{no}")
    BulletinboardDto getBoard(int no);
    
    //데이터베이스에 게시글을 업데이트하는 메서드
    @Update("UPDATE BULLETIN_BOARD SET title = #{title}, content = #{content}  WHERE no = #{no}")
    void update(BulletinboardDto boardDto);
    
    //게시글의 조회수를 증가하는 메서드
    @Update("UPDATE BULLETIN_BOARD SET readCount = readCount + 1 WHERE no = #{no}")
    void increaseReadCount(int no);
    
    //게시글을 삭제하는 메서드
   @Delete("DELETE FROM BULLETIN_BOARD WHERE no = #{no}")
    void delete(int no);
   
   //게시글을 검색하는 메서드
       @Select({"<script> SELECT * FROM BULLETIN_BOARD ",
       "<where> ",
       		"<if test=\"title !=''\"> ",
       			"title LIKE  #{title} ",
       		"</if>",
       		"<if test=\"content == ''\">",
       			"and content LIKE  #{content} ",
       		"</if> ",
       "</where> ",
       "order by ref_date desc limit #{start} , 10 </script>"})
      List<BulletinboardDto> search(@Param("title")String title,@Param("content")String content,@Param("start") int start);




}

