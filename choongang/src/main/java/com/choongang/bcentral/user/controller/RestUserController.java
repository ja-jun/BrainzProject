package com.choongang.bcentral.user.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.user.service.AESUtil;
import com.choongang.bcentral.user.service.UserService;
import com.choongang.bcentral.user.vo.UserVo;

// [사용자관리] 비동기적 Controller
@RestController
@RequestMapping("/user/*")
public class RestUserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	AESUtil aes;

	@RequestMapping("getUserList")
	public HashMap<String, Object> getUserList(PageVo param) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		if(param.getSearchWord() != null) {
			String searchWord = param.getSearchWord();
			searchWord = searchWord.replaceAll("\\\\", "\\\\\\\\");
			
			param.setSearchWord(searchWord);
		}
		
		ArrayList<UserVo> userList = userService.getUserList(param);
		
		int rows = param.getRows();
		int records = userService.getUserCount(param);
		int total = (int) Math.ceil((double) records / rows);

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

		data.put("result", "success");

		return data;
	}

	@RequestMapping("deleteUser")
	public HashMap<String, Object> deleteUser(ArrayList<String> param) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		userService.deleteUser(param);

		data.put("result", "success");

		return data;
	}
	
	@RequestMapping("getUser")
	public HashMap<String, Object> getUser(int user_no) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		UserVo user = userService.getUser(user_no);
		String decryptphone = aes.decrypt(user.getPhone());
		user.setPhone(decryptphone);
		
		String decryptemail = aes.decrypt(user.getEmail());
		user.setEmail(decryptemail);
		
		data.put("user", user);
		
		return data;
	}
	
	@RequestMapping("updateUser")
	public HashMap<String, Object> updateUser(UserVo param) throws Exception{
		HashMap<String, Object> data = new HashMap<String, Object>();

		userService.updateUser(param);
		
		data.put("result", "success");

		return data;
	}

	@RequestMapping("isExistId")
	public HashMap<String, Object> isExistId(String id) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		boolean result = userService.isExistId(id);

		data.put("result", result);

		return data;
	}
}
