package com.spring.javaclassS16.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.javaclassS16.dao.LocationDAO;
import com.spring.javaclassS16.vo.LocationVO;
import com.spring.javaclassS16.vo.SavedPlaceVO;

@Service
public class LocationServiceImpl implements LocationService {
    @Autowired
    LocationDAO locationDAO;
    
    @Override
    public int setUpdateLocation(LocationVO vo) {
      LocationVO existingLocation = locationDAO.getCurrentLocation(vo.getMemberIdx());
      if (existingLocation == null) {
          return locationDAO.setInsertLocation(vo);
      } else {
          return locationDAO.setUpdateLocation(vo);
      }
  }
    
    @Override
    public List<LocationVO> getFamilyLocations(int memberIdx, String familyCode) {
        return locationDAO.getFamilyLocations(memberIdx, familyCode);
    }
    
    @Override
    public LocationVO getCurrentLocation(int memberIdx) {
        return locationDAO.getCurrentLocation(memberIdx);
    }
    
    @Override
    public List<LocationVO> getLocationHistory(int memberIdx, String familyCode, String date) {
        return locationDAO.getLocationHistory(memberIdx, familyCode, date);
    }
    
    @Override
    public List<SavedPlaceVO> getSavedPlaces(int memberIdx, String familyCode) {
        return locationDAO.getSavedPlaces(memberIdx, familyCode);
    }
    
    @Override
    public int setSavePlace(SavedPlaceVO savedPlace) {
        return locationDAO.setSavePlace(savedPlace);
    }
    
    @Override
    public int setDeletePlace(int placeIdx, int memberIdx, String familyCode) {
        return locationDAO.setDeletePlace(placeIdx, memberIdx, familyCode);
    }

	@Override
	public LocationVO getMemberLocation(int memberIdx) {
		return locationDAO.getMemberLocation(memberIdx);
	}
}