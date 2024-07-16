package com.spring.javaclassS16.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS16.vo.NoticeReadStatusVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;

public interface NoticeDAO {

	public int setNoticeInput(@Param("vo") NoticeVO vo);

	public NoticeVO getNoticeContent(@Param("idx") int idx, @Param("familyCode") String familyCode);

	public int totRecCnt();

	public ArrayList<NoticeVO> getNoticeList(@Param("familyCode") String familyCode, @Param("memberIdx") int memberIdx, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setReadNumPlus(@Param("idx") int idx);

	public NoticeVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str, @Param("familyCode") String familyCode);

	public int setNoticeUpdate(@Param("vo") NoticeVO vo);

	public int setNoticeDelete(@Param("idx") int idx);

	public NoticeReplyVO getNoticeParentReplyCheck(@Param("noticeIdx") int noticeIdx);

	public int setNoticeReplyInput(@Param("replyVO") NoticeReplyVO replyVO);

	public List<NoticeReplyVO> getNoticeReply(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("noticeIdx") int noticeIdx, @Param("re_order") int re_order);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<NoticeVO> getNoticeSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public void setNoticeRead(@Param("idx") int idx, @Param("memberIdx") int memberIdx);

	public NoticeReadStatusVO getReadStatus(@Param("idx") int idx, @Param("memberIdx") int memberIdx);
	
}
