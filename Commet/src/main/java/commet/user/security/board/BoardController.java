package commet.user.security.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import commet.swon.emp.EmpDto;
import commet.swon.emp.EmpService;
import commet.user.security.comment.CommentDto;
import commet.user.security.comment.CommentService;
import commet.user.security.like.LikeService;


@Controller
@SessionAttributes("user")
public class BoardController {
	
	// 세션에 저장될 사용자 정보를 초기화하는 메서드
    @ModelAttribute("user")
    public EmpDto getDto() {
        return new EmpDto();
    }
    @Autowired
	EmpService eService;
    // 서비스 클래스 의존성 주입
    @Autowired
    private BoardService boardService; //BoardService 객체 주입

    @Autowired
    private CommentService commentService; // CommentService 객체 주입

    @Autowired
    private LikeService likeService; // LikeService 객체 주입
    
    // 게시판 목록을 조회하여 페이지에 전달하는 메서드
    @GetMapping("/boards")
    public String list(@RequestParam(name = "p", defaultValue = "1") int page, Model model) {
    	List<EmpDto> getEname = eService.getEname();
    	model.addAttribute("ename", getEname);
        int count = boardService.count(); // 총 게시물 수 조회
        if(count>0) {
        int perPage = 10; // 페이지 당 게시물 수 설정
        int startRow = (page - 1) * perPage; // 조회 시작 인덱스 계산 
        List<BoardDto> boards = boardService.getAllBoards(startRow); // 모든 게시물 목록 조회
        int pageNum = 5;
		int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수 계산
		int begin = (page - 1) / pageNum * pageNum + 1; // 페이지 블록의 시작 번호 계산
		int end = begin + pageNum -1; // 페이지 블록의 끝 번호 계산
		if(end > totalPages) {
			end = totalPages; // 마지막 페이지 번호가 전체 페이지 수를 초과하지 않도록 조정
		}
		model.addAttribute("begin", begin); // 모델에 시작 페이지 번호 추가
		model.addAttribute("end", end); // 모델에 끝 페이지 번호 추가
		model.addAttribute("pageNum", pageNum); // 모델에 페이지 번호 추가
		model.addAttribute("totalPages", totalPages); // 모델에 전체 페이지 수 추가
		model.addAttribute("boardList", boards); // 모델에 게시물 목록 추가
        }
        model.addAttribute("count", count); // 모델에 총 게시물 수 추가
        return "boards/list"; // 게시물 목록 페이지로 이동
    }
    
    // 게시판 검색 기능을 처리하는 메서드
    @GetMapping("/boards/search")
    public String search(@RequestParam(name = "p", defaultValue = "1") int page,
    					 @RequestParam(name = "title", required = false) String title,
                         @RequestParam(name = "author", required = false) String author,
                         @RequestParam(name = "date", required = false) String date,
                         Model model) {
    	
    	List<EmpDto> getEname = eService.getEname();
    	model.addAttribute("ename", getEname);
        int count = boardService.searchCount(title, author, date); // 검색 조건에 맞는 총 게시물 수 조회
        if(count>0) {
        	int perPage = 10; // 페이지 당 게시물 수 설정
            int startRow = (page - 1) * perPage; // 조회 시작 인덱스 계산 	
        List<BoardDto> boardList = boardService.searchBoards(title, author, date,startRow); // 검색 조건에 맞는 게시물 목록 조회
        model.addAttribute("boardList", boardList); // 모델에 검색 결과 추가
        int pageNum = 5;
		int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); // 전체 페이지 수 계산
		int begin = (page - 1) / pageNum * pageNum + 1; // 페이지 블록의 시작 번호 계산
		int end = begin + pageNum -1; // 페이지 블록의 끝 번호 계산
		if(end > totalPages) {
			end = totalPages; // 마지막 페이지 번호가 전체 페이지 수를 초과하지 않도록 조정
		} 
		model.addAttribute("begin", begin); // 모델에 시작 페이지 번호 추가
		model.addAttribute("end", end); // 모델에 끝 페이지 번호 추가
		model.addAttribute("pageNum", pageNum); // 모델에 페이지 번호 추가
		model.addAttribute("totalPages", totalPages); // 모델에 전체 페이지 수 추가
		model.addAttribute("boardList", boardList);  // 모델에 검색 결과 목록 추가
		model.addAttribute("title",title); // 모델에 게시글 제목 추가
		model.addAttribute("author",author); // 모델에 게시글 작성자 추가
		model.addAttribute("date",date); // 모델에 게시글 작성일자 추가
        }
        model.addAttribute("count", count); // 모델에 총 게시물 수 추가

