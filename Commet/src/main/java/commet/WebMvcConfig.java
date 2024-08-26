package commet;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import commet.swon.file.LoginIntercepter;


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//
//        LoginIntercepter loginIntercepter = new LoginIntercepter();
//        registry.addInterceptor(loginIntercepter)
//                .addPathPatterns(loginIntercepter.loginEssential)
//                .excludePathPatterns(loginIntercepter.loginInessential);
//    }   
}
