package com.spring.javaclassS16.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.spring.javaclassS16.service.LocationService;
import com.spring.javaclassS16.service.MemberService;
import com.spring.javaclassS16.vo.LocationVO;
import com.spring.javaclassS16.vo.MemberVO;
import com.spring.javaclassS16.vo.SavedPlaceVO;

@Controller
@RequestMapping("/location")
public class LocationController {
  
    @Autowired
    LocationService locationService;
    
    @Autowired
    MemberService memberService;
  
    @RequestMapping(value = "/locationMain", method = RequestMethod.GET)
    public String locationMainGet() {
        return "location/locationMain";
    }

    @ResponseBody
    @RequestMapping(value = "/locationUpdate", method = RequestMethod.POST)
    public String locationUpdatePost(@RequestBody LocationVO vo, HttpSession session) {
        int memberIdx = (int) session.getAttribute("sIdx");
        vo.setMemberIdx(memberIdx);
        int res = locationService.setUpdateLocation(vo);
        
        if(res != 0) return "redirect:/message/locationUpdateOk";
        else return "redirect:/message/locationUpdateNo";
    }
    

    @ResponseBody
    @RequestMapping(value = "/familyLocation", method = RequestMethod.POST)
    public List<LocationVO> familyLocationPost(HttpSession session) {
        int memberIdx = (int) session.getAttribute("sIdx");
        String familyCode = (String) session.getAttribute("sFamCode");
        
        return locationService.getFamilyLocations(memberIdx, familyCode);
    }

    @RequestMapping(value = "/locationDetail", method = RequestMethod.GET)
    public String getMemberLocationDetail(Model model, HttpSession session) {
        String familyCode = (String) session.getAttribute("sFamCode");
        int memberIdx = (int) session.getAttribute("sIdx");
        LocationVO vo = locationService.getCurrentLocation(memberIdx);
        List<LocationVO> locationHistoryVos = locationService.getLocationHistory(memberIdx, familyCode, "");
        model.addAttribute("vo", vo);
        model.addAttribute("locationHistoryVos", locationHistoryVos);
        return "location/locationDetail";
    }

    @RequestMapping(value = "/locationSave", method = RequestMethod.GET)
    public String getSavedPlaces(Model model, HttpSession session) {
        int memberIdx = (int) session.getAttribute("sIdx");
        String familyCode = (String) session.getAttribute("sFamCode");
        List<SavedPlaceVO> vo = locationService.getSavedPlaces(memberIdx, familyCode);
        model.addAttribute("vo", vo);
        return "location/locationSave";
    }

    @ResponseBody
    @RequestMapping(value = "/savePlace", method = RequestMethod.POST)
    public String savePlace(@RequestBody SavedPlaceVO savedPlace, HttpSession session) {
        int memberIdx = (int) session.getAttribute("sIdx");
        String familyCode = (String) session.getAttribute("sFamCode");
        savedPlace.setMemberIdx(memberIdx);
        savedPlace.setFamilyCode(familyCode);
        int res = locationService.setSavePlace(savedPlace);
        
        if(res != 0) return "redirect:/message/savePlaceOk";
        else return "redirect:/message/savePlaceNo";
    }

    @ResponseBody
    @RequestMapping(value = "/deletePlace", method = RequestMethod.POST)
    public String deletePlace(@RequestParam int placeIdx, HttpSession session) {
        int memberIdx = (int) session.getAttribute("sIdx");
        String familyCode = (String) session.getAttribute("sFamCode");
        int res = locationService.setDeletePlace(placeIdx, memberIdx, familyCode);
        
        if(res != 0) return "redirect:/message/deletePlaceOk";
        else return "redirect:/message/deletePlaceNo";
    }

//    @RequestMapping(value = "/locationHistory", method = RequestMethod.GET)
//    public String getLocationHistory(@RequestParam(required = false) String memberIdx, 
//                                     @RequestParam(required = false) String date, 
//                                     Model model,
//                                     HttpSession session) {
//        int memberIdxInt;
//        if (memberIdx == null || memberIdx.equals("all")) {
//            memberIdxInt = (int) session.getAttribute("sIdx");
//        } else {
//            memberIdxInt = Integer.parseInt(memberIdx);
//        }
//        String familyCode = (String) session.getAttribute("sFamCode");
//        List<LocationVO> vo = locationService.getLocationHistory(memberIdxInt, familyCode, date);
//        model.addAttribute("vo", vo);
//        return "location/locationHistory";
//    }
    
    @RequestMapping(value = "/family/members", method = RequestMethod.GET)
    public String getFamilyMembers(Model model, HttpSession session) {
        String familyCode = (String) session.getAttribute("sFamCode");
//        List<MemberVO> familyMembers = memberService.getFamilyMembers(familyCode);
//        model.addAttribute("familyMembers", familyMembers);
        return "family/members";
    }
}