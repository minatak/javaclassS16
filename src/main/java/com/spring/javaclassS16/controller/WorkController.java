package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.WorkService;
import com.spring.javaclassS16.vo.PageVO;

@Controller
@RequestMapping("/housework")
public class WorkController {
  
  @Autowired
  WorkService workService;
  
  @Autowired
  PageProcess pageProcess;
  
  @RequestMapping(value = "/workMain", method = RequestMethod.GET)
  public String workMainGet(Model model, HttpSession session,
    @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
    @RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
    @RequestParam(name="flag", required = false) String flag,
    @RequestParam(name="category", required = false) String category,
    @RequestParam(name="status", required = false) String status,
    @RequestParam(name="memberFilter", required = false) String memberFilter,
    @RequestParam(name="sortBy", defaultValue = "dueDate", required = false) String sortBy) {
    
    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "work", "", "", session);
    String familyCode = (String) session.getAttribute("sFamCode");
    int memberIdx = (int) session.getAttribute("sIdx");
    
    // 'undefined' 값 처리
    category = "undefined".equals(category) ? null : category;
    status = "undefined".equals(status) ? null : status;
    memberFilter = "undefined".equals(memberFilter) ? null : memberFilter;
    List<Map<String, Object>> vos = new ArrayList<>();
    
    if (flag != null && flag.equals("mine") && !flag.equals("")) {
      vos = workService.getMyWorkList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize);
    }
    else {
      vos = workService.getWorkList(familyCode, category, status, memberFilter, sortBy, pageVO.getStartIndexNo(), pageSize, memberIdx);
    }
    List<Map<String, Object>> familyMembers = workService.getFamilyMemberProgress(familyCode);
    
    Map<String, Integer> dashboardData = workService.getDashboardData(familyCode);
    
    // 중복 제거된 카테고리 목록 생성
    Set<String> uniqueCategories = new HashSet<>();
    for (Map<String, Object> vo : vos) {
      String taskCategory = (String) vo.get("category");
      if (taskCategory != null && !taskCategory.isEmpty()) {
        uniqueCategories.add(taskCategory);
      }
    }
    List<String> categories = new ArrayList<>(uniqueCategories);
    Collections.sort(categories);  // 카테고리 알파벳 순으로 정렬  
    
    model.addAttribute("vos", vos);
    model.addAttribute("pageVO", pageVO);
    model.addAttribute("category", category);
    model.addAttribute("status", status);
    model.addAttribute("memberFilter", memberFilter);
    model.addAttribute("sortBy", sortBy);
    model.addAttribute("familyMembers", familyMembers);
    model.addAttribute("dashboardData", dashboardData);
    model.addAttribute("categories", categories);  // 중복 제거된 카테고리 목록 추가
    
    return "housework/workMain";
  }
  
  @ResponseBody
  @RequestMapping(value = "/updateTaskStatus", method = RequestMethod.POST)
  public Map<String, Object> updateTaskStatus(@RequestBody Map<String, Object> map) {
    int taskId = (int) map.get("taskId");
    String newStatus = (String) map.get("newStatus");
    int memberId = (int) map.get("memberId");
    
    boolean success = workService.updateTaskStatus(taskId, newStatus, memberId);
    
    Map<String, Object> response = new HashMap<>();
    response.put("success", success);
    return response;
  }
 
  @ResponseBody
  @RequestMapping(value = "/getTaskDetails", method = RequestMethod.GET)
  public Map<String, Object> getTaskDetails(@RequestParam int houseworkIdx, HttpSession session) {
    Map<String, Object> taskDetails = workService.getTaskDetails(houseworkIdx);
    String currentUserId = (String) session.getAttribute("sMid");  // 세션에서 현재 사용자 ID 가져오기
    taskDetails.put("currentUserId", currentUserId);
    return taskDetails;
  }
  
  @ResponseBody
  @RequestMapping(value = "/complete", method = RequestMethod.POST)
  public Map<String, Object> completeTask(@RequestParam int houseworkIdx) {
    boolean success = workService.setCompleteTask(houseworkIdx);
    Map<String, Object> response = new HashMap<>();
    response.put("success", success);
    return response;
  }

  @ResponseBody
  @RequestMapping(value = "/addTask", method = RequestMethod.POST)
  public Map<String, Object> addTask(@RequestBody Map<String, Object> taskData, HttpSession session) {
    Map<String, Object> response = new HashMap<>();
    try {
      String familyCode = (String) session.getAttribute("sFamCode");
      boolean added = workService.addNewTask(taskData, familyCode);
      response.put("success", added);
    } catch (Exception e) {
      response.put("success", false);
      response.put("error", "Error adding new task");
    }
    return response;
  }

  
}
