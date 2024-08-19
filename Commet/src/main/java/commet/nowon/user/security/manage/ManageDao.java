package commet.nowon.user.security.manage;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;





@Mapper
public interface ManageDao {
    @Insert("insert into emp(ename, empno, deptno, jop, position, imgPath, phone, email, address, detailAddr, birthday, hiredate, sal, memo) values(#{ename}, #{empno}, #{deptno}, #{jop}, #{position}, #{imgPath}, #{phone}, #{email}, #{address}, #{detailAddr}, #{birthday}, #{hiredate}, #{sal}, #{memo})")
    int insertEmp(ManageDto dto); // DB에 사원 정보 저장 메서드

    @Select("select count(*) from emp")
    int count(); // 전체 글 갯수

    @Select("select e.*, d.deptname from emp e left join dept d on e.deptno = d.deptno order by e.empno desc limit #{start}, #{count}")
    List<ManageDto> managemain(Map<String,Object> m); // 글 목록 리스트 최신 글이 먼저 보이게 order by empno desc 걸어둠

    @Select("select e.*, d.deptname, p.authority from emp e left join dept d on e.deptno = d.deptno left join position p on e.position = p.position where e.empno = #{id}")
    ManageDto getempByID(int id); // 사원 번호

    @Update("update emp set deptno=#{deptno}, ename=#{ename}, jop=#{jop}, position=#{position}, phone=#{phone}, email=#{email}, address=#{address}, detailAddr=#{detailAddr}, memo=#{memo}, sal=#{sal}, imgPath=#{imgPath} where empno=#{empno}")
    int updateEmp(ManageDto dto); // 사원 정보 수정 / 부서이름이 deptno를 dept 에서 join해서 이름을 가져와서 수정 버튼 누를시 있는 데이터를 통제로 보냄 그래서 안넣어둠

    @Select({
        "<script>",
        "SELECT e.*, d.deptname FROM emp e",
        "LEFT JOIN dept d ON e.deptno = d.deptno",
        "WHERE e.empno IN ",
        "<foreach item='id' collection='array' open='(' separator=',' close=')'>",
        "#{id}",
        "</foreach>",
        "</script>"
    })
    List<ManageDto> getEmpsByIds(int[] empnos); // 고객 정보 조회

   @Select({
	   "<script>",
	   "select * from emp natural join dept",
	   "<where>",
	   "<if test=\"empno != null and empno != 0\">",
	   "empno = #{empno}",
	   "</if>",
	   "<if test=\"ename != null and empno != ''\">",
	   "<if test=\"empno != null and empno != 0\">AND</if>",
	   "ename LIKE CONCAT('%', #{ename}, '%')",
	   "</if>",
	   "</where>",
	   "</script>"
   })
    List<ManageDto> searchEmps(@Param("empno") Integer empno, @Param("ename") String ename);
    

    @Delete("<script>" + 
            "delete from emp where empno in " +
            "<foreach item='id' collection='array' open='(' separator=',' close=')'>" + 
            "#{id}" + 
            "</foreach>" + 
            "</script>")
    void deleteEmps(int[] empnos); // 고객 삭제
    
    
    
    
}