package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.VoteOptionVO;
import com.spring.javaclassS16.vo.VoteReplyVO;
import com.spring.javaclassS16.vo.VoteVO;

public interface VoteService {

	public ArrayList<VoteVO> getVoteList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String choice);

	public int setVoteInput(VoteVO vo, List<String> options);

	public VoteVO getVoteContent(int idx, String familyCode);

	public List<VoteOptionVO> getVoteOptions(int idx);

	public boolean hasVoted(int idx, int memberIdx);

	public List<VoteOptionVO> getVoteOptionsWithResults(int idx);

	public int setDoVote(int voteIdx, int memberIdx, List<Integer> optionIdx);

	public List<MemberVO> getVoteParticipants(int idx);

	public List<MemberVO> getNonParticipants(int idx, String familyCode);

	public int setEndVote(int voteIdx);

	public void closeExpiredVotes();

	public void setCancelVote(int voteIdx, int memberIdx);

	public int setVoteReplyInput(VoteReplyVO replyVO);

	public List<VoteReplyVO> getVoteReply(int idx);

	public List<VoteVO> getActiveVotes(String familyCode);

	public boolean setDeleteVote(int idx);

	public int setVoteUpdate(VoteVO vo, List<String> options, List<Integer> deletedOptions);

//	public int deleteVoteParticipation(int voteIdx, int memberIdx);

	public int setCancelAndResetVote(int voteIdx, int memberIdx);

	public int setReplyDelete(int idx);

	public VoteReplyVO getVoteReplyVo(int idx);

	public void setReplyDeleteByParentIdx(int idx);

}
