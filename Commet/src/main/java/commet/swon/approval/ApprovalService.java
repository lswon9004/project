package commet.swon.approval;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ApprovalService {
	@Autowired
	ApprovalDao dao;
	
	public int Acount(int empno) {
		return dao.Acount(empno);
	}
	public List<ApprovalDto> alist(int empno,int start){
		return dao.alist(empno,start);
	}
	public int getApproval_no(int empno) {
		return dao.getApproval_no(empno);
	}
	public int insertApproval(ApprovalDto dto) {
		return dao.insertApproval(dto);
	}
	public ApprovalDto oneApproval(int approval_no) {
		return dao.oneApproval(approval_no);
	}
	public int updateApproval(String approval_content,int approval_no,int approval_type) {
		return dao.updateApproval(approval_content, approval_no, approval_type);
	}
	public int searchCount(int no, String approval_title, 
						   String approval_status1, Date startDate,
						   Date endDate, int empno) {
		if(approval_status1.equals("요청")) {
			approval_status1 = "";
		}
		return dao.searchCount(no, approval_title, startDate, endDate, empno,approval_status1);
	}
	public List<ApprovalDto> searchApproval(int no, String approval_title, 
			   String approval_status1, Date startDate,
			   Date endDate, int empno, int start){
		if(approval_status1.equals("요청")) {
			approval_status1 = "";
		}
		return dao.searchList(no, approval_title, startDate, endDate, empno, approval_status1, start);
	}
	public int aStatusCount(int empno) {
		return dao.aStatusCount(empno);
	}
	public List<ApprovalDto> aStatus(int empno,int start){
		return dao.approvalStatus(empno,start);
	}
	public int statusSearchCount(String approval_title,Date startDate,Date endDate,int empno,
			 		String approval_status1,int approver1_empno) {
		if(approval_status1.equals("요청")) {
			approval_status1 = "";
		}
		return dao.statusSearchCount(approval_title, startDate, endDate, empno, approval_status1, approver1_empno);
	}
	public List<ApprovalDto> statusSearchList(String approval_title,Date startDate,Date endDate,int empno,
			 		String approval_status1,int approver1_empno, int start){
		if(approval_status1.equals("요청")) {
			approval_status1 = "";
		}
		return dao.statusSearchList(approval_title, startDate, endDate, empno, approval_status1, approver1_empno, start);
	}
	public int updateStatus(String approval_status1, String approval_comm,int no) {
		return dao.updateStatus(approval_status1, approval_comm, no);
	}
}
