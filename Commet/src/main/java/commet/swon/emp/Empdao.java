package commet.swon.emp;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface Empdao {
	@Select("SELECT e.* ,a.check_in as 'check_in',a.check_out as 'check_out' "
			+ "FROM emp e "
			+ "LEFT OUTER JOIN attendance_management a ON e.empno = a.empno AND (a.date = CURRENT_DATE()) "
			+ "WHERE e.empno = #{empno}")
	EmpDto login(int empno);
	@Select("select authority from position where position = #{position}")
	int getRight(String position);
	@Update("update emp set loginCount = #{loginCount} where empno = #{empno}")
	int loginCount(@Param("loginCount") int loginCount, @Param("empno")int empno);
	@Select("select loginCount from emp where empno = #{empno}")
	int getLoginCount(int empno);
	@Select("select empno from emp natural join position where authority = 3 or (deptno =#{deptno} and authority>1)")
	List<Integer> getEmpnolist(int deptno); 
	@Select("select email from emp where empno = #{empno}")
	String emailCheck(int empno);
	@Update("update emp set password = 1234 where empno = #{empno}")
	int updatepw(int empno);
	@Select("select deptno from emp where empno = #{empno}")
	int getDeptno(int empno);
}
