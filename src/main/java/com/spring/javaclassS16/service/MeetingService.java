package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;

public interface MeetingService {
    public ArrayList<FamilyMeetingVO> getMeetingList(String familyCode, int memberIdx, int startIndexNo, int pageSize, String statusFilter, String sortBy);
    
    public int getTotalMeetingsCount(String familyCode);
    
    public int getCompletedMeetingsCount(String familyCode);
    
    public int getUpcomingMeetingsCount(String familyCode);
    
    public int getThisMonthMeetingsCount(String familyCode);
    
    public FamilyMeetingVO getMeetingContent(String familyCode, int idx);
    
    public List<MeetingTopicVO> getMeetingTopics(int meetingIdx);
    
    public int setTopicInput(MeetingTopicVO topicVO);
    
    public int setMeetingMinutes(FamilyMeetingVO familyMeetingVO);
    
    public int setMeetingInput(FamilyMeetingVO familyMeetingVO, List<Integer> selectedTopicIdx, List<String> newTopics);

		public List<FamilyMeetingVO> getUpcomingMeetings(String familyCode);

		public List<MeetingTopicVO> getProposedTopics(String familyCode);

		public List<MeetingTopicReplyVO> getTopicReplies(int idx);


    
}
