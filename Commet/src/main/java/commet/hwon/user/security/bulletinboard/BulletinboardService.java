package commet.hwon.user.security.bulletinboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;



@Service
public class BulletinboardService {
	
	@Autowired
    private BulletinboardDao boardDao;
	
	//새 게시글을 DB에 저장함 
	 public void saveBoard(BulletinboardDto boardDto) {
	    boardDao.save(boardDto.getTitle(),boardDto.getContent(),boardDto.getIid(),boardDto.getPassword());
	}
	 
    //모든 게시글을 조회, start와 perpage 페이지네이션
    public List<BulletinboardDto> getAllBoards(int start) {
        return boardDao.findAll(start);
    }
    
    //특정 번호(no)의 게시글을 조회
    public BulletinboardDto getBoard(int no) {
        return boardDao.getBoard(no);
    }
    
    //특정 게시글을 업데이트
    public int update(BulletinboardDto boardDto) {
        return boardDao.update(boardDto);
    }
    
    //특정 번호(no)와 비밀번호를 가진 게시글을 삭제
	public int deleteBoard(int no, String password) {
        return boardDao.deleteboard(no, password); 	
	}
	
   //특정 번호(no)의 게시글의 조회수를 증가
	public void increaseReadCount(int no) {
		boardDao.increaseReadCount(no);		
	}
	
     //게시글을 수정하고 수정이 완료되었음을 알림     
	public void updateBoard(BulletinboardDto boardDto) {
		System.out.println(boardDto.getIid());;
		boardDao.update(boardDto);	
	}
	
   //게시글의 총 수를 반환	
   public int count() {
	   return boardDao.count();
   }
   
   //제목과 내용으로 게시글을 검색하고, 검색 결과를 페이지네이션처리
   public List<BulletinboardDto> searchBoard(String title, int start) {
       title = "%"+title+"%";
       return boardDao.search(title,start);
   }
   public int searchCount(String title) {
       title = "%"+title+"%";
	   return boardDao.searchcount(title);
   }
	
}
