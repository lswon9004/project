package commet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.HiddenHttpMethodFilter;


@SpringBootApplication
public class CommetApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(CommetApplication.class, args);
	}
	@Bean
	 HiddenHttpMethodFilter hiddenHttpMethodFilter() { //PUT 어노테이션 사용 할 수 있게 해주는거
		return new HiddenHttpMethodFilter();
	}
//	   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) { 
//	      return application.sources(CommetApplication.class);
//	   }
	@Override 
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) { 
	return application.sources(CommetApplication.class);
	}
}
