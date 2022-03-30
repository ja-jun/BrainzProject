package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.ServerSQLMapper;
import com.brainz.ja.vo.PageVo;
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
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
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
	
	public ArrayList<ServerVo> getServerListForExcel(PageVo vo){
		return sqlMapper.getServerListForExcel(vo);
	}
	
	public void xlsWiter(ArrayList<ServerVo> list , OutputStream out) {
		// 워크북 생성
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 워크시트 생성
		HSSFSheet sheet = workbook.createSheet();
		// 행 생성
		HSSFRow row = sheet.createRow(0);
		// 쎌 생성
		HSSFCell cell = row.createCell(0);

		// 날짜 설정
		Date createDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(createDate);		

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
		
		// 1행 서버목록 스타일
		CellStyle rowStyle1 = workbook.createCellStyle();
		rowStyle1.setAlignment(HorizontalAlignment.LEFT);
		rowStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
		rowStyle1.setBorderTop(BorderStyle.THICK);
		rowStyle1.setBorderBottom(BorderStyle.THICK);
		rowStyle1.setBorderLeft(BorderStyle.THICK);
		rowStyle1.setBorderRight(BorderStyle.THICK);
		rowStyle1.setFillForegroundColor(HSSFColorPredefined.GREY_40_PERCENT.getIndex());
		rowStyle1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		rowStyle1.setWrapText(true); // 셀에서 줄바꿈

		// 2행 날짜 스타일
		CellStyle rowStyle2 = workbook.createCellStyle();
		rowStyle2.setAlignment(HorizontalAlignment.RIGHT);
		rowStyle2.setVerticalAlignment(VerticalAlignment.CENTER);
		
		// 3행 헤더 스타일
		CellStyle rowStyle3 = workbook.createCellStyle();
		rowStyle3.setAlignment(HorizontalAlignment.CENTER);
		rowStyle3.setVerticalAlignment(VerticalAlignment.CENTER);
		rowStyle3.setBorderTop(BorderStyle.THIN);
		rowStyle3.setBorderLeft(BorderStyle.THIN);
		rowStyle3.setBorderRight(BorderStyle.THIN);
		rowStyle3.setBorderBottom(BorderStyle.THIN);
		rowStyle3.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		rowStyle3.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		rowStyle3.setWrapText(true); // 셀에서 줄바꿈
		
		// 4행 바디 스타일
		CellStyle rowStyle4 = workbook.createCellStyle();
		rowStyle4.setAlignment(HorizontalAlignment.CENTER);
		rowStyle4.setVerticalAlignment(VerticalAlignment.CENTER);
		rowStyle4.setBorderTop(BorderStyle.THIN);
		rowStyle4.setBorderLeft(BorderStyle.THIN);
		rowStyle4.setBorderRight(BorderStyle.THIN);
		rowStyle4.setBorderBottom(BorderStyle.THIN);
		rowStyle4.setWrapText(true); // 셀에서 줄바꿈
		
		// 1행 서버목록 폰트
		Font row1 = workbook.createFont();		
		row1.setFontName("맑은고딕"); //글씨체
		row1.setFontHeight((short)(14*20)); //사이즈	
		row1.setBold(true); // 굵게
		//row1.setBoldweight(Font.BOLDWEIGHT_BOLD); // 굵게
		rowStyle1.setFont(row1);
		
		// 2행 날짜 폰트
		Font row2 = workbook.createFont();		
		row2.setFontName("맑은고딕"); 
		row2.setFontHeight((short)(8*20)); //사이즈	
		rowStyle2.setFont(row2);
		
		// 3행 헤더 폰트
		Font row3 = workbook.createFont();		
		row3.setFontName("맑은고딕");
		row3.setFontHeight((short)(10*20)); //사이즈	
		row3.setBold(true); // 굵게
		rowStyle3.setFont(row3);

		// 4행 바디 폰트
		Font row4 = workbook.createFont();		
		row4.setFontName("맑은고딕"); 
		row4.setFontHeight((short)(8*20)); //사이즈	
		rowStyle4.setFont(row4);
		
		// 1행 서버목록 병합 작업
		row.setHeight((short)800);
		for(int i=0; i<9; i++) {
		cell = row.createCell(i);
		cell.setCellValue(" 서버 목록");
		cell.setCellStyle(rowStyle1);			
		}
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,8));	
		
		// 2행 날짜
		row = sheet.createRow(1);
		row.setHeight((short)700);
		for(int i=0; i<9; i++) {
		cell = row.createCell(i);
		cell.setCellValue("생성일시 : " + strDate);
		cell.setCellStyle(rowStyle2);	
		}
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,8));

		// 3행 헤더 정보 구성
		row = sheet.createRow(2);
		row.setHeight((short)350);
		cell = row.createCell(0);
		cell.setCellValue("서버명");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(1);
		cell.setCellValue("IP");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(2);
		cell.setCellValue("OS분류");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(3);
		cell.setCellValue("상태");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(4);
		cell.setCellValue("위치");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(5);
		cell.setCellValue("MAC");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(6);
		cell.setCellValue("관리번호");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(7);
		cell.setCellValue("설명");
		cell.setCellStyle(rowStyle3);
		
		cell = row.createCell(8);
		cell.setCellValue("작성일");
		cell.setCellStyle(rowStyle3);
		
		// 4행 리스트의 size 만큼 row를 생성 및 DB 연동
		
		ServerVo vo;
		
		for (int i = 0; i < list.size(); i++) {
			vo = list.get(i);

			// 행 생성
			row = sheet.createRow(i + 3);

			cell = row.createCell(0);
			cell.setCellValue(vo.getName());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(1);
			cell.setCellValue(vo.getIp());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(2);
			cell.setCellValue(vo.getOs());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(3);
			cell.setCellValue(vo.getLoc());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(4);
			cell.setCellValue(vo.getLoc());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(5);
			cell.setCellValue(vo.getMac());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(6);
			cell.setCellValue(vo.getControl_num());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(7);
			cell.setCellValue(vo.getDsc());
			cell.setCellStyle(rowStyle4);
			
			cell = row.createCell(8);	
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String date = vo.getWrite_date().format(dtf);
			
			cell.setCellValue(date);
			cell.setCellStyle(rowStyle4);
						
			
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
