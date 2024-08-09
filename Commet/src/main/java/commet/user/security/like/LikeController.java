package commet.user.security.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LikeController {

    @Autowired
    private LikeService likeService; // LikeService 의존성 주입
    
    // 게시물에 추천을 추가하는 메서드
    @PostMapping("/boards/like")
    @ResponseBody
    public Map<String, Object> likeBoard(@RequestParam("no") int no, @RequestParam("empno") int empno) {
        likeService.like(no, empno); // 추천 추가 서비스 호출
        int likeCount = likeService.likeCount(no); // 게시물의 현재 추천 수 조회
        Map<String, Object> response = new HashMap<>(); // 응답 데이터를 담을 맵 생성
        response.put("likeCount", likeCount); // 추천 수 추가
        response.put("newUrl", "/boards/unlike"); // 추천 취소 URL 추가
        response.put("action", "unlike"); // 현재 액션이 추천 취소임을 표시
        return response; // 응답 맵 반환
    }
    
    // 게시물에 추천을 취소하는 메서드
    @PostMapping("/boards/unlike")
    @ResponseBody
    public Map<String, Object> unlikeBoard(@RequestParam("no") int no, @RequestParam("empno") int empno) {
        likeService.unlike(no, empno); // 추천 취소 서비스 호출
        int likeCount = likeService.likeCount(no); // 게시물의 현재 추천 수 조회
        Map<String, Object> response = new HashMap<>(); // 응답 데이터를 담을 맵 생성
        response.put("likeCount", likeCount); // 추천 수 추가
        response.put("newUrl", "/boards/like"); // 추천 URL 추가
        response.put("action", "like"); // 현재 액션이 추천임을 표시
        return response; // 응답 맵 반환
    }
}