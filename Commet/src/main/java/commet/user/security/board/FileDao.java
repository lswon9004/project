package commet.user.security.board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface FileDao {

    @Insert("INSERT INTO File (board_name, board_no, path, fname, date) VALUES (#{boardName}, #{boardNo}, #{path}, #{fname}, NOW())")
    int insert(FileDto fileDto);

    @Select("SELECT * FROM File WHERE board_name = #{boardName} AND board_no = #{boardNo}")
    List<FileDto> getFilesByBoardNo(@Param("boardName") String boardName, @Param("boardNo") int boardNo);
}
