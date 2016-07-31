package com.fallarm.database;

import java.io.Serializable;

public class Popup implements Serializable {
	@Override
	public String toString() {
		return "Popup [datafrom=" + datafrom + ", datato=" + datato + "]";
	}

	private static final long serialVersionUID = 1L;
	private String datafrom;
	private String datato;

	public void setDatafrom(String datafrom) {
		this.datafrom = datafrom;
	}

	public String getDatafrom() {
		return datafrom;
	}

	public void setDatato(String datato) {
		this.datato = datato;
	}

	public String getDatato() {
		return datato;
	}
}
