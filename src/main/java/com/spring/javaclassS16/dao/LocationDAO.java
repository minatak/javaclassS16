package com.spring.javaclassS16.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS16.vo.LocationVO;
import com.spring.javaclassS16.vo.SavedPlaceVO;

public interface LocationDAO {
    
    // 위치 정보 업데이트
    public int setUpdateLocation(@Param("vo") LocationVO locationVO);
    
    // 가족 구성원들의 위치 정보 조회
    public List<LocationVO> getFamilyLocations(@Param("memberIdx") int memberIdx, @Param("familyCode") String familyCode);
    
    // 현재 위치 정보 조회
    public LocationVO getCurrentLocation(@Param("memberIdx") int memberIdx);
    
    // 위치 히스토리 조회
    public List<LocationVO> getLocationHistory(@Param("memberIdx") int memberIdx, @Param("familyCode") String familyCode, @Param("date") String date);
    
    // 저장된 장소 조회
    public List<SavedPlaceVO> getSavedPlaces(@Param("memberIdx") int memberIdx, @Param("familyCode") String familyCode);
    
    // 장소 저장
    public int setSavePlace(@Param("vo") SavedPlaceVO savedPlace);
    
    // 저장된 장소 삭제
    public int setDeletePlace(@Param("placeIdx") int placeIdx, @Param("memberIdx") int memberIdx, @Param("familyCode") String familyCode);

	public int setInsertLocation(@Param("vo") LocationVO vo);

	public LocationVO getMemberLocation(@Param("memberIdx") int memberIdx);

}