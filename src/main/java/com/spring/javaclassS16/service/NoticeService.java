package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;

public interface NoticeService {

	public int setNoticeInput(NoticeVO vo);

	public NoticeVO getNoticeContent(int idx, String familyCode);

	public ArrayList<NoticeVO> getNoticeList(String familyCode, int memberIdx, int startIndexNo, int pageSize);

	public void setReadNumPlus(int idx);

	public NoticeVO getPreNexSearch(int idx, String str, String familyCode);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setNoticeUpdate(NoticeVO vo);

	public int setNoticeDelete(int idx);

	public NoticeReplyVO getNoticeParentReplyCheck(int noticeIdx);

	public int setNoticeReplyInput(NoticeReplyVO replyVO);

	public List<NoticeReplyVO> getNoticeReply(int idx, String familyCode);

	public void setReplyOrderUpdate(int noticeIdx, int re_order);

	public List<NoticeVO> getNoticeSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public void setNoticeRead(int idx, int memberIdx);

}
