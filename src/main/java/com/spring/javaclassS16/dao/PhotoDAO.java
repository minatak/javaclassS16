package com.spring.javaclassS16.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.PhotoReplyVO;
import com.spring.javaclassS16.vo.PhotoVO;


public interface PhotoDAO {
    
	ArrayList<PhotoVO> getPhotoList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("familyCode") String familyCode, @Param("part") String part, @Param("choice") String choice);
  
  public int setPhotoInput(@Param("vo") PhotoVO vo);
  
  public void setPhotoReadNumPlus(@Param("idx") int idx);
  
  public PhotoVO getPhotoContent(@Param("idx") int idx);
  
  public ArrayList<PhotoReplyVO> getPhotoReply(@Param("idx") int idx);
  
  public void setPhotoGoodCheck(@Param("idx") int idx);
  
  public int setPhotoReplyInput(@Param("vo") PhotoReplyVO vo);
  
  public int setPhotoReplyDelete(@Param("idx") int idx);

  public MemberVO getMemberIdxByMid(@Param("mid") String mid);
    
}