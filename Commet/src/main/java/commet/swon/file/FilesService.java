package commet.swon.file;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service()
public class FilesService {
	@Autowired
	FilesDao dao;
	public FilesDto selectFile(int no) {
		return dao.oneFile(no);//a
	}
	public int insertfile(int no,String path,String fname) {
		return dao.insertFile(no, path, fname);
	}
	public FilesDto downFile(int no) {
		return dao.oneDownFile(no);
	}
}
