package com.fallarm.database;

import java.io.Serializable;
import java.util.Date;

public class Device_data implements Serializable{
	@Override
	public String toString() {
		return "Device_data [pid=" + pid + ", deviceid=" + deviceid + ", g1=" + g1 + ", g2=" + g2 + ", g3=" + g3
				+ ", a1=" + a1 + ", a2=" + a2 + ", a3=" + a3 + ", x=" + x + ", y=" + y + ", time=" + time
				+ ", severity=" + severity + ", comments=" + comments + "]";
	}
	private static final long serialVersionUID = 1L;
	private String pid;
	private String deviceid;
	private double g1;
	private double g2;
	private double g3;
	private double a1;
	private double a2;
	private double a3;
	private double x;
	private double y;
	private Date time;
	private int severity;
	private String comments;
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getDeviceid() {
		return deviceid;
	}
	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}
	public double getG1() {
		return g1;
	}
	public void setG1(double g1) {
		this.g1 = g1;
	}
	public double getG2() {
		return g2;
	}
	public void setG2(double g2) {
		this.g2 = g2;
	}
	public double getG3() {
		return g3;
	}
	public void setG3(double g3) {
		this.g3 = g3;
	}
	public double getA1() {
		return a1;
	}
	public void setA1(double a1) {
		this.a1 = a1;
	}
	public double getA2() {
		return a2;
	}
	public void setA2(double a2) {
		this.a2 = a2;
	}
	public double getA3() {
		return a3;
	}
	public void setA3(double a3) {
		this.a3 = a3;
	}
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x = x;
	}
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y = y;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getSeverity() {
		return severity;
	}
	public void setSeverity(int severity) {
		this.severity = severity;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}

}