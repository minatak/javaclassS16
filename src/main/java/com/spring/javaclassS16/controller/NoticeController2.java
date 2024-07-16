package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS16.pagination.PageProcess;
import com.spring.javaclassS16.service.NoticeService;
import com.spring.javaclassS16.vo.NoticeReadStatusVO;
import com.spring.javaclassS16.vo.NoticeReplyVO;
import com.spring.javaclassS16.vo.NoticeVO;
import com.spring.javaclassS16.vo.PageVO;

//@Controller
//@RequestMapping("/notice")
public class NoticeController2 {
//	
//	@Autowired
//	NoticeService noticeService;
//	
//	@Autowired
//	PageProcess pageProcess;
//	
//	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
//	public String noticeListGet(Model model, HttpSession session,
//	        @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//	        @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//	    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "");
//	    String familyCode = (String) session.getAttribute("sFamCode");
//	    int memberIdx = (int) session.getAttribute("sIdx"); // 세션에서 현재 로그인한 사용자의 idx를 가져옵니다.
//	
//	    ArrayList<NoticeVO> vos = noticeService.getNoticeList(familyCode, memberIdx, pageVO.getStartIndexNo(), pageSize);
//	
//	    model.addAttribute("vos", vos);
//	    model.addAttribute("pageVO", pageVO);
//	
//	    return "notice/noticeList";
//	}
//	
//	@RequestMapping(value = "/noticeInput", method = RequestMethod.GET)
//	public String noticeInputGet(Model model) {
//		return "notice/noticeInput";
//	}
//	
//	@RequestMapping(value = "/noticeInput", method = RequestMethod.POST)
//	public String noticeInputPost(NoticeVO vo) {
//		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 notice폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/notice'폴더로 복사처리)
//		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheck(vo.getContent());
//		
//		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 notice폴더 경로로 변경처리한다.
//		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
//		
//		// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
//		int res = noticeService.setNoticeInput(vo);
//		
//		if(res != 0) return "redirect:/message/noticeInputOk";
//		else  return "redirect:/message/noticeInputNo";
//	}
//	
//	@RequestMapping(value = "/noticeContent", method = RequestMethod.GET)
//	public String noticeContentPost(int idx, Model model, HttpSession session,
//	        @RequestParam(name="flag", defaultValue = "", required = false) String flag,
//	        @RequestParam(name="search", defaultValue = "", required = false) String search,
//	        @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
//	        @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//	        @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//	    
//	    String familyCode = (String) session.getAttribute("sFamCode");
//	    int memberIdx = (int) session.getAttribute("sIdx");
//
//	    // 게시글 조회수 1씩 증가시키기(중복방지)
//	    ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
//	    if(contentReadNum == null) contentReadNum = new ArrayList<String>();
//	    String imsiContentReadNum = "notice" + idx;
//	    if(!contentReadNum.contains(imsiContentReadNum)) {
//	        noticeService.setReadNumPlus(idx);
//	        contentReadNum.add(imsiContentReadNum);
//	    }
//	    session.setAttribute("sContentIdx", contentReadNum);
//
//	    // 공지사항 내용 가져오기
//	    NoticeVO vo = noticeService.getNoticeContent(idx, familyCode);
//	    
//	    // 읽음 상태 업데이트 (읽지 않았던 상태일때만 처리되게)
//	    NoticeReadStatusVO nRSVo = noticeService.getReadStatus(idx, memberIdx);
//	    if(nRSVo == null) noticeService.setNoticeRead(idx, memberIdx);
//
//	    model.addAttribute("vo", vo);
//	    model.addAttribute("flag", flag);
//	    model.addAttribute("search", search);
//	    model.addAttribute("searchString", searchString);
//	    model.addAttribute("pag", pag);
//	    model.addAttribute("pageSize", pageSize);
//
//	    // 이전글/다음글 가져오기
//	    NoticeVO preVo = noticeService.getPreNexSearch(idx, "preVo", familyCode);
//	    NoticeVO nextVo = noticeService.getPreNexSearch(idx, "nextVo", familyCode);
//	    model.addAttribute("preVo", preVo);
//	    model.addAttribute("nextVo", nextVo);
//
//	    // 댓글(대댓글) 추가 입력처리
//	    List<NoticeReplyVO> replyVos = noticeService.getNoticeReply(idx);
//	    
//	    model.addAttribute("replyVos", replyVos);
//
//	    return "notice/noticeContent";
//	}
//	
//	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
//	public String noticeUpdateGet(int idx, Model model, HttpSession session,
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//		String familyCode = (String) session.getAttribute("sFamCode");
//		NoticeVO vo = noticeService.getNoticeContent(idx, familyCode);
//		
//		// 수정화면으로 이동할시에는 기존 원본파일의 그림파일이 존재한다면, 현재폴더(notice)의 그림파일을 ckeditor폴더로 복사시켜준다.
//		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgBackup(vo.getContent());
//		
//		model.addAttribute("pag", pag);
//		model.addAttribute("pageSize", pageSize);
//		model.addAttribute("vo", vo);
//		return "notice/noticeUpdate";
//	}
//	
//	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
//	public String noticeUpdatePost(NoticeVO vo, Model model, HttpSession session,
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//		String familyCode = (String) session.getAttribute("sFamCode");
//		vo.setFamilyCode(familyCode);
//		
//		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다.
//		NoticeVO origVo = noticeService.getNoticeContent(vo.getIdx(), familyCode);
//		
//		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한것이기에, 그림파일 처리유무를 결정한다.
//		if(!origVo.getContent().equals(vo.getContent())) {
//			// 기존 notice폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기전에 ckeditor폴더에 저장시켜두었다.)
//			if(origVo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(origVo.getContent());
//			
//			// 앞의 삭제 작업이 끝나면 'notice'폴더를 'ckeditor'로 경로 변경한다.
//			vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
//			
//			// 파일을 처음 업로드한것과 같은 작업처리를 해준다.
//			// 즉, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 '/data/notice/'폴더에 복사 저장처리한다.
//			if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheck(vo.getContent());
//			
//			// 이미지들의 모든 복사작업을 마치면, 폴더명을 'ckeditor'에서 'notice'폴더로 변경처리한다.
//			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
//			
//			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update 시켜준다.
//		}
//		int res = noticeService.setNoticeUpdate(vo);
//	
//		model.addAttribute("idx", vo.getIdx());
//		model.addAttribute("pag", pag);
//		model.addAttribute("pageSize", pageSize);
//		
//		if(res != 0) return "redirect:/message/noticeUpdateOk";
//		else return "redirect:/message/noticeUpdateNo";
//	}
//	
//	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
//	public String noticeDeleteGet(int idx, HttpSession session,
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//		String familyCode = (String) session.getAttribute("sFamCode");
//		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
//		NoticeVO vo = noticeService.getNoticeContent(idx, familyCode);
//		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
//		
//		// DB에서 실제로 존재하는 게시글을 삭제처리한다.
//		noticeService.setNoticeDelete(idx);
//		
//		return "redirect:/notice/noticeList?pag="+pag+"&pageSize="+pageSize;
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "/noticeReplyInput", method = RequestMethod.POST)
//	public String noticeReplyInputPost(NoticeReplyVO replyVO) {
//		// 댓글의 모든 내용이 정상적으로 저장되면 '1'을, 비정상이면 '0'을 반환시켜준다.
//		int res = noticeService.setNoticeReplyInput(replyVO);
//		
//		return res+"";
//	}
//	
//	/*
//	@ResponseBody
//	@RequestMapping(value = "/noticeReplyDeleteOk", method = RequestMethod.POST)
//	public String noticeReplyDeleteOkPost(int idx) {
//		// 댓글의 삭제처리후 '1'을, 비정상이면 '0'을 반환시켜준다.
//		int res = noticeService.setNoticeReplyDeleteOk(idx);
//		
//		return res+"";
//	}
//	*/
//	
//	// 게시글 검색처리(검색기)
//	@RequestMapping(value = "/noticeSearch")
//	public String noticeSearchGet(Model model, String search,
//			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", search, searchString);
//		
//		List<NoticeVO> vos = noticeService.getNoticeSearchList(pageVO.getStartIndexNo(), pageSize, search, searchString);
//	
//		String searchTitle = "";
//		if(pageVO.getSearh().equals("title")) searchTitle = "글제목";
//		else if(pageVO.getSearh().equals("nickName")) searchTitle = "글쓴이";
//		else searchTitle = "글내용";
//		
//		model.addAttribute("vos", vos);
//		model.addAttribute("pageVO", pageVO);
//		model.addAttribute("searchTitle", searchTitle);
//		model.addAttribute("search", search);
//		model.addAttribute("searchString", searchString);
//		model.addAttribute("searchCount", vos.size());
//		
//		return "notice/noticeSearchList";
//	}
}
