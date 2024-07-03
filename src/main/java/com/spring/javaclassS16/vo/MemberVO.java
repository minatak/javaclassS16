package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
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
}
