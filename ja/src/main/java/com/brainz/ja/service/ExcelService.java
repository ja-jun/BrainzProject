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
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
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

		// 열폭 수정
		sheet.setColumnWidth(0, 5500);
		sheet.setColumnWidth(1, 5500);
		sheet.setColumnWidth(2, 5500);
		sheet.setColumnWidth(3, 5500);
		sheet.setColumnWidth(4, 5500);
		sheet.setColumnWidth(5, 5500);
		sheet.setColumnWidth(6, 5500);
		sheet.setColumnWidth(7, 5500);
		sheet.setColumnWidth(8, 5500);
		
		// 첫행 서버목록 스타일
		HSSFCellStyle mergeRowStyle = (HSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle.setBorderTop(BorderStyle.THICK);
		mergeRowStyle.setBorderLeft(BorderStyle.THICK);
		mergeRowStyle.setBorderRight(BorderStyle.THICK);
		mergeRowStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());

		// 헤더 스타일
		HSSFCellStyle mergeRowStyle1 = (HSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle1.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle1.setBorderTop(BorderStyle.THIN);
		mergeRowStyle1.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle1.setBorderRight(BorderStyle.THIN);
		mergeRowStyle1.setBorderBottom(BorderStyle.THIN);
		mergeRowStyle1.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
		
		// 바디 스타일
		HSSFCellStyle mergeRowStyle2 = (HSSFCellStyle) workbook.createCellStyle();
		mergeRowStyle2.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
		mergeRowStyle2.setBorderTop(BorderStyle.THIN);
		mergeRowStyle2.setBorderLeft(BorderStyle.THIN);
		mergeRowStyle2.setBorderRight(BorderStyle.THIN);
		mergeRowStyle2.setBorderBottom(BorderStyle.THIN);
				
		// 1행 서버목록 병합 작업
		for(int i=0; i<9; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			cell.setCellValue("서버 목록");
		}
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,8));
//		// 2행 빈칸
//		for(int i=0; i<9; i++) {
//			cell = row.createCell(0);
//			cell.setCellValue("");
//		}
//		sheet.addMergedRegion(new CellRangeAddress(1,1,0,8));
//				
////		// 헤더 정보 구성
//		cell = row.createCell(0);
//		cell.setCellValue("서버명");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(1);
//		cell.setCellValue("IP");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(2);
//		cell.setCellValue("OS분류");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(3);
//		cell.setCellValue("상태");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(4);
//		cell.setCellValue("위치");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(5);
//		cell.setCellValue("MAC");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(6);
//		cell.setCellValue("관리번호");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(7);
//		cell.setCellValue("설명");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		cell = row.createCell(8);
//		cell.setCellValue("작성일");
//		cell.setCellStyle(mergeRowStyle1);
//		
//		// 리스트의 size 만큼 row를 생성
//		
//		ServerVo vo;
//		for (int rowIdx = 0; rowIdx < list.size(); rowIdx++) {
//			vo = list.get(rowIdx);
//
//			// 행 생성
//			row = sheet.createRow(rowIdx + 1);
//
//			cell = row.createCell(0);
//			cell.setCellValue(vo.getName());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(1);
//			cell.setCellValue(vo.getIp());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(2);
//			cell.setCellValue(vo.getOs());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(3);
//			cell.setCellValue(vo.getLoc());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(4);
//			cell.setCellValue(vo.getLoc());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(5);
//			cell.setCellValue(vo.getMac());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(6);
//			cell.setCellValue(vo.getControl_num());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(7);
//			cell.setCellValue(vo.getDsc());
//			cell.setCellStyle(mergeRowStyle2);
//			
//			cell = row.createCell(8);			
//			
//			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
//			String date = vo.getWrite_date().format(dtf);
//			
//			cell.setCellValue(date);
//			cell.setCellStyle(mergeRowStyle2);
//						
//		}
//		
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
	
//	public void xlsxWiter(ArrayList<ServerVo> list , OutputStream out) {
//		// 워크북 생성
//		XSSFWorkbook workbook = new XSSFWorkbook();
//		// 워크시트 생성
//		XSSFSheet sheet = workbook.createSheet();
//		// 행 생성
//		XSSFRow row = sheet.createRow(0);
//		// 쎌 생성
//		XSSFCell cell;
//
//		// 헤더 정보 구성
//				cell = row.createCell(0);
//				cell.setCellValue("서버명");
//
//				cell = row.createCell(1);
//				cell.setCellValue("IP");
//
//				cell = row.createCell(2);
//				cell.setCellValue("OS분류");
//
//				cell = row.createCell(3);
//				cell.setCellValue("상태");
//				
//				cell = row.createCell(4);
//				cell.setCellValue("위치");
//
//				cell = row.createCell(5);
//				cell.setCellValue("MAC");
//
//				cell = row.createCell(6);
//				cell.setCellValue("관리번호");
//
//				cell = row.createCell(7);
//				cell.setCellValue("설명");
//
//				cell = row.createCell(8);
//				cell.setCellValue("작성일");
//				
//
//		// 리스트의 size 만큼 row를 생성
//		ServerVo vo;
//		for (int rowIdx = 0; rowIdx < list.size(); rowIdx++) {
//			vo = list.get(rowIdx);
//
//			// 행 생성
//			row = sheet.createRow(rowIdx + 1);
//
//			cell = row.createCell(0);
//			cell.setCellValue(vo.getName());
//
//			cell = row.createCell(1);
//			cell.setCellValue(vo.getIp());
//
//			cell = row.createCell(2);
//			cell.setCellValue(vo.getOs());
//
//			cell = row.createCell(3);
//			cell.setCellValue(vo.getLoc());
//
//			cell = row.createCell(4);
//			cell.setCellValue(vo.getLoc());
//
//			cell = row.createCell(5);
//			cell.setCellValue(vo.getMac());
//
//			cell = row.createCell(6);
//			cell.setCellValue(vo.getControl_num());
//
//			cell = row.createCell(7);
//			cell.setCellValue(vo.getDsc());
//
//			cell = row.createCell(8);
//			cell.setCellValue(vo.getWrite_date());
//			
//			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
//			String date = vo.getWrite_date().format(dtf);
//			
//			cell.setCellValue(date);
//						
//		}
//
//		// 입력된 내용 파일로 쓰기
//		try {
//			//workbook.write(fos);
//			workbook.write(out);
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if (workbook != null)
//					workbook.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//
//	}

}
