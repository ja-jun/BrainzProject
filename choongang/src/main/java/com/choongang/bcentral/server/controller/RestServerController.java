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
		
		ArrayList<ServerVo> serverList = serverService.getServerList(param);
		
		int rows = param.getRows();
		int records = serverService.getServerCount(param);
		int total = (int) Math.ceil((double)records / rows);
		
		param.setTotal(total);
		param.setRecords(records);
		
		data.put("result", "success");
		data.put("rows", serverList);
		data.put("records", records);
		data.put("page", param.getPage());
		data.put("total", total);
		
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
	
	@RequestMapping("updateServer")
	public HashMap<String, Object> updateServer(ServerVo parma){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		serverService.updateServer(parma);
		
		return data;
	}
	
	@RequestMapping("isExistMac")
	public HashMap<String, Object> isExistMac(String mac){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("result", serverService.isExistMac(mac));
		
		return data;
	}
}
