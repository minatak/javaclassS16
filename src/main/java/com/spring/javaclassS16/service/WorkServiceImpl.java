package com.spring.javaclassS16.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS16.dao.WorkDAO;
import com.spring.javaclassS16.vo.WorkProgressVO;
import com.spring.javaclassS16.vo.WorkVO;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired
	WorkDAO workDAO;

	@Override
	public List<Map<String, Object>> getWorkList(String familyCode, String category, String status, 
	    String memberFilter, String sortBy, int startIndexNo, int pageSize, int memberIdx) {
		return workDAO.getWorkList(familyCode, category, status, memberFilter, sortBy, startIndexNo, pageSize, memberIdx);
	}
	
	@Override
	public Map<String, Integer> getDashboardData(String familyCode) {
		return workDAO.getDashboardData(familyCode);
	}

	@Override
	public WorkProgressVO getLatestWorkProgress(int idx) {
		return workDAO.getLatestWorkProgress(idx);
	}

	@Override
	public int calculateDaysLeft(String endDate) {
		return workDAO.calculateDaysLeft(endDate);
	}

	@Override
	public List<Map<String, Object>> getFamilyMemberProgress(String familyCode) {
		return workDAO.getFamilyMemberProgress(familyCode);
	}

	@Override
	public WorkVO getTaskDetails(int idx) {
		return workDAO.getTaskDetails(idx);
	}

	@Override
	public List<Map<String, Object>> getMyWorkList(String familyCode, int memberIdx, int startIndexNo, int pageSize) {
		return workDAO.getMyWorkList(familyCode, memberIdx, startIndexNo, pageSize);
	}


	@Override
	public boolean setCompleteTask(int houseworkIdx) {
		return workDAO.setCompleteTask(houseworkIdx);
	}


	@Override
	public int setWorkInput(WorkVO vo) {
		return workDAO.setWorkInput(vo);
	}


	@Override
	public int setWorkUpdate(WorkVO vo) {
		return workDAO.setWorkUpdate(vo);
	}

	@Override
	public int setWorkDelete(int idx) {
		return workDAO.setWorkDelete(idx);
	}

	
}
