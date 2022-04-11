package com.choongang.bcentral.noti.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.bcentral.mapper.NotificationSQLMapper;
import com.choongang.bcentral.noti.vo.FileVo;
import com.choongang.bcentral.noti.vo.NotificationVo;
import com.choongang.bcentral.server.vo.PageVo;

// 공지사항 Service
@Service
public class NotificationService {
	
	@Autowired
	private NotificationSQLMapper notiSQLMapper;
	
	public ArrayList<NotificationVo> getNotificationList(PageVo vo){
		return notiSQLMapper.getNotificationList(vo);
	}
	
	public void insertNotification(NotificationVo vo , List<FileVo> fileVoList) {
		
		int ncNo = notiSQLMapper.getNextNotificationNo();
		vo.setNc_no(ncNo);
		notiSQLMapper.insertNotification(vo);
		
		
		for(FileVo fileVo : fileVoList) {
			fileVo.setNc_no(ncNo);
			
			//test
			fileVo.setName("사용 안함");
			fileVo.setDownlink("사용 안함");
						
			int fileNo = notiSQLMapper.getNextFileNo();
			fileVo.setFile_no(fileNo);
			
			notiSQLMapper.insertFile(fileVo);
		}
		
	}
	
	public void updateNotification(NotificationVo vo) {
		notiSQLMapper.updateNotification(vo);
	}
	
	public void deleteNotification(ArrayList<String> nos) {
		for(String no : nos) {
			notiSQLMapper.deleteNotification(Integer.parseInt(no.trim()));
		}
	}
	
	public NotificationVo getNotification(int nc_no) {
		return notiSQLMapper.getNotification(nc_no);
	}
	
	public void increaseReadCount(int nc_no) {
		notiSQLMapper.increaseReadCount(nc_no);
	}
	
	public int getNotificationCount(PageVo vo) {
		return notiSQLMapper.getNotificationCount(vo);
	}
	
	public ArrayList<FileVo> getFileVo(int nc_no){
		return notiSQLMapper.getFileVo(nc_no);
	}
	
	public FileVo getFileInfo(int file_no) {
		return notiSQLMapper.getFileInfo(file_no);
	}
	
	public int PREBNO(int nc_no) {
		return notiSQLMapper.PREBNO(nc_no);
	}
	
	public int NEXTBNO(int nc_no) {
		return notiSQLMapper.NEXTBNO(nc_no);
	}
	
	public void deleteRealFile(FileVo fileVo) {
		File file = new File(fileVo.getUploadedFileName());
		
		if(file.exists()) {
			file.delete();
		}
	}
	
	public void deleteFile(int nc_no) {
		ArrayList<FileVo> fileList = notiSQLMapper.getFileList(nc_no);
		
		if(!fileList.isEmpty()) {
			for(FileVo fVo : fileList) {
				// deleteRealFile(fVo);
				
				notiSQLMapper.deleteFile(fVo.getFile_no());
			}
		}
	}
	
	public void updateFile(int nc_no, FileVo fileVo) {
		ArrayList<FileVo> fileList = notiSQLMapper.getFileList(nc_no);
		
		if(!fileList.isEmpty()) {
			for(FileVo preFileVo : fileList) {
				// deleteRealFile(preFileVo);
				
				fileVo.setFile_no(preFileVo.getFile_no());
				
				notiSQLMapper.updateFile(fileVo);
			}
		}else {
			fileVo.setNc_no(nc_no);
			
			//test
			fileVo.setName("사용 안함");
			fileVo.setDownlink("사용 안함");
						
			int fileNo = notiSQLMapper.getNextFileNo();
			fileVo.setFile_no(fileNo);
			
			notiSQLMapper.insertFile(fileVo);
		}
	}
}
