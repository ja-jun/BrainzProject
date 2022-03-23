package com.choongang.bcentral.user.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.user.service.UserService;
import com.choongang.bcentral.user.vo.UserVo;

// [사용자관리] 비동기적 Controller
@RestController
@RequestMapping("/user/*")
public class RestUserController {
	
	@Autowired
	private UserService userService;

	@RequestMapping("getUserList")
	public HashMap<String, Object> getUserList(String searchWord) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		ArrayList<UserVo> userList = userService.getUserList(searchWord);

		data.put("result", "success");
		data.put("userList", userList);

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
	public HashMap<String, Object> deleteUser(HttpServletRequest request) {// row id 배열??
		HashMap<String, Object> data = new HashMap<String, Object>();

		String userNos = request.getParameter("userNos");

		String[] arr = userNos.split(",");
		userService.deleteUser(arr);

		data.put("result", "success");

		return data;
	}

	@RequestMapping("updateUser")
	public HashMap<String, Object> updateUser(UserVo param) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		userService.updateUser(param);

		// 예외처리 try문??
		// if 문? { data.put("result", "error"); data.put("reason", "이런 에러가 발생했습니다");
		// return data; }

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
