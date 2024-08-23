package commet.swon.img;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import commet.swon.file.FilesDto;
import commet.swon.file.FilesService;
import jakarta.servlet.http.HttpServletResponse;


@Controller
public class ImgController {
	@Autowired
	FilesService service;
	@PostMapping("/img/upload")
	@ResponseBody
	public Map<String, Object> imgUloader(@RequestParam("upload")MultipartFile img){
		return imgUload(img);
	}
	Map<String, Object> imgUload(MultipartFile img){
		String newFileName = makeFileName(img.getOriginalFilename());
        File newFile = null;
        String path = null;
        try {
            path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
            newFile = new File(path, newFileName);
            img.transferTo(newFile);
        } catch (IOException | IllegalStateException e) {
            e.printStackTrace();
        }
        if (newFile == null) {
        	return null;
        }
        Map<String, Object> json = new HashMap<String, Object>();
        json.put("uploaded", 1);
        json.put("fileName", newFileName);
        json.put("url", "/upload" + "/" + newFileName);
        return json;
	}
	 @GetMapping("/fileDownload/{no}")
	    public void fileDownload(@PathVariable("no") int no,
	                             HttpServletResponse response) throws IOException {
		 FilesDto dto = service.downFile(no);
		 String path = null;
	        try {
	            path = ResourceUtils.getFile("classpath:static/upload/document/").toPath().toString();
	        } catch (IOException | IllegalStateException e) {
	            e.printStackTrace();
	        }
	        File f = new File(path, dto.getPath());
	        // file 다운로드 설정
	        response.setContentType("application/download");
	        response.setContentLength((int)f.length());
	        response.setHeader("Content-disposition", "attachment;filename=\"" + dto.getPath() + "\"");
	        response.setCharacterEncoding("CP949"); // 인코딩 설정 추가
	        // response 객체를 통해서 서버로부터 파일 다운로드
	        OutputStream os = response.getOutputStream();
	        // 파일 입력 객체 생성
	        FileInputStream fis = new FileInputStream(f);
	        FileCopyUtils.copy(fis, os);
	        fis.close();
	        os.close();
	    }
	
	
	
	public static String makeFileName(String origName) {
        long currentTime = System.currentTimeMillis();
        Random random = new Random();
        int r = random.nextInt(50);
        int index = origName.lastIndexOf(".");
        String ext = origName.substring(index + 1);
        return currentTime + "_" + r + "." + ext;
    }
}
