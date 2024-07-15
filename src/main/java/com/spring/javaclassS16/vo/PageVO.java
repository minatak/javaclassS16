package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PageVO {
	private int pag;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int blockSize;
	private int curBlock;
	private int lastBlock;
	
	private String searh;
	private String searchString;
	private String part;
	public int getPag() {
		return pag;
	}
	public void setPag(int pag) {
		this.pag = pag;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotRecCnt() {
		return totRecCnt;
	}
	public void setTotRecCnt(int totRecCnt) {
		this.totRecCnt = totRecCnt;
	}
	public int getTotPage() {
		return totPage;
	}
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
	public int getStartIndexNo() {
		return startIndexNo;
	}
	public void setStartIndexNo(int startIndexNo) {
		this.startIndexNo = startIndexNo;
	}
	public int getCurScrStartNo() {
		return curScrStartNo;
	}
	public void setCurScrStartNo(int curScrStartNo) {
		this.curScrStartNo = curScrStartNo;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getCurBlock() {
		return curBlock;
	}
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	public int getLastBlock() {
		return lastBlock;
	}
	public void setLastBlock(int lastBlock) {
		this.lastBlock = lastBlock;
	}
	public String getSearh() {
		return searh;
	}
	public void setSearh(String searh) {
		this.searh = searh;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	@Override
	public String toString() {
		return "PageVO [pag=" + pag + ", pageSize=" + pageSize + ", totRecCnt=" + totRecCnt + ", totPage=" + totPage
				+ ", startIndexNo=" + startIndexNo + ", curScrStartNo=" + curScrStartNo + ", blockSize=" + blockSize
				+ ", curBlock=" + curBlock + ", lastBlock=" + lastBlock + ", searh=" + searh + ", searchString="
				+ searchString + ", part=" + part + "]";
	}
	
	
}
