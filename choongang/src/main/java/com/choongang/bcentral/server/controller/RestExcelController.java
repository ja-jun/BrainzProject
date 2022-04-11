package com.choongang.bcentral.server.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.bcentral.server.service.ExcelService;
import com.choongang.bcentral.server.vo.PageVo;
import com.choongang.bcentral.server.vo.ServerVo;
import com.google.gson.Gson;

// [서버관리] 에서 내보내기 기능을 비동기적으로 사용하기 위한 Controller
@RestController
@RequestMapping("/server/*")
public class RestExcelController {
	
	@Autowired
	private ExcelService excelService;
	
	@RequestMapping("getExcelServerList")
	public void getServerList(PageVo vo, HttpServletResponse response) throws IOException {
		
		System.out.println(new Gson().toJson(vo));
		
		if(vo.getStatus() == null) {
			vo.setStatus("3");
		}
		ArrayList<ServerVo> serverList = excelService.getServerList(vo);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String strDate = sdf.format(date);
		String fileName = "server_list_" + strDate + ".xls";
		
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		
		excelService.xlsWiter(serverList , response.getOutputStream());
	}
}
