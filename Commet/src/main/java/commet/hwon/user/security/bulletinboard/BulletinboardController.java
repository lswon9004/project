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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

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
	
	
    //사용자가 새로운 게시글을 작성할 수 있는 폼을 보여줌
    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("board", new BulletinboardDto());
        return "/bullboard/write";
    }
    
    //새 게시글을 데이터베이스에 저장함
   @PostMapping("/save")
   public String saveBoard(@ModelAttribute("board") BulletinboardDto boardDto, 
      @RequestParam(name = "file",required = false) MultipartFile file) {
      boardService.saveBoard(boardDto);
      return "redirect:/bullboard";
   }
   
   //글쓰기 폼을 닫고 게시글 목록 페이지로 리디렉션함
   @GetMapping("/close")
   public String closeWrite() {
       return "redirect:/bullboard";
   }
 
    // 게시글 목록을 보여줌
    @GetMapping("/bullboard")
    public String board(@RequestParam(name="p", defaultValue = "1") int page, Model model) {

    	int count = boardService.count(); //전체 게시글 수
    	if(count!=0) {
    		int perPage = 10; // 한페이지에 보일 글의 갯수
        	int pageNum = 5; // 페이지 네비게이션에서 보여줄 페이지 번호 개수
        	int startRow = (page - 1) * perPage;
        	model.addAttribute("start", startRow);
     	//게시글 목록 가져오기
     	List<BulletinboardDto> boards = boardService.getAllBoards(startRow);
    	model.addAttribute("boardList", boards);
		int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수	
		int begin = (page - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum -1;
		if(end > totalPages) {
			end = totalPages;
		}
    	//현재 페이지가 범위를 초과하지 않도록 조정
    	
    	List<Map<String, Integer>> likeCountList = likeService.likeCountList();
   	 List<Map<String, Integer>> hateCountList = hateService.hateCountList();
   	model.addAttribute("likeCountList", likeCountList);
   	model.addAttribute("hateCountList", hateCountList);
   	
   	//페이지 네비게이션 시작 및 끝 번호 계산
   	
   	//모델에 필요한 속성 추가
   	model.addAttribute("count", count);
   	model.addAttribute("begin", begin);
   	model.addAttribute("end", end);
   	model.addAttribute("totalPages", totalPages);
   	model.addAttribute("currentPage", page);
   	
    	}
    	//시작 행과 끝 행 계산
    	
    	 
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
    
    //게시글의 비밀번호 확인하는 메서드, 맞을 경우 수정폼, 틀릴 경우 홈 리다이렉션
    @GetMapping("/pwCheck/{no}")
    @ResponseBody
    public String pwCheck(@PathVariable("no") int no,@RequestParam("pw")String pw, Model model) {
        BulletinboardDto board = boardService.getBoard(no);
        String result =null;
        Gson gson = new Gson();
        if(board.getPassword().equals(pw)) {
        	result = "/update/"+no;
        }else {
        	result = "/";
        }
        
        return gson.toJson(result);
    }
    
    // 게시글을 업데이트 메서드
    @PostMapping("/bullboard/update")
    public String updateBoard(BulletinboardDto boardDto) {
    	System.out.println("ada");
           boardService.update(boardDto);
    	   return "redirect:/content/" + boardDto.getNo();
      
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
                              @RequestParam(name="p", defaultValue = "1") int page,
                              Model model) {
    	System.out.println(title);
    	int scount = boardService.searchCount(title);
    	if(scount>0) {
		int perPage = 10;
		List<Map<String, Integer>> likeCountList = likeService.likeCountList();
   	 	List<Map<String, Integer>> hateCountList = hateService.hateCountList();
   	 	model.addAttribute("likeCountList", likeCountList);
   	 	model.addAttribute("hateCountList", hateCountList);
    
		int startRow = (page - 1) * perPage;
        List<BulletinboardDto> searchResults = boardService.searchBoard(title, startRow);
        model.addAttribute("boardList", searchResults);
        int pageNum = 5;
        int totalPages = scount / perPage + (scount % perPage > 0 ? 1 : 0);
        int begin = (page - 1) / pageNum * pageNum + 1;
        int end = begin + pageNum - 1;
        if (end > totalPages) {
            end = totalPages;
        }
        model.addAttribute("begin", begin);
        model.addAttribute("end", end);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPages", totalPages);
    	}
    	model.addAttribute("title", title);
    	model.addAttribute("count", scount);
    	System.out.println(scount);
        return "/bullboard/search";
    }
    
}
        
  
