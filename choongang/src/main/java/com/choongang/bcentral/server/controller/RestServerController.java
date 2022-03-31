package com.choongang.bcentral.server.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.schedule.vo.ScheduleVo;
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
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\").replaceAll("%" , "\\\\%").replaceAll("_", "\\\\_");			
			param.setSearchWord(searchWord);
		}
		
		ArrayList<ServerVo> serverList = serverService.getServerList(param);
		
		
		//status 계산
		
		String status = "";
		ArrayList<Integer> stateList = new ArrayList<Integer>();
		int state = 3;
		for(ServerVo vo : serverList) {
			
			int server_no = vo.getServer_no();
			ArrayList<Integer> scNos= serverService.getScNoListByServerNo(server_no);

			if(scNos == null) {
				state = 3;
			} else {
				for(int no : scNos) {
					ScheduleVo sVo= serverService.getScheduleByScNo(no);
					int s = serverService.todaySchedule(sVo);
					System.out.println("상태 :" +   s);
					stateList.add(s);	
				}
				
				if(stateList.contains(1)) {
					state  = 1;
				} else if(stateList.contains(0)) {
					state = 0;
				} else if(stateList.contains(2)) {
					state = 2;
				} else {
					state = 3;
				}
			}
			
			
			if(state == 0 ) {
				status = "오늘 작업 예정";
			} else if(state == 1) {
				status = "현재 작업 중";
			} else if(state == 2) {
				status = "작업 완료";
			} else if(state == 3) {
				status = "오늘 작업 없음";
			}
			
			vo.setStatus(status);
		}
	
		int rows = param.getRows();
		int records = serverService.getServerCount(param);
		int total = (int) Math.ceil((double)records / rows);

		
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
