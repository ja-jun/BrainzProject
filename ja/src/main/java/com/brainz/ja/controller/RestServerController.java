package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.ServerService;

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
	
	
	
	
	
	
}
