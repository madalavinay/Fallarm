package com.fallarm.database;

public class Person_information {
	@Override
	public String toString() {
		return "Person_information [pid=" + pid + ", fname=" + fname + ", lname=" + lname + ", email=" + email
				+ ", phone=" + phone + ", gender=" + gender + ", pwd=" + pwd + ", nurse_id=" + nurse_id + ", deviceid="
				+ deviceid + "]";
	}

	private String pid;
	private String fname;
	private String lname;
	private String email;
	private String phone;
	private char gender;
	private String pwd;
	private String nurse_id;
	private String deviceid;

	public String getDeviceid() {
		return deviceid;
	}

	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNurse_id() {
		return nurse_id;
	}

	public void setNurse_id(String nurse_id) {
		this.nurse_id = nurse_id;
	}

}