package com.brainz.ja.vo;

public class GridPageVo {
	private String searchWord; 
	private Integer page;  
	private Integer rows;
	private String sidx; 
	private String sord;
	
	public GridPageVo() {
		// TODO Auto-generated constructor stub
	}

	public GridPageVo(String searchWord, int page, int rows, String sidx, String sord) {
		super();
		this.searchWord = searchWord;
		this.page = page;
		this.rows = rows;
		this.sidx = sidx;
		this.sord = sord;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}
	
	
	
}
