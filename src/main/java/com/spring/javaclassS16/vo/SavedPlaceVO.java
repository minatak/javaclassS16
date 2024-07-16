package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class SavedPlaceVO {
    private int idx;
    private int memberIdx;
    private String familyCode;
    private String placeName;
    private double latitude;
    private double longitude;
    private String address;
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
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "SavedPlaceVO [idx=" + idx + ", memberIdx=" + memberIdx + ", familyCode=" + familyCode + ", placeName="
				+ placeName + ", latitude=" + latitude + ", longitude=" + longitude + ", address=" + address + "]";
	}
    
    
}