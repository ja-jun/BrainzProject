package com.choongang.bcentral.noti.controller;

import java.util.ArrayList;
import java.util.HashMap;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.noti.service.NotificationService;
import com.choongang.bcentral.noti.vo.FileVo;
import com.choongang.bcentral.noti.vo.NotificationVo;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.user.vo.UserVo;

@RestController
@RequestMapping("/notification/*")
public class RestNotificationController {

	@Autowired
	private NotificationService notiService;
		
	@RequestMapping("getNotificationList")
	public HashMap<String, Object> getNotificationList(PageVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null) {
			param.setSearchWord(param.getSearchWord().replaceAll("\\\\", "\\\\\\\\"));
		}
		
		ArrayList<NotificationVo> notificationList = notiService.getNotificationList(param);
		
		int rows = param.getRows();
		int records = notiService.getNotificationCount(param);
		int total = (int) Math.ceil( (double) records / rows);
		
		data.put("rows", notificationList);
		data.put("records", records);
		data.put("page", param.getPage());
		data.put("total", total);
		
		return data;
	}
	
	@RequestMapping("insertNotification")
	public HashMap<String, Object> insertNotification(NotificationVo param, HttpSession session , MultipartFile [] file){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		List<FileVo> fileVoList = new ArrayList<FileVo>();
		
		
		if(file != null) {
			for(MultipartFile element : file) {
				if(!element.isEmpty()) {

					String fileName = element.getOriginalFilename();
					String ext = fileName.substring(fileName.lastIndexOf('.'));
					int fileSize = (int)element.getSize();
					
					
					String uploadRootFolderName = "C:/uploadFolder/";
					String internalfileName = UUID.randomUUID().toString();
					
					String internalFilePath = uploadRootFolderName + internalfileName + ext;
					
					try {
						element.transferTo(new File(internalFilePath));
					}catch(Exception e) {
						e.printStackTrace();
					}
					
					FileVo fileVo = new FileVo();
					
					fileVo.setFileName(fileName);
					fileVo.setUploadedFileName(internalFilePath);
					fileVo.setFileSize(fileSize);
					fileVo.setContentType(ext);

					fileVoList.add(fileVo);
					
				}
			}
		}	
		
		UserVo uv = (UserVo) session.getAttribute("userInfo");
		
		param.setUser_no(uv.getUser_no());
		notiService.insertNotification(param , fileVoList);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("updateNotification")
	public HashMap<String, Object> updateNotification(NotificationVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		notiService.updateNotification(param);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("deleteNotification")
	public HashMap<String, Object> deleteNotification(@RequestBody ArrayList<String> notificationNos){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		notiService.deleteNotification(notificationNos);
		
		return data;
	}
	
	@RequestMapping("getNotification")
	public HashMap<String, Object> getNotification(int nc_no){
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("notification", notiService.getNotification(nc_no));
		data.put("fileVo", notiService.getFileVo(nc_no));
		
		return data;
	}
	
	@RequestMapping("download")
	public void download(HttpServletResponse response, int file_no) throws Exception{
	
		try {
			FileVo fVo = notiService.getFileInfo(file_no);
			
			String original = fVo.getUploadedFileName();
			
			File file = new File(original);
			response.setHeader("Content-Disposition", "attachment;filename=" + fVo.getFileName());
			
			FileInputStream fiStream = new FileInputStream(original);
			OutputStream out = response.getOutputStream();
			
			int read = 0;
			byte[] buffer = new byte[1024];
			while((read = fiStream.read(buffer)) != -1) {
				out.write(buffer, 0, read);
			}
		} catch (Exception e) {
			throw new Exception("download error");
		}
	}
	
	// 파일 다운로드
	private static final Logger logger = LoggerFactory.getLogger(RestNotificationController.class);
    
    //멀티 파일 업로드 폼으로 이동
    @RequestMapping("/multifileUploadForm")
    public String fileUploadForm2() {
        
        return "multifileUploadForm";
    }
    
    //멀티파일 업로드
    //MultipartHttpServletRequest를 이용한 업로드 파일 접근    
    @RequestMapping(value = "/fileUpload2",produces = "application/json") 
    @ResponseBody
    public HashMap<String, Object> fileUpload2(MultipartHttpServletRequest request) 
                                                                        throws Exception{
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        
        logger.info("제목:"+title);
        logger.info("설명:"+description);
        
        //출력 데이터를 저장하기위한 맵 객체 생성.
        HashMap<String, Object> result = new HashMap<String, Object>();
        
        //업로드한 파일 리스트 얻어오기
        List<MultipartFile> mfList = request.getFiles("file");            
        logger.info("업로드 파일 개수:"+mfList.size()); 
        
        
        List<FileVo> fileList = new ArrayList<FileVo>();        
        
        for(MultipartFile mf:mfList){            
                
            logger.info("파라미터이름:"+mf.getName());
            logger.info("파일명:"+mf.getOriginalFilename());
            logger.info("파일사이즈:"+mf.getSize());
            
            String name = mf.getName(); //필드 이름 얻기
            String fileName = mf.getOriginalFilename(); //파일명 얻기
            String contentType = mf.getContentType(); //컨텐츠 타입 얻기
        
            
            //업로드 파일명을 변경후 저장            
            String uploadedFileName = System.currentTimeMillis() 
                    + UUID.randomUUID().toString()+fileName.substring(fileName.lastIndexOf("."));
        
            String uploadPath = request.getSession().getServletContext().getRealPath("upload");
            logger.info("실제 파일 업로드 경로 : "+uploadPath);
            
            //지정한주소에 파일 저장        
            if(mf.getSize() != 0) {            
                mf.transferTo(new File(uploadPath+"/"+uploadedFileName));            
            }   
    
            String downlink = "fileDownload2?of="+URLEncoder.encode(fileName,"UTF-8")
                                    +"&f="+URLEncoder.encode(uploadedFileName,"UTF-8");
          
            FileVo file = new FileVo(
	                                0,
	                                name, 
	                                fileName, 
	                                uploadedFileName,
	                                (int) mf.getSize(),
	                                contentType,
	                                downlink);                  
            fileList.add(file);            
        }
           
        //응답할 데이터 저장
        result.put("title", title);        
        result.put("description", description);
        result.put("file", fileList);
              
        return result;
    }    
    
    //파일 다운로드 방식2
    @RequestMapping("/fileDownload2")
    public void fileDownload2(HttpServletRequest request, HttpServletResponse response) throws Exception{
        
        //===전달 받은 정보를 가지고 파일객체 생성(S)===//
        
        String f = request.getParameter("f"); //저장된 파일이름
        String of = request.getParameter("of"); //원래 파일이름
        of = new String(of.getBytes("ISO8859_1"),"UTF-8"); 
        //서버설정(server.xml)에 따로 인코딩을 지정하지 않았기 때문에 get방식으로 받은 값에 대해 인코딩 변환
        
        logger.info(f);
        logger.info(of);
        
        //웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기.
        String path = request.getServletContext().getRealPath("upload");
        //String path = request.getSession().getServletContext().getRealPath("upload");
        //String path = WebUtils.getRealPath(request.getServletContext(), "upload");        
        //String path = "D:\\upload\\";        
        
        String fullPath = path+"/"+f;
        
        logger.info("path :"+path);        
        logger.info("fullPath:" + fullPath);
        File downloadFile = new File(fullPath);
        
        //===전달 받은 정보를 가지고 파일객체 생성(E)===//
        
        
        //파일 다운로드를 위해 컨테츠 타입을 application/download 설정
        //response.setContentType("application/download; charset=utf-8");
                
        //파일 사이즈 지정
        response.setContentLength((int)downloadFile.length());
        
        //다운로드 창을 띄우기 위한 헤더 조작
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                                        + new String(of.getBytes(), "ISO8859_1"));
        
        response.setHeader("Content-Transfer-Encoding","binary");
        /*
         * Content-disposition 속성
         * 1) "Content-disposition: attachment" 브라우저 인식 파일확장자를 포함하여 모든 확장자의 파일들에 대해
         *                          , 다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다
         * 2) "Content-disposition: inline" 브라우저 인식 파일확장자를 가진 파일들에 대해서는 
         *                                  웹브라우저 상에서 바로 파일을 열고, 그외의 파일들에 대해서는 
         *                                  "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다.
         */
        
        FileInputStream fin = new FileInputStream(downloadFile);
        ServletOutputStream sout = response.getOutputStream();

        byte[] buf = new byte[1024];
        int size = -1;

        while ((size = fin.read(buf, 0, buf.length)) != -1) {
            sout.write(buf, 0, size);
        }
        fin.close();
        sout.close();
        
    }

}
