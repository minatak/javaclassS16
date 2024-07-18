package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaclassS16.dao.VoteDAO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.VoteOptionVO;
import com.spring.javaclassS16.vo.VoteVO;

@Service
public class VoteServiceImpl implements VoteService {

	@Autowired
	VoteDAO voteDAO;
	
	@Override
	public ArrayList<VoteVO> getVoteList(String familyCode, int memberIdx, int startIndexNo, int pageSize) {
		return voteDAO.getVoteList(familyCode, memberIdx, startIndexNo, pageSize);
	}

	@Override
  @Transactional
  public int setVoteInput(VoteVO vo, List<String> options) {
    int res = voteDAO.setVoteInput(vo);
    if (res != 0) {
      for (String option : options) {
      	voteDAO.setVoteOption(vo.getIdx(), option);
      }
    }
    return res;
  }

	@Override
	public VoteVO getVoteContent(int idx, String familyCode) {
		return voteDAO.getVoteContent(idx, familyCode);
	}

	@Override
	public List<VoteOptionVO> getVoteOptions(int idx) {
		return voteDAO.getVoteOptions(idx);
	}

	@Override
	public boolean hasVoted(int idx, int memberIdx) {
		return voteDAO.hasVoted(idx, memberIdx);
	}

	@Override
	public List<VoteOptionVO> getVoteOptionsWithResults(int voteIdx) {
    List<VoteOptionVO> options = voteDAO.getVoteOptionsWithResults(voteIdx);
    for (VoteOptionVO option : options) {
      option.setVoters(voteDAO.getVotersForOption(voteIdx, option.getIdx()));
    }
    return options;
	}

	@Override
  @Transactional
  public int setDoVote(int voteIdx, int memberIdx, List<Integer> optionIdx) {
	  int insertResult = voteDAO.insertVoteParticipation(voteIdx, memberIdx, optionIdx);
	  int updateResult = voteDAO.updateVoteOptionCount(optionIdx);
	  
	  if (insertResult > 0 && updateResult > 0) {
      return 1;  // 성공
	  } else {
	  	return 0;  // 실패
	  }
	}

	@Override
	public List<MemberVO> getVoteParticipants(int idx) {
		return voteDAO.getVoteParticipants(idx);
	}

	@Override
	public List<MemberVO> getNonParticipants(int idx, String familyCode) {
		return voteDAO.getNonParticipants(idx, familyCode);
	}

	@Override
	public int setEndVote(int voteIdx) {
		return voteDAO.setEndVote(voteIdx);
	}

	
	
}
