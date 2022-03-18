package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.ServerService;
import com.brainz.ja.vo.ServerVo;

@RestController
@RequestMapping("/server/*")
public class RestServerController {

	@Autowired
	private ServerService serverService;
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(String searchWord) {
		HashMap<String, Object>data = new HashMap<String, Object>();
				
		ArrayList<HashMap<String, Object>>serverList = serverService.getServerList(searchWord);	
		
		data.put("result","success");
		data.put("serverList", serverList);
		
		return data;
	}
	
			
	@RequestMapping("insertServer")
	public HashMap<String, Object> insertServer(ServerVo param) {
		HashMap<String, Object>data = new HashMap<String, Object>();
		System.out.println();
		
		serverService.insertServer(param);

		data.put("result","success");
		
		return data;
	}
		
	@RequestMapping("deleteServer")
	public HashMap<String, Object> deleteServer(HttpServletRequest request) {//row id 배열??
		HashMap<String, Object>data = new HashMap<String, Object>();
		
		String serverNos = request.getParameter("serverNos");

		String[] arr = serverNos.split(",");
		serverService.deleteServer(arr);


		data.put("result","success");
		
		return data;
	}
	
	@RequestMapping("updateServer")
	public HashMap<String, Object> updateServer(ServerVo param) {
		HashMap<String, Object>data = new HashMap<String, Object>();

		
		serverService.updateServer(param);		

		//예외처리 try문??
		//	if 문? {		data.put("result", "error");		data.put("reason", "이런 에러가 발생했습니다");		return data;	}
			
		data.put("result","success");
		
		return data;
	}
	
	@RequestMapping("isExistMac")
	public HashMap<String, Object>isExistMac(String mac){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		boolean result = serverService.isExistMac(mac); 	
		
		data.put("result", result);
		
		return data;
	}
	
	
	
}
