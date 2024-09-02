package commet.swon.file;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface FilesDao {
	@Insert("insert into File(board_name,board_no,path,fname,date) values('approval',#{no},#{path},#{fname},current_date())")
	int insertFile(@Param("no")int no,@Param("path")String path,@Param("fname")String fname);
	@Select("select * from File where board_name = 'Approval' and board_no= #{no}")
	FilesDto oneFile(int no);
	@Select("select * from File where file_no =#{no}")
	FilesDto oneDownFile(int no);///a
}
