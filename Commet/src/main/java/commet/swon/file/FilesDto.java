package commet.swon.file;

import java.util.Date;

import lombok.Data;

@Data
public class FilesDto {
	private int file_no;
	private String board_name;
	private int board_no;
	private String path;
	private String fname;
	private Date date;
}
