package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.ServerSQLMapper;
import com.brainz.ja.vo.ServerVo;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

@Service
public class ExcelService {
	
	@Autowired
	private ServerSQLMapper sqlMapper;
	
	public ArrayList<ServerVo> getServerList(String searchWord){
		return sqlMapper.getServerListForExcel(searchWord);
	}
	
	public void xlsWiter(ArrayList<ServerVo> list , OutputStream out) {
		// 워크북 생성
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 워크시트 생성
		HSSFSheet sheet = workbook.createSheet();
		// 행 생성
		HSSFRow row = sheet.createRow(0);
		// 쎌 생성
		HSSFCell cell;

		// 헤더 정보 구성
		cell = row.createCell(0);
		cell.setCellValue("서버명");

		cell = row.createCell(1);
		cell.setCellValue("IP");

		cell = row.createCell(2);
		cell.setCellValue("OS분류");

		cell = row.createCell(3);
		cell.setCellValue("상태");
		
		cell = row.createCell(4);
		cell.setCellValue("위치");

		cell = row.createCell(5);
		cell.setCellValue("MAC");

		cell = row.createCell(6);
		cell.setCellValue("관리번호");

		cell = row.createCell(7);
		cell.setCellValue("설명");

		cell = row.createCell(8);
		cell.setCellValue("작성일");
		
		// 리스트의 size 만큼 row를 생성
		ServerVo vo;
		for (int rowIdx = 0; rowIdx < list.size(); rowIdx++) {
			vo = list.get(rowIdx);

			// 행 생성
			row = sheet.createRow(rowIdx + 1);

			cell = row.createCell(0);
			cell.setCellValue(vo.getName());

			cell = row.createCell(1);
			cell.setCellValue(vo.getIp());

			cell = row.createCell(2);
			cell.setCellValue(vo.getOs());

			cell = row.createCell(3);
			cell.setCellValue(vo.getLoc());

			cell = row.createCell(4);
			cell.setCellValue(vo.getLoc());

			cell = row.createCell(5);
			cell.setCellValue(vo.getMac());

			cell = row.createCell(6);
			cell.setCellValue(vo.getControl_num());

			cell = row.createCell(7);
			cell.setCellValue(vo.getDsc());

			cell = row.createCell(8);
			
			
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
			String date = vo.getWrite_date().format(dtf);
			
			cell.setCellValue(date);
						
		}

		// 입력된 내용 파일로 쓰기
		try {
			//workbook.write(fos);
			workbook.write(out);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (workbook != null)
					workbook.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void xlsxWiter(ArrayList<ServerVo> list , OutputStream out) {
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;

		// 헤더 정보 구성
				cell = row.createCell(0);
				cell.setCellValue("서버명");

				cell = row.createCell(1);
				cell.setCellValue("IP");

				cell = row.createCell(2);
				cell.setCellValue("OS분류");

				cell = row.createCell(3);
				cell.setCellValue("상태");
				
				cell = row.createCell(4);
				cell.setCellValue("위치");

				cell = row.createCell(5);
				cell.setCellValue("MAC");

				cell = row.createCell(6);
				cell.setCellValue("관리번호");

				cell = row.createCell(7);
				cell.setCellValue("설명");

				cell = row.createCell(8);
				cell.setCellValue("작성일");
				

		// 리스트의 size 만큼 row를 생성
		ServerVo vo;
		for (int rowIdx = 0; rowIdx < list.size(); rowIdx++) {
			vo = list.get(rowIdx);

			// 행 생성
			row = sheet.createRow(rowIdx + 1);

			cell = row.createCell(0);
			cell.setCellValue(vo.getName());

			cell = row.createCell(1);
			cell.setCellValue(vo.getIp());

			cell = row.createCell(2);
			cell.setCellValue(vo.getOs());

			cell = row.createCell(3);
			cell.setCellValue(vo.getLoc());

			cell = row.createCell(4);
			cell.setCellValue(vo.getLoc());

			cell = row.createCell(5);
			cell.setCellValue(vo.getMac());

			cell = row.createCell(6);
			cell.setCellValue(vo.getControl_num());

			cell = row.createCell(7);
			cell.setCellValue(vo.getDsc());

			cell = row.createCell(8);
			cell.setCellValue(vo.getWrite_date());
			
			System.out.println("test : " + vo.getWrite_date());

		}

		// 입력된 내용 파일로 쓰기
		try {
			//workbook.write(fos);
			workbook.write(out);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (workbook != null)
					workbook.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
