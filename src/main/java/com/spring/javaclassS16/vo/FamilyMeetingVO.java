package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class FamilyMeetingVO {
	private int idx;
  private String familyCode;
  private String title;
  private String description;
  private String meetingDate;
  private String status;
  private int duration;
  private String location;
  private int facilitatorIdx;
  private String facilitatorName;
  private int recorderIdx;
  private String recorderName;
  private String attendees;
  private String decisions;
  private String actionItems;
  private String notes;
  private int createdBy; // 회의 등록자 idx
  private String createdAt;
  
}
