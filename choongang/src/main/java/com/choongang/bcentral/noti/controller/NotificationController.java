package com.choongang.bcentral.noti.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.choongang.bcentral.noti.service.NotificationService;
import com.choongang.bcentral.noti.vo.FileVo;
import com.choongang.bcentral.noti.vo.NotificationVo;

@Controller
@RequestMapping("/notification/*")
public class NotificationController {
	
	@Autowired
	public NotificationService NotificationService;

	@RequestMapping("mainPage")
	public String notification(HttpSession session) {
		return "/notification/mainPage";
	}
	
	@RequestMapping("readPage")
	public String readPage(HttpSession session, int nc_no, Model model) {
		
		NotificationService.increaseReadCount(nc_no);
		
		NotificationVo data = NotificationService.getNotification(nc_no);
		model.addAttribute("data",data);
		
		ArrayList<FileVo> file = NotificationService.getFileVo(nc_no);
		model.addAttribute("file",file);
		
		int test = NotificationService.PREBNO(nc_no);
		NotificationVo data2 = NotificationService.getNotification(test);
		model.addAttribute("data2",data2);
		
		int test2 = NotificationService.NEXTBNO(nc_no);
		NotificationVo data3 = NotificationService.getNotification(test2);
		model.addAttribute("data3",data3);
		
		return "/notification/readPage";
	}
}
