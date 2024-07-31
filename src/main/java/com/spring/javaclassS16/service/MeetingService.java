package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicLinkVO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;

public interface MeetingService {
    public ArrayList<FamilyMeetingVO> getMeetingList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String statusFilter, String sortBy);
    
//    public int getTotalMeetingsCount(String familyCode);
//    
//    public int getCompletedMeetingsCount(String familyCode);
//    
//    public int getUpcomingMeetingsCount(String familyCode);
    
    public int getThisMonthMeetingsCount(String familyCode);
    
    public FamilyMeetingVO getMeetingContent(String familyCode, int idx);
    
    public List<MeetingTopicVO> getMeetingTopics(int meetingIdx);
    
    public int setTopicInput(MeetingTopicVO topicVO);
    
    public int setSaveMeeting(FamilyMeetingVO familyMeetingVO);
    
    public int setMeetingInput(FamilyMeetingVO vo);

		public List<FamilyMeetingVO> getUpcomingMeetings(String familyCode);

		public List<MeetingTopicVO> getProposedTopics(String familyCode, String status);

		public List<MeetingTopicReplyVO> getTopicReplies(int idx);

		public String setReplyInput(MeetingTopicReplyVO replyVO);

		public int setReplyDelete(int idx);

		public MeetingTopicVO getTopicByIdx(int idx);

		public int setTopicUpdate(MeetingTopicVO topicVO);

		public int setTopicDelete(int idx);

		public void linkTopicToMeeting(int meetingIdx, int topicIdx);

		public int setNewTopic(String familyCode, String title, String description, int priority, int memberIdx, String memberName);

		public FamilyMeetingVO getMeetingLastIdx();

		public MeetingTopicVO getLastTopic();

		public void updateTopicStatus(int topicIdx);

		public FamilyMeetingVO getMeetingByIdx(int idx);

		public List<Integer> getSelectedTopicIdx(int idx);

		public int setMeetingUpdate(FamilyMeetingVO vo);

		public void setRemoveAllTopicLinks(int meetingIdx);

		public int updateMeetingTopicsStatus(int idx);

		public String truncateStr(String decisions, int maxLength);

		public int setMeetingDelete(int idx);

		public int setMeetingTopicLink(int idx);

		public void setTopicReplyDelete(int idx);

		public void setTopicLinkDelete(int idx);

		public MeetingTopicLinkVO getLinkedTopicByIdx(int idx);


    
}
