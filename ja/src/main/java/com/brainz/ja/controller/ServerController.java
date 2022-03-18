package com.brainz.ja.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.brainz.ja.service.ServerService;
import com.brainz.ja.vo.ServerVo;

@Controller
@RequestMapping("/server/*")
public class ServerController {

	@Autowired
	private ServerService serverService;

	@RequestMapping("mainPage")
	public String mainPage(HttpSession session) {
		//로그인 했을때 session에 "sessionUser"로 user정보를 담았다고 가정
		//			UserVo session = (UserVo) session.getattribute("sessionUser");
		//			int userNo = sessionUser.getUser_no();

			/*상태 항목에 대해서 작업관리에 현재 작업중인지 아닌지 
			  확인해서 작업중/정상 값 hashmap에 추가할지(controller 또는 serverice에 추가) 
		 */
		return "/server/mainPage";
	}

	

	
	
	
	
	@RequestMapping("jqgrid_test")
	public String jqgrid() {
	
		return "/server/jqgrid_test";
	}
	
	@RequestMapping("css")
	public String css() {

		return "/server/css";
	}

@RequestMapping("test2")
public String test() {
	return "server/test2";
}

@RequestMapping("modalTest")
public String modalTest() {
	return "server/modalTest";
}


}