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

    public int setMeetingMinutes(@Param("familyMeetingVO") FamilyMeetingVO familyMeetingVO);

    public int setMeetingInput(@Param("familyMeetingVO") FamilyMeetingVO familyMeetingVO);

		public List<FamilyMeetingVO> getUpcomingMeetings(@Param("familyCode") String familyCode);

		public List<MeetingTopicVO> getProposedTopics(@Param("familyCode") String familyCode, @Param("status") String status);

		public void linkTopicToMeeting(@Param("idx") int idx, @Param("topicIdx") Integer topicIdx);

		public int insertNewTopic(@Param("familyCode") String familyCode, @Param("newTopic") String newTopic, @Param("createdBy") int createdBy);

		public List<MeetingTopicReplyVO> getTopicReplies(@Param("idx") int idx);

		public String setReplyInput(@Param("replyVO") MeetingTopicReplyVO replyVO);

		public int setReplyDelete(@Param("idx") int idx);

		public MeetingTopicVO getTopicByIdx(@Param("idx") int idx);

		public String setTopicUpdate(@Param("topicVO") MeetingTopicVO topicVO);

		public int setTopicDelete(@Param("idx") int idx);
		
		
}