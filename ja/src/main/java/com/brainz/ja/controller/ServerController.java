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

	@RequestMapping("insertServerProcess")
	public String insertServerProcess(ServerVo param, HttpSession session) {
		//로그인 했을때 session에 user정보를 담았다고 가정
		//			UserVo session = (UserVo) session.getattribute("sessionUser");
		//			int userNo = sessionUser.getUser_no();
		//			param.setUser_no(userNo);

		serverService.insertServer(param);

		return "redirect:./mainPage" ;
	}

	@RequestMapping("insertServerPage")
	public String insertServerPage() {

		return "/server/insertServerPage";	
	}

	@RequestMapping("updateServerPage")
	public String updateServerPage(int server_no, Model model) {
		ServerVo serverVo = serverService.getServer(server_no);

		model.addAttribute("serverVo",serverVo);

		return"/server/updateServerPage";
	}

		@RequestMapping("deleteServerProcess")
	public String deleteServerProcess(int server_no) {
		serverService.deleteServer(server_no);

		return "redirect:./mainPage";
	}

	@RequestMapping("updateServerProcess")
	public String updateServerProcess(ServerVo param) {
		serverService.updateServer(param);

		return "redirect:./mainPage";
	}

	@RequestMapping("jqgrid_test")
	public String jqgrid() {
	
		return "/server/jqgrid_test";
	}

	
	@RequestMapping("css")
	public String css() {

		return "/server/css";
	}

@RequestMapping("test1")
public String test() {
	return "/test1";
}


}