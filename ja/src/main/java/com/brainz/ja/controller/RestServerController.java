package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.ServerService;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/server/*")
public class RestServerController {

	@Autowired
	private ServerService serverService;
	
	@RequestMapping("getServerList")
	public  Map<String, Object> getServerList(PageVo param) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		if(param.getSearchWord() != null){
			String searchWord = param.getSearchWord();
			System.out.println(searchWord);
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\");
			param.setSearchWord(searchWord);
			System.out.println(searchWord);
		}
		
		ArrayList<ServerVo> serverList = serverService.getServerList(param);	
		System.out.println(new Gson().toJson(param));
		int rows = param.getRows();
		int records = serverService.getServerCount(param);
		int total = (int) Math.ceil( (double)records / rows);
		
		data.put("rows", serverList); //데이터
		data.put("records", records); // 데이터의 전체 개수  //viewrecords에 사용됨
		data.put("page", param.getPage()); //현재 페이지
		data.put("total", total); //총 페이지

		return data;
	}
			
	@RequestMapping("insertServer")
	public HashMap<String, Object> insertServer(ServerVo param) {
	//	System.out.println("2 - " + new Gson().toJson(param));
		HashMap<String, Object>data = new HashMap<String, Object>();

		param.setUser_no(2); 
		
		serverService.insertServer(param);
		
		data.put("result","success");
		
		return data;
	}
		
	@RequestMapping("deleteServer")
	public  HashMap<String, Object> deleteServer(@RequestBody List<String> param) {
		//data의 필요성 에러 관련
		HashMap<String, Object> data = new HashMap<String, Object>();

		serverService.deleteServer(param);

		return data;
	}

	
	@RequestMapping("getServer")
	public  HashMap<String, Object> getServer(int server_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		ServerVo server = serverService.getServer(server_no);
		
		data.put("server", server); 
		return data;
	}

	@RequestMapping("updateServer")
	public HashMap<String, Object> updateServer(ServerVo param) {
		HashMap<String, Object>data = new HashMap<String, Object>();

		System.out.println("**************");
		
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
	
	/*
	 * @RequestMapping("getData") public Map<String, Object> getData(
	 * 
	 * @RequestParam
	 * 
	 * @RequestBody Map<String,Object> param) {
	 * 
	 * int pageNum = Integer.parseInt((String)param.get("page"));
	 * 
	 * 
	 * Map<String, Object> resMap = new HashMap<>();
	 * 
	 * List<Map<String, Object>> list = new ArrayList<>(); for(int i =
	 * (pageNum-1)*10 ; i < pageNum*10 ; i++) { Map<String, Object> row = new
	 * HashMap<>(); row.put("name", "qwer" + i); row.put("invdate", "wwww"); //문자로
	 * 가야되네;;; 이런;;; row.put("amount", 3); row.put("tax", 7); row.put("testNo", 7);
	 * row.put("id", i); //이건 의미 있음...필수... list.add(row); }
	 * 
	 * resMap.put("rows", list); resMap.put("records", list.size());
	 * resMap.put("page", param.get("page")); resMap.put("total", 20);
	 * 
	 * System.out.println("test!!!!!!"); System.out.println(param);
	 * 
	 * 
	 * return resMap; }
	 */
	
}
