package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.AESUtil;
import com.brainz.ja.service.UserService;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.UserVo;
import com.google.gson.Gson;

@RestController
@RequestMapping("/user/*")
public class RestUserController {

	
	@Autowired
	private UserService userService;
	
	@Autowired
	AESUtil aes;
	
	@RequestMapping("getUserList") 
	public Map<String, Object> getUserList(PageVo param) { 
		
		Map<String, Object> data = new HashMap<String,Object>();
		
		if(param.getSearchWord() != null){ 
			String searchWord = param.getSearchWord();
			System.out.println(searchWord); 
			searchWord = searchWord.replaceAll("\\\\" , "\\\\\\\\"); 
			param.setSearchWord(searchWord);
			System.out.println(searchWord); 
		}
		  
		ArrayList<UserVo> userList = userService.getUserList(param);
		System.out.println(new Gson().toJson(param)); 
		int rows = param.getRows(); 
		int records = userService.getUserCount(param); 
		int total = (int) Math.ceil( (double)records / rows);
		
		  
		data.put("rows", userList); //데이터
		data.put("records", records); // 데이터의 전체 개수  //viewrecords에 사용됨
		data.put("page", param.getPage()); //현재 페이지
		data.put("total", total); //총 페이지
		 
		return data; 
	
	}

	
	@RequestMapping("registerUser")
	public HashMap<String, Object> insertUser(UserVo param) throws Exception {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
						
		userService.registerUser(param);

		data.put("result","success");
		
		return data;
	}
		
	
	@RequestMapping("deleteUser")
	public  HashMap<String, Object> deleteUser(@RequestBody List<String> param) {
		//data의 필요성 에러 관련
		HashMap<String, Object> data = new HashMap<String, Object>();

		userService.deleteUser(param);

		return data;
	}
		
	
	@RequestMapping("getUser")
	public  HashMap<String, Object> getUser(int user_no) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();
		System.out.println("user_no : " + user_no);
		
		UserVo user = userService.getUser(user_no);
		
		// 개인정보 양방향 암호화
		String decryptphone = aes.decrypt(user.getPhone());
		user.setPhone(decryptphone);
		
		String decryptemail = aes.decrypt(user.getEmail());
		user.setEmail(decryptemail);
		
		System.out.println(new Gson().toJson(user));
		
		data.put("user", user); 
		return data;
	}
	
	
	@RequestMapping("updateUser")
	public HashMap<String, Object> updateUser(UserVo param) throws Exception {
		HashMap<String, Object>data = new HashMap<String, Object>();
		
		System.out.println(new Gson().toJson(param));
		
		userService.updateUser(param);
		
//		if(param.getUser_pw().equals("")) {
//			System.out.println("암호가 비어있습니다.");
//		} else {
//			System.out.println("암호가 비어있지 않습니다.");
//		}
			
		data.put("result","success");
		
		return data;
	}
	
	
	@RequestMapping("isExistId")
	public HashMap<String, Object>isExistId(String id){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		boolean result = userService.isExistId(id); 	
		
		data.put("result", result);
		
		return data;
	}

	

}
