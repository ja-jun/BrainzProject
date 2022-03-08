package com.brainz.ja.vo;

public class TestVo {
	
	private String serverName;
	private String ip;
	private String os;
	
	public TestVo() {
		super();
	}

	public TestVo(String serverName, String ip, String os) {
		super();
		this.serverName = serverName;
		this.ip = ip;
		this.os = os;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}
	
	

}
