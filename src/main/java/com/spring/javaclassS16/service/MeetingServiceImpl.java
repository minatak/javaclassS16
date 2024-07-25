package com.spring.javaclassS16.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.MeetingDAO;
import com.spring.javaclassS16.vo.FamilyMeetingVO;
import com.spring.javaclassS16.vo.MeetingTopicReplyVO;
import com.spring.javaclassS16.vo.MeetingTopicVO;

@Service
public class MeetingServiceImpl implements MeetingService {

	@Autowired
	MeetingDAO meetingDAO;

	@Override
	public ArrayList<FamilyMeetingVO> getMeetingList(String familyCode, int memberIdx, int startIndexNo, int pageSize,
			String statusFilter, String sortBy) {
		return meetingDAO.getMeetingList(familyCode, memberIdx, startIndexNo, pageSize, statusFilter, sortBy);
	}

	@Override
	public int getTotalMeetingsCount(String familyCode) {
		return meetingDAO.getTotalMeetingsCount(familyCode);
	}

	@Override
	public int getCompletedMeetingsCount(String familyCode) {
		return meetingDAO.getCompletedMeetingsCount(familyCode);
	}

	@Override
	public int getUpcomingMeetingsCount(String familyCode) {
		return meetingDAO.getUpcomingMeetingsCount(familyCode);
	}

	@Override
	public int getThisMonthMeetingsCount(String familyCode) {
		return meetingDAO.getThisMonthMeetingsCount(familyCode);
	}

	@Override
	public FamilyMeetingVO getMeetingContent(String familyCode, int idx) {
		return meetingDAO.getMeetingContent(familyCode, idx);
	}

	@Override
	public List<MeetingTopicVO> getMeetingTopics(int meetingIdx) {
		return meetingDAO.getMeetingTopics(meetingIdx);
	}

	@Override
	public int setTopicInput(MeetingTopicVO topicVO) {
		return meetingDAO.setTopicInput(topicVO);
	}

	@Override
	public int setMeetingMinutes(FamilyMeetingVO familyMeetingVO) {
		return meetingDAO.setMeetingMinutes(familyMeetingVO);
	}

	@Override
	public List<FamilyMeetingVO> getUpcomingMeetings(String familyCode) {
		return meetingDAO.getUpcomingMeetings(familyCode);
	}

	@Override
	public List<MeetingTopicVO> getProposedTopics(String familyCode) {
		return meetingDAO.getProposedTopics(familyCode);
	}

	@Override
  public int setMeetingInput(FamilyMeetingVO familyMeetingVO, List<Integer> selectedTopicIdx, List<String> newTopics) {
    int res = meetingDAO.setMeetingInput(familyMeetingVO);
    if (res > 0) {
      if (selectedTopicIdx != null) {
        for (Integer topicIdx : selectedTopicIdx) {
          meetingDAO.linkTopicToMeeting(familyMeetingVO.getIdx(), topicIdx);
        }
      }
      if (newTopics != null) {
        for (String newTopic : newTopics) {
          int newTopicIdx = meetingDAO.insertNewTopic(familyMeetingVO.getFamilyCode(), newTopic, familyMeetingVO.getCreatedBy());
          meetingDAO.linkTopicToMeeting(familyMeetingVO.getIdx(), newTopicIdx);
        }
      }
    }
    return res;
  }

	@Override
	public List<MeetingTopicReplyVO> getTopicReplies(int idx) {
		return meetingDAO.getTopicReplies(idx);
	}
	
	
	
}
