package commet.hwon.user.security.bulletinboard;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import commet.hwon.user.security.Reply.ReplyDto;
import commet.hwon.user.security.Reply.ReplyService;
import commet.hwon.user.security.hatecount.HatecountService;
import commet.hwon.user.security.likecount.LikecountService;



@Controller
public class BulletinboardController {
	
	@Autowired
    private BulletinboardService boardService;
	
	@Autowired
	private ReplyService replyservice;
	
	@Autowired
	private LikecountService likeService;
	
	@Autowired
	private HatecountService hateService;
	
    // 게시글 작성 폼
    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("board", new BulletinboardDto());
        return "/bullboard/write";
    }
    
    // 게시글 저장
   @PostMapping("/save")
   public String saveBoard(@ModelAttribute("board") BulletinboardDto boardDto, 
           @RequestParam(name = "file",required = false) MultipartFile file) {
            boardService.saveBoard(boardDto);
            return "redirect:/bullboard";
   }
   
   // 글쓰기 닫기
   @GetMapping("/close")
   public String closeWrite() {
       return "redirect:/bullboard";
   }
 
    // 게시글 목록
    @GetMapping("/bullboard")
    public String board(@RequestParam(name="p", defaultValue = "1") int page, Model model) {
    	int count = boardService.count(); //전체 게시글 수
    	int perPage = 10; // 한페이지에 보일 글의 갯수
    	int pageNum = 5; // 페이지 네비게이션에서 보여줄 페이지 번호 개수
    	
    	//전체 페이지 수 계산
    	int totalPages = (int) Math.ceil((double) count / perPage);
    	
    	//현재 페이지가 범위를 초과하지 않도록 조정
    	if(page > totalPages) {
    		page = totalPages;
    	}
    	
    	//시작 행과 끝 행 계산
    	int startRow = (page - 1) * perPage;
    	
    	//게시글 목록 가져오기
    	List<BulletinboardDto> boards = boardService.getAllBoards(startRow, perPage);
    	model.addAttribute("boardList", boards);
    	 List<Map<String, Integer>> likeCountList = likeService.likeCountList();
    	 List<Map<String, Integer>> hateCountList = hateService.hateCountList();
    	model.addAttribute("likeCountList", likeCountList);
    	model.addAttribute("hateCountList", hateCountList);
    	
    	//페이지 네비게이션 시작 및 끝 번호 계산
    	int begin = (page - 1) / pageNum * pageNum + 1;
    	int end = Math.min(begin + pageNum - 1, totalPages);
    	
    	//모델에 필요한 속성 추가
    	model.addAttribute("count", count);
    	model.addAttribute("begin", begin);
    	model.addAttribute("end", end);
    	model.addAttribute("totalPages", totalPages);
    	model.addAttribute("currentPage", page);
    	
    	return "/bullboard/list"; //jsp 페이지로 리턴
        
    }
    
    // 게시글 상세보기(조회수 올라감)
    @GetMapping("/content/{no}")
    public String getBoard(@PathVariable("no") int no, Model model) {
        boardService.increaseReadCount(no);
        BulletinboardDto board = boardService.getBoard(no);
        model.addAttribute("board", board);
        
        List<ReplyDto> replies = replyservice.selectreplies(no); // 댓글 목록을 가져옵니다.
        model.addAttribute("replies", replies); // 댓글 목록을 모델에 추가합니다.
        
        // 좋아요 수를 가져옵니다.
        int likeCount = likeService.likeCount(no);
        model.addAttribute("likeCount", likeCount);
        
       int hateCount = hateService.hateCount(no);
        model.addAttribute("hateCount", hateCount);
    	
        return "/bullboard/content";
    }
    
    // 게시글 수정 폼
    @GetMapping("/update/{no}")
    public String showUpdateForm(@PathVariable("no") int no, Model model) {
        BulletinboardDto board = boardService.getBoard(no);
        model.addAttribute("board", board);
        return "/bullboard/update";
    }
    
    // 게시글을 업데이트 메서드
    @PostMapping("/bullboard/update")
    public String updateBoard(@ModelAttribute("board") BulletinboardDto boardDto) {
        boardService.updateBoard(boardDto);
        return "redirect:/bullboard";
    }
    
    // 게시글을 삭제
    @PostMapping("/delete/{no}")
    public String deleteBoard(@PathVariable("no") int no, @RequestParam("password")String password) {
    	boardService.deleteBoard(no, password);
        return "redirect:/bullboard";
    }
    
    // 게시글을 검색하는 요청을 처리하는 메서드
    @GetMapping("/search")
    public String searchBoard(@RequestParam(name="title", defaultValue = "") String title,
                              @RequestParam(name="content", defaultValue = "") String content,
                              @RequestParam(name="p", defaultValue = "1") int page,
                              Model model) {
        int startRow = (page - 1) * 10;
        List<BulletinboardDto> searchResults = boardService.searchBoard(title, content, startRow);
        model.addAttribute("boardList", searchResults);
        return "/bullboard/search";
    }
    
    
 
}
        
  
