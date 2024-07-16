package com.spring.javaclassS16.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class LocationVO {
    private int idx;
    private int memberIdx;
    private String familyCode;
    private double latitude;
    private double longitude;
    private LocalDateTime updateTime;
    private String address;
    
    private String name;  // 가족 구성원 이름 (조회 시 사용)
    private String photo;  // 가족 구성원 사진 (조회 시 사용)
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getFamilyCode() {
		return familyCode;
	}
	public void setFamilyCode(String familyCode) {
		this.familyCode = familyCode;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public LocalDateTime getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(LocalDateTime updateTime) {
		this.updateTime = updateTime;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	@Override
	public String toString() {
		return "LocationVO [idx=" + idx + ", memberIdx=" + memberIdx + ", familyCode=" + familyCode + ", latitude="
				+ latitude + ", longitude=" + longitude + ", updateTime=" + updateTime + ", address=" + address
				+ ", name=" + name + ", photo=" + photo + "]";
	}
    
    
    
    
}