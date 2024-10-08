package com.spring.javaclassS16.service;

import com.spring.javaclassS16.vo.PhotoVO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public interface PhotoService {
    
  public ArrayList<PhotoVO> getPhotoList(int startIndexNo, int pageSize, String familyCode, String choice);
  
  public int setPhotoInput(PhotoVO vo);
  
  public PhotoVO getPhotoContent(int idx);
  
  public ArrayList<PhotoReplyVO> getPhotoReply(int idx);
  
  public String togglePhotoLike(int idx, HttpSession session);
  
  public String setPhotoReplyDelete(int idx);
  
  public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception;
  
  public MemberVO getMemberVoByMid(String mid);

  public MemberVO getWriterPhoto(int idx);
  
  public boolean getPhotoLike(int idx, int memberIdx);

	public int getPhotoReplyCount(int idx);

	public PhotoReplyVO getLatestReply(int idx);

	public PhotoReplyVO getPhotoParentReplyCheck(int photoIdx);

	public int setPhotoReplyInput(PhotoReplyVO vo);

	public PhotoVO getPreNexSearch(int idx, String familyCode, String str);

	public List<MemberVO> getPhotoLikers(int idx);

	public PhotoReplyVO getPhotoReplyVo(int idx);

	public void setPhotoReplyDeleteByParentIdx(int idx);

	public List<String> extractImagePaths(String content);

	public int setPhotoDelete(int idx);

	public void imgDelete(String content);

	public void imgBackup(String content);

	public void imgCheck(String content);

	public int setPhotoUpdate(PhotoVO vo);

	public void deletePhotoReply(int idx);

	public List<PhotoVO> getRecentPhotos(String familyCode);

	public void deletePhotoLike(int idx);

	public void deleteChildPhotoReplies(int idx);

	public void deleteParentPhotoReplies(int idx);

}