package com.spring.javaclassS16.dao;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import com.spring.javaclassS16.vo.PhotoVO;

public interface PhotoDAO {
    
  ArrayList<PhotoVO> getPhotoList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("familyCode") String familyCode, @Param("choice") String choice);
  
  public int setPhotoInput(@Param("vo") PhotoVO vo);
  
  public void setPhotoReadNumPlus(@Param("idx") int idx);
  
  public PhotoVO getPhotoContent(@Param("idx") int idx);
  
  public ArrayList<PhotoReplyVO> getPhotoReply(@Param("idx") int idx);
  
  public boolean getPhotoLike(@Param("idx") int idx, @Param("memberIdx") int memberIdx);
  
  public void addPhotoLike(@Param("idx") int idx, @Param("memberIdx") int memberIdx);
  
  public void removePhotoLike(@Param("idx") int idx, @Param("memberIdx") int memberIdx);
  
  public void increasePhotoLikeCount(@Param("idx") int idx);
  
  public void decreasePhotoLikeCount(@Param("idx") int idx);
  
  public int setPhotoReplyDelete(@Param("idx") int idx);
  
  public MemberVO getMemberVoByMid(@Param("mid") String mid);
  
  public MemberVO getWriterPhoto(@Param("idx") int idx);

	public int getPhotoReplyCount(@Param("idx") int idx);

	public PhotoReplyVO getLatestReply(@Param("idx") int idx);

	public PhotoReplyVO getPhotoParentReplyCheck(@Param("photoIdx") int photoIdx);

	public int setPhotoReplyInput(@Param("replyVO") PhotoReplyVO replyVO);

	public void setReplyOrderUpdate(@Param("photoIdx") int photoIdx, @Param("re_order") int re_order);

	public PhotoVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str);
  
}