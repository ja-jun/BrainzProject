package com.choongang.bcentral.noti.vo;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class FileVo {

	private Integer file_no;
	private String name;
	private Integer nc_no;
	private String fileName;
	private String uploadedFileName;
	private Integer fileSize;
	private String contentType;
	private String downlink;
		
	public FileVo() {
		super();
	}	

	public FileVo(Integer nc_no, String name, String fileName, String uploadedFileName, Integer fileSize,
			String contentType, String downlink) {
		super();
		this.nc_no = nc_no;
		this.name = name;
		this.fileName = fileName;
		this.uploadedFileName = uploadedFileName;
		this.fileSize = fileSize;
		this.contentType = contentType;
		this.downlink = downlink;
	}	

	
	
	public Integer getFile_no() {
		return file_no;
	}

	public void setFile_no(Integer file_no) {
		this.file_no = file_no;
	}

	public Integer getNc_no() {
		return nc_no;
	}

	public void setNc_no(Integer nc_no) {
		this.nc_no = nc_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadedFileName() {
		return uploadedFileName;
	}

	public void setUploadedFileName(String uploadedFileName) {
		this.uploadedFileName = uploadedFileName;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(Integer fileSize) {
		this.fileSize = fileSize;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getDownlink() {
		return downlink;
	}

	public void setDownlink(String downlink) {
		this.downlink = downlink;
	}

}	