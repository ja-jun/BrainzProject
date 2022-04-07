package com.choongang.bcentral.user.vo;

public class UserPageVo {
		private Integer rows;  //보여질 행 개수
		private Integer page;  //현재 페이지번호
		private String sidx;     //정렬할 column name
		private String sord;	 //정렬기준 (asc,desc)
		private String searchWord; //검색어 
		private Integer user_no;
		
		private UserPageVo() {
			super();
		}

		private UserPageVo(Integer rows, Integer page, String sidx, String sord, String searchWord, Integer user_no) {
			super();
			this.rows = rows;
			this.page = page;
			this.sidx = sidx;
			this.sord = sord;
			this.searchWord = searchWord;
			this.user_no = user_no;
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

		public Integer getUser_no() {
			return user_no;
		}

		public void setUser_no(Integer user_no) {
			this.user_no = user_no;
		}
		

}
