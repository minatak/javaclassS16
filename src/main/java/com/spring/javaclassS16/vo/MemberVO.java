package com.spring.javaclassS16.vo;

import lombok.Data;

//@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String email;
	private String relationship;
	private String birthday;
	private String photo;
	private String family_code;
	private String startDate;
	private int level;
	private String userDel;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getFamily_code() {
		return family_code;
	}
	public void setFamily_code(String family_code) {
		this.family_code = family_code;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getUserDel() {
		return userDel;
	}
	public void setUserDel(String userDel) {
		this.userDel = userDel;
	}
	@Override
	public String toString() {
		return "MemberVO [idx=" + idx + ", mid=" + mid + ", pwd=" + pwd + ", name=" + name + ", email=" + email
				+ ", relationship=" + relationship + ", birthday=" + birthday + ", photo=" + photo + ", family_code="
				+ family_code + ", startDate=" + startDate + ", level=" + level + ", userDel=" + userDel + "]";
	}
	
	
}
