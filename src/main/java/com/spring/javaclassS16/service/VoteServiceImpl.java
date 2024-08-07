package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaclassS16.dao.VoteDAO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.VoteOptionVO;
import com.spring.javaclassS16.vo.VoteReplyVO;
import com.spring.javaclassS16.vo.VoteVO;

@Service
public class VoteServiceImpl implements VoteService {

	@Autowired
	VoteDAO voteDAO;
	
	@Override
	public ArrayList<VoteVO> getVoteList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String choice) {
		return voteDAO.getVoteList(familyCode, memberIdx, startIndexNo, pageSize, choice);
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
	
//	public int setDoVote(int voteIdx, int memberIdx, List<Integer> optionIdx) {
//	    int result = 0;
//	    for (Integer optIdx : optionIdx) {
//	        result += voteDAO.insertVoteParticipation(voteIdx, memberIdx, optIdx);
//	        voteDAO.increaseVoteCount(optIdx);
//	    }
//	    return result;
//	}

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

	@Override
	public void closeExpiredVotes() {
		voteDAO.closeExpiredVotes();
	}

	@Override
	public void setCancelVote(int voteIdx, int memberIdx) {
		voteDAO.setCancelVote(voteIdx, memberIdx);
	}

	@Override
	public int setVoteReplyInput(VoteReplyVO replyVO) {
		return voteDAO.setVoteReplyInput(replyVO);
	}

	@Override
	public List<VoteReplyVO> getVoteReply(int idx) {
		return voteDAO.getVoteReply(idx);
	}

	@Override
	public List<VoteVO> getActiveVotes(String familyCode) {
		return voteDAO.getActiveVotes(familyCode);
	}

	@Override
	@Transactional
	public boolean setDeleteVote(int voteIdx) {
    // 투표에 속한 모든 댓글 가져오기
    List<VoteReplyVO> replies = voteDAO.getVoteReply(voteIdx);
    
    // 부모 댓글 먼저 삭제 (이 과정에서 대댓글도 함께 삭제됨)
    for (VoteReplyVO reply : replies) {
      if (reply.getParentIdx() == null) {
        voteDAO.setReplyDeleteByParentIdx(reply.getIdx());
        voteDAO.setReplyDelete(reply.getIdx());
      }
    }
    
    // 투표 참여 기록 삭제
    voteDAO.deleteVoteParticipations(voteIdx);
    
    // 투표 옵션 삭제
    voteDAO.deleteVoteOptions(voteIdx);
    
    // 투표 삭제
    int voteResult = voteDAO.deleteVote(voteIdx);
    
    return voteResult > 0;
	}

	@Override
	@Transactional
	public int setVoteUpdate(VoteVO vo, List<String> options, List<Integer> deletedOptions) {
	    int res = voteDAO.setVoteUpdate(vo);
	    
	    if (deletedOptions != null && !deletedOptions.isEmpty()) {
	        for (int optionIdx : deletedOptions) {
	            voteDAO.deleteVoteOption(optionIdx);
	        }
	    }
	    
	    List<VoteOptionVO> existingOptions = voteDAO.getVoteOptions(vo.getIdx());
	    int existingOptionCount = existingOptions.size();
	    
	    for (int i = 0; i < options.size(); i++) {
	        if (i < existingOptionCount) {
	            voteDAO.updateVoteOption(existingOptions.get(i).getIdx(), options.get(i));
	        } else {
	            voteDAO.insertVoteOption(vo.getIdx(), options.get(i));
	        }
	    }
	    return res;
	}

	@Override
	@Transactional
	public int setCancelAndResetVote(int voteIdx, int memberIdx) {
    // 1. 현재 사용자의 투표 옵션 조회
    List<VoteOptionVO> vos = voteDAO.getVotedOptions(voteIdx, memberIdx);
    
    // 2. voteParticipation 테이블에서 해당 투표 삭제
    int deleteResult = voteDAO.deleteVoteParticipation(voteIdx, memberIdx);
    
    // 3. voteOption 테이블의 voteCount 감소
    for (VoteOptionVO vo : vos) {
      voteDAO.setDecreaseVoteCount(vo.getIdx());
    }
    
    return deleteResult;
	}

	@Override
	public int setReplyDelete(int idx) {
		return voteDAO.setReplyDelete(idx);
	}

	@Override
	public VoteReplyVO getVoteReplyVo(int idx) {
		return voteDAO.getVoteReplyVo(idx);
	}

	@Override
	public void setReplyDeleteByParentIdx(int idx) {
		voteDAO.setReplyDeleteByParentIdx(idx);
	}

//	@Override
//	public int deleteVoteParticipation(int voteIdx, int memberIdx) {
//		return voteDAO.deleteVoteParticipation(voteIdx, memberIdx);
//	}

	
	
}
