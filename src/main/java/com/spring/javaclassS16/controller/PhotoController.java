package com.spring.javaclassS16.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS16.service.PhotoService;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import com.spring.javaclassS16.vo.PhotoVO;

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
                            @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, choice);
        
        model.addAttribute("vos", vos);
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
      
      MemberVO mVo = photoService.getWriterPhoto(vo.getMemberIdx());
      String photo = mVo.getPhoto();
      String mid = (String) session.getAttribute("sMid");
      boolean isLiked = photoService.checkPhotoLike(idx, mid);
      
      int replyCnt = photoService.getPhotoReplyCount(idx);
      
      vo.setMid(mVo.getMid());
      model.addAttribute("isLiked", isLiked);
      model.addAttribute("vo", vo);
      model.addAttribute("replyVos", replyVos);
      model.addAttribute("photo", photo);
      model.addAttribute("replyCnt", replyCnt);
      return "photo/photoContent";
    }

    @ResponseBody
    @RequestMapping(value = "/photoToggleLike", method = RequestMethod.POST)
    public String photoToggleLike(@RequestParam int idx, HttpSession session) {
        return photoService.togglePhotoLike(idx, session);
    }

    @ResponseBody
    @RequestMapping(value = "/photoReplyInput", method = RequestMethod.POST)
    public String photoReplyInput(PhotoReplyVO vo, HttpSession session) {
        String memberMid = (String) session.getAttribute("sMid");
        MemberVO mVo = photoService.getMemberVoByMid(memberMid);
        
        vo.setMemberIdx(mVo.getIdx());
        
        System.out.println("댓글vo : " + vo);
        
        String res = photoService.setPhotoReplyInput(vo);
        return res;
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
    
    // 싱글 사진 보기
    @RequestMapping(value = "/photoSingle", method = RequestMethod.GET)
    public String photoSingle(Model model,
                              HttpSession session,
                              @RequestParam(defaultValue = "1") int pag,
                              @RequestParam(defaultValue = "5") int pageSize,
                              @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, choice);
        
        model.addAttribute("vos", vos);
        return "photo/photoSingle";
    }

    @ResponseBody
    @RequestMapping(value = "/photoSinglePaging", method = RequestMethod.POST)
    public String photoSinglePaging(Model model,
                                    HttpSession session,
                                    @RequestParam(defaultValue = "1") int pag,
                                    @RequestParam(defaultValue = "5") int pageSize,
                                    @RequestParam(defaultValue = "최신순") String choice) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int startIndexNo = (pag - 1) * pageSize;
        
        ArrayList<PhotoVO> vos = photoService.getPhotoList(startIndexNo, pageSize, familyCode, choice);
        
        model.addAttribute("vos", vos);
        return "photo/photoSinglePaging";
    }
}