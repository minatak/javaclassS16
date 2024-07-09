package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
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
}