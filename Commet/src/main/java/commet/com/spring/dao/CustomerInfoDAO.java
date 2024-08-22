package commet.com.spring.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import commet.com.spring.dto.CustomerInfoDTO;

@Mapper
public interface CustomerInfoDAO {
	
	//고객정보추가
	@Insert("insert into CustomerInfo (CustomerName, Email, Zipcode, Address, DateOfBirth, Contact, Status, RegistrationDate, Memo ,Empno) "
			+ "values (#{customerName}, #{email}, #{zipcode}, #{address}, #{dateOfBirth}, #{contact}, #{status}, now(), #{memo} ,#{empno})")
	void saveCustomerInfo(CustomerInfoDTO customerInfo); 
	
	// 고객정보조회
	@Select("select * from CustomerInfo order by CustomerID desc")
	List<CustomerInfoDTO> getAllCustomers(); 
	
	//고객번호 자동지정
	@Select("select * from CustomerInfo where CustomerID = #{id}")
	CustomerInfoDTO getCustomerById(int id); 
	
	// 고객삭제
	@Delete("<script>" + "delete from CustomerInfo where CustomerID in "
			+ "<foreach item='id' collection='array' open='(' separator=',' close=')'>" + "#{id}" + "</foreach>"
			+ "</script>")
	void deleteCustomers(int[] ids); 
	
	//진행상태 목록별 오름차순정렬
	@Select("select * from CustomerInfo where Status = #{status} order by CustomerID desc")
	List<CustomerInfoDTO> getCustomersByStatus(String status);
	
	//전체글 갯수
	@Select("select count(*) from CustomerInfo")
    int count(); 
	
	// 글목록 리스트 최신글이 먼저 보이게 order by CustomerID desc 걸어둠
	@Select("select * from CustomerInfo order by CustomerID desc limit #{start}, #{pageSize}")
	List<CustomerInfoDTO> customerList(@Param("start") int start,@Param("pageSize") int pageSize);
	        
	
	
	 // 고객정보 수정
	@Update("update CustomerInfo set contact=#{contact}, email=#{email},zipcode=#{zipcode} ,address=#{address}, memo=#{memo},status=#{status} " +
            "where customerID=#{customerID}")
    int updateCustomer(CustomerInfoDTO dto);
	
	// 고객명과 연락처 검색
	@Select("<script>" +
	        "select * from CustomerInfo " +
	        "where 1=1 " +
	        "<if test='customerName != null'>and customerName like concat('%', #{customerName}, '%')</if> " +
	        "<if test='contact != null'>AND contact like concat('%', #{contact}, '%')</if> " +
	        "<if test='empno != null'>AND Empno like concat('%', #{empno}, '%')</if> " +
	        "order by CustomerID desc " +
	        "limit #{start}, #{pageSize}" +
	        "</script>")
	List<CustomerInfoDTO> searchCustomersWithPaging( 
	        @Param("customerName") String customerName,
	        @Param("contact") String contact,
	        @Param("empno") Integer empno,
	        @Param("start") int start,
	        @Param("pageSize") int pageSize);
	
	
	 // 검색된 갯수 카운팅
	@Select("<script>" +
	        "select count(*) from CustomerInfo " +
	        "where 1=1 " +
	        "<if test='customerName != null'>and customerName like concat('%', #{customerName}, '%')</if> " +
	        "<if test='contact != null'>and contact like concat('%', #{contact}, '%')</if>" +
	        "<if test='empno != null'>and Empno like concat('%', #{empno}, '%')</if>" +
	        "</script>")
	int countSearchCustomers(
	        @Param("customerName") String customerName,
	        @Param("contact") String contact,
			@Param("empno") Integer empno);
	
	 //진행상태에 따른 검색
	@Select("select * from CustomerInfo where Status = #{status} order by CustomerID desc limit #{start}, #{pageSize}")
	List<CustomerInfoDTO> getCustomersByStatusWithPaging(
	        @Param("status") String status,
	        @Param("start") int start,
	        @Param("pageSize") int pageSize);

	//진행상태에 따른 검색 갯수 카운팅
    @Select("select count(*) from CustomerInfo where status = #{status}")
    int countCustomersByStatus(@Param("status") String status);

	

}