package com.spring.javaclassS16.service;

import com.spring.javaclassS16.vo.PhotoVO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public interface PhotoService {
	
	public ArrayList<PhotoVO> getPhotoList(int startIndexNo, int pageSize, String familyCode, String part, String choice);
	
	public int setPhotoInput(PhotoVO vo);
	
	public PhotoVO getPhotoContent(int idx);
	
	public ArrayList<PhotoReplyVO> getPhotoReply(int idx);
	
	public String setPhotoGoodCheck(int idx, HttpSession session);
	
	public String setPhotoReplyInput(PhotoReplyVO vo);
	
	public String setPhotoReplyDelete(int idx);
	
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception;

	public MemberVO getMemberVoByMid(String mid);

}