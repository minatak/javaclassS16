package com.spring.javaclassS16.vo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class LocationVO {
    private int idx;
    private int memberIdx;
    private double latitude;
    private double longitude;
    private LocalDateTime updateTime;
    private String address;
    private String memberName;  // 가족 구성원 이름 (조회 시 사용)
}