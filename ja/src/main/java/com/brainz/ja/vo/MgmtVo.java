package com.brainz.ja.vo;

public class MgmtVo {
	private int mgmt_server_no;
	private int server_no;
	private int sc_no;
	
	public MgmtVo() {
		super();
	}
	
	public MgmtVo(int mgmt_server_no, int server_no, int sc_no) {
		super();
		this.mgmt_server_no = mgmt_server_no;
		this.server_no = server_no;
		this.sc_no = sc_no;
	}
	
	public int getMgmt_server_no() {
		return mgmt_server_no;
	}
	public void setMgmt_server_no(int mgmt_server_no) {
		this.mgmt_server_no = mgmt_server_no;
	}
	public int getServer_no() {
		return server_no;
	}
	public void setServer_no(int server_no) {
		this.server_no = server_no;
	}
	public int getSc_no() {
		return sc_no;
	}
	public void setSc_no(int sc_no) {
		this.sc_no = sc_no;
	}
}
