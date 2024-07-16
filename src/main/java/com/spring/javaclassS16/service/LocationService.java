package com.spring.javaclassS16.service;

import java.util.List;
import com.spring.javaclassS16.vo.LocationVO;
import com.spring.javaclassS16.vo.SavedPlaceVO;

public interface LocationService {
  
	public int setUpdateLocation(LocationVO locationVO);
  
  public List<LocationVO> getFamilyLocations(int memberIdx, String familyCode);
  
  public LocationVO getCurrentLocation(int memberIdx);
  
  public List<LocationVO> getLocationHistory(int memberIdx, String familyCode, String date);
  
  public List<SavedPlaceVO> getSavedPlaces(int memberIdx, String familyCode);
  
  public int setSavePlace(SavedPlaceVO savedPlace);
  
  public int setDeletePlace(int placeIdx, int memberIdx, String familyCode);

}