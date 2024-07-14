package com.spring.javaclassS16.vo;

import lombok.Data;

//@Data
public class CalendarVO {
  private int idx;
  private String title;
  private String description;
  private String startTime;
  private String endTime;
  private boolean allDay;
  private String memberId;
  private String familyCode;
  private boolean sharing;
public int getIdx() {
	return idx;
}
public void setIdx(int idx) {
	this.idx = idx;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public String getStartTime() {
	return startTime;
}
public void setStartTime(String startTime) {
	this.startTime = startTime;
}
public String getEndTime() {
	return endTime;
}
public void setEndTime(String endTime) {
	this.endTime = endTime;
}
public boolean isAllDay() {
	return allDay;
}
public void setAllDay(boolean allDay) {
	this.allDay = allDay;
}
public String getMemberId() {
	return memberId;
}
public void setMemberId(String memberId) {
	this.memberId = memberId;
}
public String getFamilyCode() {
	return familyCode;
}
public void setFamilyCode(String familyCode) {
	this.familyCode = familyCode;
}
public boolean isSharing() {
	return sharing;
}
public void setSharing(boolean sharing) {
	this.sharing = sharing;
}
@Override
public String toString() {
	return "CalendarVO [idx=" + idx + ", title=" + title + ", description=" + description + ", startTime=" + startTime
			+ ", endTime=" + endTime + ", allDay=" + allDay + ", memberId=" + memberId + ", familyCode=" + familyCode
			+ ", sharing=" + sharing + "]";
}
  
  
}