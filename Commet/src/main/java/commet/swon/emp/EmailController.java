package commet.swon.emp;

import java.security.SecureRandom;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;



@RestController
@Controller
public class EmailController {

	@Autowired
	private EmailService emailService;

	@RequestMapping("/send")
	public String[] sendMail(@RequestParam("email") String emailAddress) throws Exception {

		EmailVo email = new EmailVo();

		String receiver = emailAddress; // Receiver.

		String subject = "Email 제목";

		String number = createNewPassword();
		
		String content = "인증 번호는 "+number+"입니다.";
		
		email.setReceiver(receiver);
		email.setSubject(subject);
		email.setContent(content);

		Boolean result = emailService.sendMail(email);

		return new String[] {number, result.toString()};

	}
	
	
	private String createNewPassword() {
	      char[] chars = new char[] {
	            '0','1','2','3','4','5','6','7','8','9',
	            'a','b','c','d','e','f','g','h','i','j',
	            'k','l','m','n','o','p','q','r','s','t',
	            'u','v','w','x','y','z'   };
	      
	      StringBuffer stringBuffer = new StringBuffer();
	      SecureRandom secureRandom = new SecureRandom();
	      secureRandom.setSeed(new Date().getTime());

	      int index = 0;
	      int length = chars.length;
	      for(int i = 0; i < 8; i++) {
	         index = secureRandom.nextInt(length);
	         
	         if(index % 2 == 0) {
	            stringBuffer.append(String.valueOf(chars[index]).toUpperCase());
	         }else {
	            stringBuffer.append(String.valueOf(chars[index]).toLowerCase());
	         }
	      }
	      
	      System.out.println("newPASSWORD : " + stringBuffer.toString());
	      
	      return stringBuffer.toString();
	   }

}

