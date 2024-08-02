package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.NoticeReadStatusVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;

public interface NoticeService {
	
	public int setNoticeInput(NoticeVO vo);
	
	public NoticeVO getNoticeContent(int idx);
	
	public ArrayList<NoticeVO> getNoticeList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String choice);
	
	public void setReadNumPlus(int idx);
	
	public NoticeVO getPreNexSearch(int idx, String str, String familyCode);
	
	public void imgCheck(String content);
	
	public void imgBackup(String content);
	
	public void imgDelete(String content);
	
	public int setNoticeUpdate(NoticeVO vo);
	
	public int setNoticeDelete(int idx);
	
	public int setNoticeReplyInput(NoticeReplyVO replyVO);
	
	public List<NoticeReplyVO> getNoticeReply(int idx);
	
	public List<NoticeVO> getNoticeSearchList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String search, String searchString, String choice);
	
	public void setNoticeRead(int idx, int memberIdx);
	
	public NoticeReadStatusVO getReadStatus(int idx, int memberIdx);
	
	public NoticeReplyVO getNoticeReplyVo(int idx);
	
	public void setNoticeReplyDeleteByParentIdx(int idx);
	
	public String setNoticeReplyDelete(int idx);
	
	public String toggleNoticeLike(int idx, int memberIdx);

	public boolean getNoticeLike(int idx, int memberIdx);

	public List<MemberVO> getNoticeLikers(int idx);

	public List<NoticeVO> getRecentNotices(String familyCode);

	public int getTotalSearchCount(String familyCode, String search, String searchString);

	public void deleteNoticeReadStatus(int idx);

	public void deleteNoticeLikes(int idx);

	public void deleteNoticeReplies(int idx);
	
}