package commet.user.security.board;

import java.util.Date;

import lombok.Data;

@Data
public class FileDto {
    private int fileNo;
    private String boardName;
    private int boardNo;
    private String path;
    private String fname;
    private Date date;
}