        return "/boards/search";  // 검색 결과를 출력할 페이지로 이동
    }
    
    // 글쓰기 폼 페이지로 이동하는 메서드
    @GetMapping("/boards/write")
    public String writeForm() {
        return "boards/write"; // 글쓰기 폼 페이지로 이동
    }
    
    // 게시물 작성 후 저장하는 메서드
    @PostMapping("/boards/write")
    public String createBoard(@RequestParam("title") String title,
                              @RequestParam("content") String content,
                              @RequestParam("empno") int empno,
                              Model model) {
        BoardDto boardDto = new BoardDto(); // 새로운 게시물 DTO 생성
        boardDto.setTitle(title); // 제목 설정
        boardDto.setContent(content); // 내용 설정
        boardDto.setEmpno(empno); // 작성자 번호 설정
        boardDto.setReadcount(0); // 초기 조회수는 0으로 설정

        int result = boardService.insert(boardDto); // 게시물 저장
        if (result > 0) {
            return "redirect:/boards"; // 저장 성공 시 게시물 목록 페이지로 리다이렉트
        } else {
            model.addAttribute("errorMessage", "게시물 저장에 실패했습니다."); // 저장 실패 시 에러 메시지 추가
            return "boards/write"; // 글쓰기 폼 페이지로 이동
        }
    }

    // 특정 게시물을 조회하여 상세 페이지로 이동하는 메서드
    @GetMapping("/boards/{no}")
    public String viewBoard(@PathVariable("no") int no, Model model, @ModelAttribute("user") EmpDto dto) {
        BoardDto board = boardService.getBoard(no);
        List<EmpDto> getEname = eService.getEname();
    	model.addAttribute("ename", getEname);
        if (board != null) { 
            boardService.readcount(no); // 조회수 증가
            List<CommentDto> clist = commentService.getCommentsByBoardNo(no); // 해당 게시물의 댓글 목록 조회
            int likeCount = likeService.likeCount(no); // 좋아요 수 조회
            boolean hasLiked = likeService.hasLiked(no, dto.getEmpno()); // 사용자가 좋아요를 눌렀는지 확인
            model.addAttribute("clist", clist); // 모델에 댓글 목록 추가
            model.addAttribute("likeCount", likeCount); // 모델에 추천 수 추가
            model.addAttribute("board", board); // 모델에 게시물 정보 추가
            model.addAttribute("hasLiked", hasLiked); // 모델에 추천 상태 추가
            return "boards/view"; // 게시물 상세 페이지로 이동
        } else {
            return "redirect:/boards"; // 게시물이 없을 경우 게시물 목록 페이지로 리다이렉트
        }
    }
    
    // 게시물 수정 폼 페이지로 이동하는 메서드
    @GetMapping("/boards/edit/{no}")
    public String editForm(@PathVariable("no") int no, Model model) {
    	List<EmpDto> getEname = eService.getEname();
    	model.addAttribute("ename", getEname);
        BoardDto board = boardService.getBoard(no); // 게시물 번호에 따른 게시물 조회
        model.addAttribute("board", board); // 모델에 게시물 정보 추가
        return "boards/edit"; // 게시물 수정 폼 페이지로 이동
    }
    
    // 게시물 수정 후 저장하는 메서드
    @PostMapping("/boards/edit/{no}")
    public String updateBoard(@PathVariable("no") int no,
                              @RequestParam("title") String title,
                              @RequestParam("content") String content,
                              Model model) {
        BoardDto boardDto = new BoardDto(); // 새로운 게시물 DTO 생성
        boardDto.setNo(no); // 게시물 번호 설정
        boardDto.setTitle(title); // 제목 설정
        boardDto.setContent(content); // 내용 설정
        int result = boardService.updateBoard(boardDto); // 게시물 수정
        if (result > 0) {
            return "redirect:/boards/" + no; // 수정 성공 시 해당 게시물의 상세 페이지로 리다이렉트
        } else {
            model.addAttribute("errorMessage", "게시물 수정에 실패했습니다."); // 수정 실패 시 에러 메시지 추가
            return "boards/edit"; // 수정 폼 페이지로 이동
        }
    }
    
    // 게시물 삭제를 처리하는 메서드
    @PostMapping("/boards/delete/{no}")
    public String deleteBoard(@PathVariable("no") int no) {
        boardService.deleteBoard(no); // 게시물 삭제
        return "redirect:/boards"; // 게시물 목록 페이지로 리다이렉트
    }
}
