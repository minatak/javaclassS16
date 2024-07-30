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
	public int setSaveMeeting(FamilyMeetingVO familyMeetingVO) {
		return meetingDAO.setSaveMeeting(familyMeetingVO);
	}

	@Override
	public List<FamilyMeetingVO> getUpcomingMeetings(String familyCode) {
		return meetingDAO.getUpcomingMeetings(familyCode);
	}

	@Override
	public List<MeetingTopicVO> getProposedTopics(String familyCode, String status) {
		return meetingDAO.getProposedTopics(familyCode, status);
	}

	@Override
	public List<MeetingTopicReplyVO> getTopicReplies(int idx) {
		return meetingDAO.getTopicReplies(idx);
	}

	@Override
	public String setReplyInput(MeetingTopicReplyVO replyVO) {
		return meetingDAO.setReplyInput(replyVO);
	}

	@Override
	public int setReplyDelete(int idx) {
		return meetingDAO.setReplyDelete(idx);
	}

	@Override
	public MeetingTopicVO getTopicByIdx(int idx) {
		return meetingDAO.getTopicByIdx(idx);
	}

	@Override
	public String setTopicUpdate(MeetingTopicVO topicVO) {
		return meetingDAO.setTopicUpdate(topicVO);
	}

	@Override
	public int setTopicDelete(int idx) {
		return meetingDAO.setTopicDelete(idx);
	}

	@Override
	public int setMeetingInput(FamilyMeetingVO vo) {
		return meetingDAO.setMeetingInput(vo);
	}

	@Override
	public void linkTopicToMeeting(int meetingIdx, int topicIdx) {
		meetingDAO.linkTopicToMeeting(meetingIdx, topicIdx);		
	}

	@Override
	public int setNewTopic(String familyCode, String title, String description, int priority, int memberIdx, String memberName) {
	  return meetingDAO.setNewTopic(familyCode, title, description, priority, memberIdx, memberName);
	}

	@Override
	public FamilyMeetingVO getMeetingLastIdx() {
		return meetingDAO.getMeetingLastIdx();
	}

	@Override
	public MeetingTopicVO getLastTopic() {
		return meetingDAO.getLastTopic();
	}

	@Override
	public void updateTopicStatus(int topicIdx) {
		meetingDAO.updateTopicStatus(topicIdx);
	}

	@Override
	public FamilyMeetingVO getMeetingByIdx(int idx) {
		return meetingDAO.getMeetingByIdx(idx);
	}

	@Override
	public List<Integer> getSelectedTopicIdx(int idx) {
		return meetingDAO.getSelectedTopicIdx(idx);
	}

	@Override
	public int setMeetingUpdate(FamilyMeetingVO vo) {
		return meetingDAO.setMeetingUpdate(vo);
	}

	@Override
	public void setRemoveAllTopicLinks(int meetingIdx) {
		meetingDAO.setRemoveAllTopicLinks(meetingIdx);
	}

	@Override
	public int updateMeetingTopicsStatus(int idx) {
		return meetingDAO.updateMeetingTopicsStatus(idx);
	}
	
	
	
}
