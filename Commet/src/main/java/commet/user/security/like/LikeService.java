package commet.user.security.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeService {

    @Autowired
    private LikeDao likeDao; // LikeDao 의존성 주입
    
    // 게시물을 추천하는 메서드
    public void like(int boardNo, int empno) {
        likeDao.like(boardNo, empno); 
    } // LikeDao를 사용하여 추천을 데이터베이스에 저장

    // 게시물의 추천을 취소하는 메서드
    public void unlike(int boardNo, int empno) {
        likeDao.unlike(boardNo, empno);
    } // LikeDao를 사용하여 추천을 데이터베이스에서 삭제

    // 게시물의 총 추천 수를 조회하는 메서드
    public int likeCount(int boardNo) {
        return likeDao.likeCount(boardNo);
    } // LikeDao를 사용하여 특정 게시물의 총 추천 수를 조회

    // 사용자가 특정 게시물에 추천을 했는지 여부를 확인하는 메서드
    public boolean hasLiked(int boardNo, int empno) {
        return likeDao.hasLiked(boardNo, empno);
    } // LikeDao를 사용하여 사용자가 특정 게시물에 추천을 했는지 여부를 확인
}
