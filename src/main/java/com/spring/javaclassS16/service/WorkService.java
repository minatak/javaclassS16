package com.spring.javaclassS16.service;

import java.util.List;
import java.util.Map;

import com.spring.javaclassS16.vo.WorkProgressVO;
import com.spring.javaclassS16.vo.WorkVO;

public interface WorkService {

	public List<Map<String, Object>> getWorkList(String familyCode, String category, String status, 
	    String memberFilter, String sortBy, int startIndexNo, int pageSize, int memberIdx);

	public Map<String, Integer> getDashboardData(String familyCode);

	public WorkProgressVO getLatestWorkProgress(int idx);

	public int calculateDaysLeft(String endDate);

	public List<Map<String, Object>> getFamilyMemberProgress(String familyCode);

	public WorkVO getTaskDetails(int idx);

	public List<Map<String, Object>> getMyWorkList(String familyCode, int memberIdx, int startIndexNo, int pageSize);

	public boolean setCompleteTask(int houseworkIdx);

	public int setWorkInput(WorkVO vo);

	public int setWorkUpdate(WorkVO vo);

	public int setWorkDelete(int idx);

	public List<WorkVO> getTodayHouseworks(String familyCode);





}
