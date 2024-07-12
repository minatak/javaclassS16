package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class PhotoLikesVO {
  private int idx;            // 좋아요 고유번호
  private int photoIdx;       // 좋아요 눌린 사진의 고유번호 
  private int memberIdx;      // 좋아요 누른 회원의 idx

}