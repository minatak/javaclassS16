package com.spring.javaclassS16.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.VoteOptionVO;
import com.spring.javaclassS16.vo.VoteReplyVO;
import com.spring.javaclassS16.vo.VoteVO;

public interface VoteDAO {

	public ArrayList<VoteVO> getVoteList(@Param("familyCode") String familyCode, @Param("memberIdx") int memberIdx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("choice") String choice);

	public int setVoteInput(@Param("vo") VoteVO vo);

	public void setVoteOption(@Param("idx") int idx, @Param("option") String option);

	public VoteVO getVoteContent(@Param("idx") int idx, @Param("familyCode") String familyCode);

	public List<VoteOptionVO> getVoteOptions(@Param("idx") int idx);

	public boolean hasVoted(@Param("idx") int idx, @Param("memberIdx") int memberIdx);

	public List<VoteOptionVO> getVoteOptionsWithResults(@Param("idx") int idx);

	public List<MemberVO> getVotersForOption(@Param("voteIdx") int voteIdx, @Param("optionIdx") int optionIdx);

	public int setDoVote(@Param("voteIdx") int voteIdx, @Param("memberIdx") int memberIdx, @Param("optionIdx") List<Integer> optionIdx);

	public List<MemberVO> getVoteParticipants(@Param("idx") int idx);

	public List<MemberVO> getNonParticipants(@Param("idx") int idx, @Param("familyCode") String familyCode);

	public int setEndVote(@Param("voteIdx") int voteIdx);

  public int insertVoteParticipation(@Param("voteIdx") int voteIdx, @Param("memberIdx") int memberIdx, @Param("optionIdx") List<Integer> optionIdx);
  
  public int updateVoteOptionCount(@Param("optionIdx") List<Integer> optionIdx);

	public void closeExpiredVotes();

	public void setCancelVote(@Param("voteIdx") int voteIdx, @Param("memberIdx") int memberIdx);

	public int setVoteReplyInput(@Param("replyVO")VoteReplyVO replyVO);

	public List<VoteReplyVO> getVoteReply(@Param("idx") int idx);

	public List<VoteVO> getActiveVotes(@Param("familyCode") String familyCode);

	public int totRecCnt(@Param("familyCode") String familyCode, @Param("choice") String choice, @Param("memberIdx") int memberIdx);

	public int deleteVoteReplies(@Param("voteIdx") int voteIdx);

	public int deleteVoteParticipations(@Param("voteIdx") int voteIdx);

	public int deleteVoteOptions(@Param("voteIdx") int voteIdx);

	public int deleteVote(@Param("voteIdx") int voteIdx);

	
	
}
