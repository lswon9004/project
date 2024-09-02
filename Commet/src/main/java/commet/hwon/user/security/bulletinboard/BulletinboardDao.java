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
	@Insert("INSERT INTO Bulletin_Board (title, content, iid, password)	VALUES(#{title}, #{content}, #{iid}, #{password})")
    void save(@Param("title")String title,@Param("content")String content,@Param("iid")String iid,@Param("password")String password);
   
    //데이터베이스에서 모든 게시글을 조회하는 메서드 , start와 count 페이지네이션 사용
    @Select("SELECT * FROM Bulletin_Board order by ref_date limit #{start} ,10")    
    List<BulletinboardDto> findAll(@Param("start")int start);
    
    //게시글의 총 수를 반환함
    @Select("select count(*) from Bulletin_Board ")
    int count();
   
    //특정 번호의(no)의 게시글을 조회하고 조회된 결과를 반환함
    @Select("SELECT * FROM Bulletin_Board WHERE no = #{no}")
    BulletinboardDto getBoard(int no);
    
    //게시글의 비밀버호를 가져오는 메서드
    //String getPassword(int no);
   
    //특정 게시글의 제목과 내용을 업데이트함
    @Update("UPDATE Bulletin_Board SET title = #{title}, content = #{content}  WHERE no = #{no}")
    int update(BulletinboardDto boardDto);
    
    //특정 게시글의 조회수를 1 증가시킴
    @Update("UPDATE Bulletin_Board SET readCount = readCount + 1 WHERE no = #{no}")
    void increaseReadCount(int no);
    
    //특정 번호(no)와 비밀번호를 가진 게시글 삭제
   @Delete("DELETE FROM Bulletin_Board WHERE no = #{no} and password = #{password}")
    int deleteboard(@Param("no")int no, @Param("password")String password);
   
   //제목과 내용으로 게시글을 검색하고, 검색 결과를 페이지네이션함
       @Select({"<script> SELECT * FROM Bulletin_Board ",
       "<where> ",
       		"<if test=\"title !=''\"> ",
       			"title LIKE  #{title} ",
       		"</if>",
       		
       "</where> ",
       "order by ref_date desc limit #{start} , 10 </script>"})
      List<BulletinboardDto> search(@Param("title")String title,@Param("start") int start);
       @Select({"<script> SELECT count(*) FROM Bulletin_Board ",
           "<where> ",
           		"<if test=\"title !=''\"> ",
           			"title LIKE  #{title} ",
           		"</if>",
           		
           "</where> </script>"})
          int searchcount(@Param("title")String title);




}

