package com.spring.javaclassS16.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.service.PhotoService;
import com.spring.javaclassS16.vo.PhotoVO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
@RequestMapping("/photo")
public class PhotoController {

    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/photoList", method = RequestMethod.GET)
    public String photoList(Model model,
                            HttpSession session,
                            @RequestParam(defaultValue = "1") int pag,
                            @RequestParam(defaultValue = "16") int pageSize,
                            @RequestParam(defaultValue = "전체") String part,
                            @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, part, choice);
        
        model.addAttribute("vos", vos);
        model.addAttribute("part", part);
        model.addAttribute("choice", choice);
        return "photo/photoList";
    }

    @RequestMapping(value = "/photoInput", method = RequestMethod.GET)
    public String photoInputForm() {
        return "photo/photoInput";
    }

    @RequestMapping(value = "/photoInput", method = RequestMethod.POST)
    public String photoInputProcess(PhotoVO vo, HttpServletRequest request, HttpSession session) {
        String mid = (String) session.getAttribute("sMid");
        String familyCode = (String) session.getAttribute("sFamCode");
        
        MemberVO mVo = photoService.getMemberVoByMid(mid);
        
        vo.setMemberIdx(mVo.getIdx());
        vo.setName(mVo.getName());
        vo.setFamilyCode(familyCode);
        
        int res = photoService.setPhotoInput(vo);
        
        if(res != 0) return "redirect:/message/photoInputOk";
        else return "redirect:/message/photoInputNo";
    }

    @RequestMapping(value = "/photoContent", method = RequestMethod.GET)
    public String photoContent(@RequestParam int idx, Model model, HttpSession session) {
        
    	PhotoVO vo = photoService.getPhotoContent(idx);
      if (vo == null) {
          // 해당 idx의 데이터가 없는 경우 처리
          return "redirect:/photo/photoList";
      }
      
      ArrayList<PhotoReplyVO> replyVos = photoService.getPhotoReply(idx);
      model.addAttribute("vo", vo);
      model.addAttribute("replyVos", replyVos);
      return "photo/photoContent";
    }

    @ResponseBody
    @RequestMapping(value = "/photoGoodCheck", method = RequestMethod.POST)
    public String photoGoodCheck(@RequestParam int idx, HttpSession session) {
        return photoService.setPhotoGoodCheck(idx, session);
    }

    @ResponseBody
    @RequestMapping(value = "/photoReplyInput", method = RequestMethod.POST)
    public String photoReplyInput(PhotoReplyVO vo) {
        return photoService.setPhotoReplyInput(vo);
    }

    @ResponseBody
    @RequestMapping(value = "/photoReplyDelete", method = RequestMethod.POST)
    public String photoReplyDelete(@RequestParam int idx) {
    	return photoService.setPhotoReplyDelete(idx);
    }

    @ResponseBody
    @RequestMapping("/imageUpload")
    public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception {
        photoService.imageUpload(request, response, upload);
    }
}