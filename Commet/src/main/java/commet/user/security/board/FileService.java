package commet.user.security.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileService {

    @Autowired
    private FileDao fileDao;

    public int insertFile(FileDto fileDto) {
        return fileDao.insert(fileDto);
    }

    public List<FileDto> getFilesByBoardNo(String boardName, int boardNo) {
        return fileDao.getFilesByBoardNo(boardName, boardNo);
    }
}
