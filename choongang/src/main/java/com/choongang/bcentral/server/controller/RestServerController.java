package com.choongang.bcentral.server.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.server.service.ServerService;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.choongang.bcentral.user.vo.UserVo;

// [서버관리] 비동기 Controller
@RestController
@RequestMapping("/server/*")
public class RestServerController {
	
	@Autowired
	private ServerService serverService;
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(PageVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null){
			String searchWord = param.getSearchWord();
			System.out.println(searchWord);
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\");
			param.setSearchWord(searchWord);
			System.out.println(searchWord);
		}
		
		ArrayList<ServerVo> serverList = serverService.getServerList(param);
		
		int rows = param.getRows();
		int records = serverService.getServerCount(param);
		int total = (int) Math.ceil((double)records / rows);
		
		param.setTotal(total);
		param.setRecords(records);
		
		data.put("rows", serverList); // 데이터
		data.put("records", records); // 데이터의 전체 개수 (viewrecords 에 사용됨)
		data.put("page", param.getPage()); // 현재 페이지
		data.put("total", total); // 총 페이지
		
		return data;
	}
	
	@RequestMapping("insertServer")
	public HashMap<String, Object> insertServer(ServerVo param, HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		UserVo userInfo = (UserVo) session.getAttribute("userInfo");
		param.setUser_no(userInfo.getUser_no());
		
		serverService.insertServer(param);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("deleteServer")
	public HashMap<String, Object> deleteServer(ArrayList<String> param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		serverService.deleteServer(param);
		
		return data;
	}
	
	@RequestMapping("getServer")
	public HashMap<String, Object> getServer(int server_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ServerVo server = serverService.getServer(server_no);
		
		data.put("server", server);
		
		return data;
	}
	
	@RequestMapping("updateServer")
	public HashMap<String, Object> updateServer(ServerVo parma){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		serverService.updateServer(parma);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("isExistMac")
	public HashMap<String, Object> isExistMac(String mac){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("result", serverService.isExistMac(mac));
		
		return data;
	}
}
