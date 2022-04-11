package com.choongang.bcentral.server.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.server.service.ServerService;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.choongang.bcentral.user.vo.UserVo;
import com.google.gson.Gson;

// [서버관리] 비동기 Controller
@RestController
@RequestMapping("/server/*")
public class RestServerController {

	String regExp = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$";
	String regIp4 = "^(([1-9]?\\d|1\\d{2}|2([0-4]\\d)|25[0-5])\\.){3}([1-9]?\\d|1\\d{2}|2([0-4]\\d)|25[0-5])$";
	String regIp6 = "^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$";

	//String test = "^([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.([1-9]?[0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$";
	
	@Autowired
	private ServerService serverService;
	
	@RequestMapping("getServerList")
	public HashMap<String, Object> getServerList(PageVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null){
			String searchWord = param.getSearchWord();
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\").replaceAll("%" , "\\\\%").replaceAll("_", "\\\\_");			
			param.setSearchWord(searchWord);
		}

		
		if(param.getStatus() == "" || param.getStatus() == null) {
			int count = 0;	
			
			ArrayList<ServerVo> serverList = serverService.getServerList(param);
			
			for(ServerVo vo : serverList) {
				int server_no = vo.getServer_no();
				count = vo.getCount();
				String status = serverService.getServerState(server_no);
				
				vo.setStatus(status);
			}
		
			int rows = param.getRows();
			int total = (int) Math.ceil((double)count / rows);

			data.put("rows", serverList); // 데이터
			data.put("records", count); // 데이터의 전체 개수 (viewrecords 에 사용됨)
			data.put("page", param.getPage()); // 현재 페이지
			data.put("total", total); // 총 페이지

		} else {
			
			ArrayList<ServerVo> serverListByStatus = serverService.getServerListByStatus(param);
			int rows = param.getRows();
			int records =  serverListByStatus.size();
			int total = (int) Math.ceil((double)records / rows);
			int page = param.getPage();
			
			List<ServerVo> list = new ArrayList<ServerVo>();
			
			if(page >= total ) {
				list = serverListByStatus.subList((page-1)*rows, records);
			} else {
				list = serverListByStatus.subList((page-1)*rows, page*rows);
			}

			data.put("rows", list); // 데이터
			data.put("records", records); // 데이터의 전체 개수 (viewrecords 에 사용됨)
			data.put("page", param.getPage()); // 현재 페이지
			data.put("total", total); // 총 페이지
		}
		
		return data;
	}
	
	@RequestMapping("insertServer")
	public HashMap<String, Object> insertServer(ServerVo param, HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
//		System.out.println("insertServer : " + new Gson().toJson(param));
				
		UserVo userInfo = (UserVo) session.getAttribute("userInfo");
		if(userInfo == null) { //인터셉터 존재??? delete,update...ajax에서 사용...ㅜㅜ
			data.put("result", "1"); 
			return data; 
		} else if(param.getName() == null) {
			data.put("result", "2");
			return data;
		} else if(!Pattern.matches(regIp4, param.getIp()) && !Pattern.matches(regIp6, param.getIp()) ) {
			System.out.println("ip 패턴이 안맞음....");
			data.put("result", "3");
			return data;
		} else if(!Pattern.matches("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", param.getMac()) ) {
			data.put("result", "4");
			return data;
		} else if(serverService.isExistMac(param.getMac())) {
			data.put("result", "5"); 
			return data;
		}
		
//		System.out.println(new Gson().toJson(param));
		
		param.setUser_no(userInfo.getUser_no());
		serverService.insertServer(param);
		data.put("result", "0");

//		System.out.println("인서트 결과(숫자/0:정상) : " + data.get("result"));
		return data;
	}
	
	@RequestMapping("deleteServer")
	public HashMap<String, Object> deleteServer(@RequestBody ArrayList<String> param){
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
	public HashMap<String, Object> updateServer(ServerVo param, HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
//		System.out.println("updateServer : " + new Gson().toJson(param));
		
		UserVo userInfo = (UserVo) session.getAttribute("userInfo");
		if(userInfo == null) { 
			data.put("result", "1");  //로그인되지 않았을때
			return data; 
		} else if(param.getName() == null) {
			data.put("result", "2"); //서버명이 없을때
			return data;
		} else if(!Pattern.matches(regIp4, param.getIp()) && !Pattern.matches(regIp6, param.getIp()) ) {
			data.put("result", "3"); //ip 형식이 안맞을때
			return data;
		} else if(!Pattern.matches("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", param.getMac()) ) {
			data.put("result", "4"); //mac 형식이 안맞을때
			return data;
		} else if(serverService.isExistMacwithServerNo(param.getMac(),param.getServer_no())) {
			data.put("result", "5"); //나와 다른 서버의 mac이 중복될때
			return data;
		}
	
		serverService.updateServer(param);
		
		data.put("result", "0");
		return data;
	}
	
	@RequestMapping("validationMac")
	public HashMap<String, Object> validationMac(String mac){
		HashMap<String, Object> data = new HashMap<String, Object>();
						
		data.put("isExistMac", serverService.isExistMac(mac)); //내서버번호와 다른서버에 같은mac이 존재하면 true,아니면 false		
	
		return data;
	}
	
	@RequestMapping("validationMacwithServerNo")
	public HashMap<String, Object> validationMacwithServerNo(String mac,String server_no){
		HashMap<String, Object> data = new HashMap<String, Object>();

		Integer serverNo = Integer.parseInt(server_no);

		data.put("isExistMac", serverService.isExistMacwithServerNo(mac,serverNo)); //내서버번호와 다른서버에 같은mac이 존재하면 true,아니면 false		
		
		//false가 되어야 insert되게 해야함
		return data;
	}
	
	@RequestMapping("getServerListByStatus")
	public HashMap<String, Object> getServerListByStatus(PageVo param){
		HashMap<String, Object> data = new HashMap<String, Object>();		
		
		if(param.getStatus() == "") {
			data = getServerList(param);
		} else {
			ArrayList<ServerVo> serverListByStatus = serverService.getServerListByStatus(param);
			int rows = param.getRows();
			int records =  serverListByStatus.size();
			int total = (int) Math.ceil((double)records / rows);
			int page = param.getPage();
			
			List<ServerVo> list = new ArrayList<ServerVo>();
			
			if(page >= total ) {
				list = serverListByStatus.subList((page-1)*rows, records);
			} else {
				list = serverListByStatus.subList((page-1)*rows, page*rows);
			}

			data.put("rows", list); // 데이터
			data.put("records", records); // 데이터의 전체 개수 (viewrecords 에 사용됨)
			data.put("page", param.getPage()); // 현재 페이지
			data.put("total", total); // 총 페이지
		}
		
		return data;
	}
	
	
	
	
	
	
}
