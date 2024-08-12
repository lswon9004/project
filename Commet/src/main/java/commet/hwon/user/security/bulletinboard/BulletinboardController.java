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
	private ReplyService rService;
	
	@Autowired
	private LikecountService lService;
	
	@Autowired
	private HatecountService hService;
	
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
    	int count = boardService.count();
    	if (count>0) {
    		int perPage = 10; // 한 페이지에 보일 글의 갯수
    		int startRow = (page - 1) * perPage;
    	List<BulletinboardDto> boards = boardService.getAllBoards(startRow);
        model.addAttribute("boardList", boards);

        int pageNum = 5;
        int totalPages = (int) Math.ceil((double) count / perPage); // 전체 페이지 수
		
		int begin = (page - 1) / pageNum * pageNum + 1;
		int end = Math.min(begin + pageNum - 1, totalPages);
		
		 model.addAttribute("begin", begin);
		 model.addAttribute("end", end);
		 model.addAttribute("totalPages", totalPages);
        }
    	
    	model.addAttribute("count", count);
        return "/bullboard/list"; // refcontroller의 list로 리다이렉트
    }
    
    // 게시글 상세보기(조회수 올라감)
    @GetMapping("/content/{no}")
    public String getBoard(@PathVariable("no") int no, Model model) {
        boardService.increaseReadCount(no);
        BulletinboardDto board = boardService.getBoard(no);
        model.addAttribute("board", board);
        
        List<ReplyDto> replies = rService.getReplies(no); // 댓글 목록을 가져옵니다.
        model.addAttribute("replies", replies); // 댓글 목록을 모델에 추가합니다.
        
        List<Map<String, Integer>> likeList = lService.likeList(); 
    	List<Map<String, Integer>> hateList = hService.hateList();
    	model.addAttribute("likeList", likeList);
    	model.addAttribute("hateList", hateList);
    	
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
    public String deleteBoard(@PathVariable("no") int no) {
    	boardService.deleteBoard(no);
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
        
  
