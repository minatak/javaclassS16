package com.spring.javaclassS16.dao;

import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;

public interface MeetingDAO {
    public ArrayList<FamilyMeetingVO> getMeetingList(@Param("familyCode") String familyCode, @Param("memberIdx") int memberIdx, 
  		@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("statusFilter") String statusFilter, @Param("sortBy") String sortBy);

    public int getTotalMeetingsCount(@Param("familyCode") String familyCode);

    public int getCompletedMeetingsCount(@Param("familyCode") String familyCode);

    public int getUpcomingMeetingsCount(@Param("familyCode") String familyCode);

    public int getThisMonthMeetingsCount(@Param("familyCode") String familyCode);

    public FamilyMeetingVO getMeetingContent(@Param("familyCode") String familyCode, @Param("idx") int idx);

    public List<MeetingTopicVO> getMeetingTopics(@Param("meetingIdx") int meetingIdx);

    public int setTopicInput(@Param("topicVO") MeetingTopicVO topicVO);

    public int setSaveMeeting(@Param("familyMeetingVO") FamilyMeetingVO familyMeetingVO);

    public int setMeetingInput(@Param("vo") FamilyMeetingVO vo);

		public List<FamilyMeetingVO> getUpcomingMeetings(@Param("familyCode") String familyCode);

		public List<MeetingTopicVO> getProposedTopics(@Param("familyCode") String familyCode, @Param("status") String status);

		public void linkTopicToMeeting(@Param("meetingIdx") int meetingIdx, @Param("topicIdx") int topicIdx);

		public int setNewTopic(@Param("familyCode") String familyCode, @Param("title") String title, @Param("description") String description, @Param("priority") int priority, @Param("memberIdx") int memberIdx, @Param("memberName") String memberName);

		public List<MeetingTopicReplyVO> getTopicReplies(@Param("idx") int idx);

		public String setReplyInput(@Param("replyVO") MeetingTopicReplyVO replyVO);

		public int setReplyDelete(@Param("idx") int idx);

		public MeetingTopicVO getTopicByIdx(@Param("idx") int idx);

		public String setTopicUpdate(@Param("topicVO") MeetingTopicVO topicVO);

		public int setTopicDelete(@Param("idx") int idx);

		public FamilyMeetingVO getMeetingLastIdx();

		public MeetingTopicVO getLastTopic();

		public void updateTopicStatus(@Param("topicIdx") int topicIdx);

		public FamilyMeetingVO getMeetingByIdx(@Param("idx") int idx);

		public List<Integer> getSelectedTopicIdx(@Param("idx") int idx);

		public int setMeetingUpdate(@Param("vo") FamilyMeetingVO vo);

		public void setRemoveAllTopicLinks(@Param("meetingIdx") int meetingIdx);

		public int updateMeetingTopicsStatus(@Param("idx") int idx);

		public int totRecCnt(@Param("familyCode") String familyCode, @Param("searchString") String searchString);

		
		
}