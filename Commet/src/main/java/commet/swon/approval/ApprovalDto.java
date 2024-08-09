package commet.swon.approval;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalDto {
	int approval_no;
	int empno;
	int deptno;
	int approval_type;
	String approval_title;
	String approval_content;
	Date created_date;
	int approver1_empno;
	String approval_status1;
	String final_approval;
	String approval_comm;
}
