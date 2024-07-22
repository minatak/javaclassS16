package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class WorkProgressVO {
	private int idx;
  private int houseworkIdx;
  private int memberIdx;
  private String memberName;
  private String completionDate;
  private String status;
}