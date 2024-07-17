package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class VoteParticipationVO {
	private int idx;
	private int voteIdx;		// 연관된 투표의 idx 
	private int memberIdx;	// 참여 멤버 idx
	private int optionIdx;	// 옵션 idx
	private String votedAt;	// 투표한 날짜
}