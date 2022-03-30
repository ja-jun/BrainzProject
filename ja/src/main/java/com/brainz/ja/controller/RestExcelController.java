package com.brainz.ja.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.brainz.ja.service.ExcelService;
import com.brainz.ja.service.ServerService;
import com.brainz.ja.vo.PageVo;
import com.brainz.ja.vo.ServerVo;

@RestController
@RequestMapping("/server/*")
public class RestExcelController {
	
	@Autowired
	private ExcelService excelService;
	
	@RequestMapping("getExcelServerList")
	public void getServerListForExcel(PageVo vo, HttpServletResponse response) throws IOException {
		
		System.out.println("test!" + vo);
		
		ArrayList<ServerVo> serverList = excelService.getServerListForExcel(vo);

		
		System.out.println("test2222 : " + serverList.size());

		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		String strDate = sdf.format(date);
		
		String fileName = "server_list_" + strDate + ".xls";
		
		
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		
		
		//xls 파일 쓰기
		excelService.xlsWiter(serverList , response.getOutputStream());
        
        //xlsx 파일 쓰기
//		excelService.xlsxWiter(serverList , response.getOutputStream());
		
	}
}
