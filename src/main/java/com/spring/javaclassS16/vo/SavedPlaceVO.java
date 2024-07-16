package com.spring.javaclassS16.vo;

import lombok.Data;

@Data
public class SavedPlaceVO {
    private int idx;
    private int memberIdx;
    private String familyCode;
    private String placeName;
    private double latitude;
    private double longitude;
    private String address;
    
}