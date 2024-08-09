package commet.swon.approval;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface ApprovalDao {
	@Select("select count(*) from Approval where empno = #{empno}")
	int Acount(int empno);
	@Select("select count(*) from Approval where  = #{empno}")
	int AScount(int empno);
	@Select("select * from Approval where empno = #{empno} order by created_date desc limit #{start} , 10")
	List<ApprovalDto> alist(@Param("empno") int empno,@Param("start") int start);
	
	@Select({
	    "<script>",
	    "select * from Approval",
	    "<where>",
	        "<if test=\"approval_no != 0\">",
	            "approval_no = #{approval_no}",
	        "</if>",
	        "<if test=\"approval_title != null and approval_title != ''\">",
	            "and approval_title like #{approval_title}",
	        "</if>",
	        "<if test=\"startDate != null and  endDate != null \">",
	            "and created_date between #{startDate} and #{endDate}",
	        "</if>",
	        "<if test=\"approval_status1 != null and approval_status1 != ''\">",
        	"and approval_status1 = #{approval_status1}",
        "</if>",
	        "and empno = #{empno} order by created_date desc limit #{start} , 10",
	    "</where>",
	    "</script>"
	})
	 List<ApprovalDto> searchList(@Param("approval_no")int approval_no,
			 					  @Param("approval_title")String approval_title,
			 					 @Param("startDate")Date startDate,
			 					 @Param("endDate")Date endDate,
			 					  @Param("empno")int empno,
			 					  @Param("approval_status1")String approval_status1,
			 					  @Param("start")int start);
	@Select({
	    "<script>",
	    "select count(*) from Approval",
	    "<where>",
	        "<if test=\"approval_no != 0\">",
	            "approval_no = #{approval_no}",
	        "</if>",
	        "<if test=\"approval_title != null and approval_title != ''\">",
	            "and approval_title like #{approval_title}",
	        "</if>",
	        "<if test=\"startDate != null and endDate != null \">",
	            "and created_date between #{startDate} and #{endDate}",
	        "</if>",
	        "<if test=\"approval_status1 != null and approval_status1 != ''\">",
            	"and approval_status1 = #{approval_status1}",
            "</if>",
	        "and empno = #{empno}",
	    "</where>",
	    "</script>"
	})
	int searchCount(@Param("approval_no")int approval_no,
			 		@Param("approval_title")String approval_title,
			 		@Param("startDate")Date startDate,
			 		@Param("endDate")Date endDate,
			 		@Param("empno")int empno,
			 		@Param("approval_status1")String approval_status1);
	
	@Select("select ifnull((max(approval_no)+1),1) from approval where empno = #{empno}")
	int getApproval_no(int empno);
	@Insert("insert into approval(empno,deptno,approval_title,approval_content,approver1_empno,approval_type) "
			+ "values(#{empno},#{deptno},#{approval_title},#{approval_content},#{approver1_empno},#{approval_type})")
	int insertApproval(ApprovalDto dto);
	@Select("select * from approval where approval_no = #{approval_no}")
	ApprovalDto oneApproval(int approval_no);
	@Update("update approval set approval_content = #{approval_content}, approval_type = #{approval_type} where approval_no = #{approval_no}")
	int updateApproval(@Param("approval_content")String approval_content,@Param("approval_no")int approval_no,@Param("approval_type")int approval_type );
	@Select("select * from approval where approver1_empno = #{empno} order by created_date desc limit #{start} , 10")
	List<ApprovalDto> approvalStatus(@Param("empno")int empno,@Param("start")int start);
	@Select("select count(*) from approval where approver1_empno = #{empno}")
	int aStatusCount(int empno);
	@Select({
	    "<script>",
	    "select count(*) from Approval",
	    "<where>",
	        "<if test=\"empno != 0\">",
	            "empno = #{empno}",
	        "</if>",
	        "<if test=\"approval_title != null and approval_title != ''\">",
	            "and approval_title like #{approval_title}",
	        "</if>",
	        "<if test=\"startDate != null and endDate != null \">",
	            "and created_date between #{startDate} and #{endDate}",
	        "</if>",
	        "<if test=\"approval_status1 != null and approval_status1 != ''\">",
            	"and approval_status1 = #{approval_status1}",
            "</if>",
	        "and approver1_empno = #{approver1_empno}",
	    "</where>",
	    "</script>"
	})
	int statusSearchCount(@Param("approval_title")String approval_title,
			 		@Param("startDate")Date startDate,
			 		@Param("endDate")Date endDate,
			 		@Param("empno")int empno,
			 		@Param("approval_status1")String approval_status1,
			 		@Param("approver1_empno")int approver1_empno);
	@Select({
	    "<script>",
	    "select * from Approval",
	    "<where>",
	        "<if test=\"empno != 0\">",
	            "empno = #{empno}",
	        "</if>",
	        "<if test=\"approval_title != null and approval_title != ''\">",
	            "and approval_title like #{approval_title}",
	        "</if>",
	        "<if test=\"startDate != null and endDate != null \">",
	            "and created_date between #{startDate} and #{endDate}",
	        "</if>",
	        "<if test=\"approval_status1 != null and approval_status1 != ''\">",
            	"and approval_status1 = #{approval_status1}",
            "</if>",
	        "and approver1_empno = #{approver1_empno} order by created_date desc limit #{start} , 10",
	    "</where>",
	    "</script>"
	})
	List<ApprovalDto> statusSearchList(@Param("approval_title")String approval_title,
			 		@Param("startDate")Date startDate,
			 		@Param("endDate")Date endDate,
			 		@Param("empno")int empno,
			 		@Param("approval_status1")String approval_status1,
			 		@Param("approver1_empno")int approver1_empno,
			 		@Param("start")int start);
	@Update("update approval set approval_status1 = #{approval_status1}, approval_comm =#{approval_comm} where approval_no = #{approval_no}")
	int updateStatus(@Param("approval_status1")String approval_status1, @Param("approval_comm")String approval_comm,@Param("approval_no")int approval_no);
}
