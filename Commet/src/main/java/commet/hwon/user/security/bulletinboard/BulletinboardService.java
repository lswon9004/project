package commet.hwon.user.security.bulletinboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;



@Service
public class BulletinboardService {
	
	@Autowired
    private BulletinboardDao boardDao;
	

	//게시글을 저장하는 메서드
	 public void saveBoard(BulletinboardDto boardDto) {
		 	
	        boardDao.save(boardDto.getTitle(),boardDto.getContent(),boardDto.getIid(),boardDto.getPassword());
	    }
	 
    //모든 게시글을 조회하는 메서드
    public List<BulletinboardDto> getAllBoards(int start, int perPage) {
        return boardDao.findAll(start,10);
    }
    
    //게시글 상세보기 메서드
    public BulletinboardDto getBoard(int no) {
        return boardDao.getBoard(no);
    }
    
    //게시글을 업데이트하는 메서드
    public void updateBoard(BulletinboardDto boardDto, MultipartFile file) {
        boardDao.update(boardDto);
    }
    
    //게시글을 삭제하는 메서드
	public void deleteBoard(int no) {
		 // 먼저 참조된 데이터 삭제
       
        boardDao.delete(no);  // 게시글 삭제 메서드
		
	}
   //조회수를 올리는 메서드
	public void increaseReadCount(int no) {
		boardDao.increaseReadCount(no);
		
		
	}
     //게시글 수정완료하는 메서드     
	public void updateBoard(BulletinboardDto boardDto) {
		System.out.println(boardDto.getIid());;
		boardDao.update(boardDto);
		
	}
   //페이지 처리하는 메서드	
   public int count() {
	   return boardDao.count();
   }
   
   //게시글을 검색하는 메서드
   public List<BulletinboardDto> searchBoard(String title, String content, int start) {
       title = "%"+title+"%";
       content = "%"+content+"%";
       return boardDao.search(title,content,start);
   }
	
}
