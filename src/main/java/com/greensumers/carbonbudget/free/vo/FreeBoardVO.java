package com.greensumers.carbonbudget.free.vo;

public class FreeBoardVO {
	private int boNo;
	private String boTitle;
	private String boCategory;
	private String boCategoryNm;
	private String boWriter;
	private String boPass;
	private String boContent;
	private int boHit;
	private String boRegDate;
	private String boModeDate;
	
	
	public int getBoNo() {
		return boNo;
	}
	public void setBoNo(int boNo) {
		this.boNo = boNo;
	}
	public String getBoTitle() {
		return boTitle;
	}
	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}
	public String getBoCategory() {
		return boCategory;
	}
	public void setBoCategory(String boCategory) {
		this.boCategory = boCategory;
	}
	public String getBoCategoryNm() {
		return boCategoryNm;
	}
	public void setBoCategoryNm(String boCategoryNm) {
		this.boCategoryNm = boCategoryNm;
	}
	public String getBoWriter() {
		return boWriter;
	}
	public void setBoWriter(String boWriter) {
		this.boWriter = boWriter;
	}
	public String getBoPass() {
		return boPass;
	}
	public void setBoPass(String boPass) {
		this.boPass = boPass;
	}
	public String getBoContent() {
		return boContent;
	}
	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}
	public int getBoHit() {
		return boHit;
	}
	public void setBoHit(int boHit) {
		this.boHit = boHit;
	}
	public String getBoRegDate() {
		return boRegDate;
	}
	public void setBoRegDate(String boRegDate) {
		this.boRegDate = boRegDate;
	}
	public String getBoModeDate() {
		return boModeDate;
	}
	public void setBoModeDate(String boModeDate) {
		this.boModeDate = boModeDate;
	}
	@Override
	public String toString() {
		return "FreeBoardVO [boNo=" + boNo + ", boTitle=" + boTitle + ", boCategory=" + boCategory + ", boCategoryNm="
				+ boCategoryNm + ", boWriter=" + boWriter + ", boPass=" + boPass + ", boContent=" + boContent
				+ ", boHit=" + boHit + ", boRegDate=" + boRegDate + ", boModeDate=" + boModeDate + "]";
	}
	
	
	
	
	
}
