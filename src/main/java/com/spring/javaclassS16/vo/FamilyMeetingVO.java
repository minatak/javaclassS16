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
  private int recorderIdx;
  private String attendees;
  private String decisions;
  private String actionItems;
  private String notes;
  private int createdBy;
  private String createdAt;
  
}
