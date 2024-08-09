package commet.user.security.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	
	// BoardDao 의존성 주입
    @Autowired
    private BoardDao dao;
    
    // 검색 조건에 맞는 게시물 목록 조회하는 메서드
    public List<BoardDto> searchBoards(String title, String author, String date,int startRow) {
        return dao.searchBoards(title, author, date,startRow); // BoardDao를 이용하여 검색 결과 조회
    }
    
    // 새로운 게시물을 저장하는 메서드
    public int insert(BoardDto dto) {
        return dao.insert(dto); // BoardDao를 이용하여 게시물 저장
    }
    
    // 모든 게시물 목록을 조회하는 메서드
    public List<BoardDto> getAllBoards(int startRow) {
        return dao.bAll(startRow); // BoardDao를 이용하여 모든 게시물 조회
    }
    
    // 특정 게시물을 조회하는 메서드
    public BoardDto getBoard(int no) {
        return dao.bOne(no); // BoardDao를 이용하여 특정 게시물 조회
    }
    
    // 게시물을 수정하는 메서드
    public int updateBoard(BoardDto dto) {
        return dao.update(dto); // BoardDao를 이용하여 게시물 수정
    }
    
    // 게시물을 삭제하는 메서드
    public int deleteBoard(int no) {
        return dao.delete(no); // BoardDao를 이용하여 게시물 삭제
    }
    
    //총 게시물 수를 조회하는 메서드
    public int count() {
        return dao.count(); //BoardDao를 이용하여 총 게시물 수 조회
    }
    
    // 특정 게시물의 조회수를 증가시키는 메서드
    public int readcount(int no) {
        return dao.addReadcount(no); //BoardDao를 이용하여 조회수 증가
    }
    
    // 검색 조건에 맞는 게시물 수를 조회하는 메서드
    public int searchCount(String title, String author,String date) {
    	return dao.searchBoardsCount(title, author, date);
    }
}
