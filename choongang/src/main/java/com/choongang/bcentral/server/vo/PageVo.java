package com.choongang.bcentral.server.vo;

public class PageVo {
	private Integer rows;  //보여질 행 개수
	private Integer page;  //현재 페이지번호
	private String sidx;     //정렬할 column name
	private String sord;	 //정렬기준 (asc,desc)
	private String searchWord; //검색어 
	private Integer total;  //전체 페이지 개수
	private Integer records; //전체 행 개수
	
	public PageVo() {
		// TODO Auto-generated constructor stub
	}

	public PageVo(Integer rows, Integer page, String sidx, String sord, String searchWord, Integer total,
			Integer records) {
		super();
		this.rows = rows;
		this.page = page;
		this.sidx = sidx;
		this.sord = sord;
		this.searchWord = searchWord;
		this.total = total;
		this.records = records;
	}

	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
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
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getRecords() {
		return records;
	}
	public void setRecords(Integer records) {
		this.records = records;
	}
}
