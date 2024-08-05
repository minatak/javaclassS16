package com.spring.javaclassS16.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {

	// JSP페이지에서 에러발생시 공사중화면으로 보내어 보여주는 폼
	@RequestMapping(value = "/errorMessage1", method = RequestMethod.GET)
	public String errorMessage1Get() {
		return "errorPage/errorMessage1";
	}
	
	// 400에러가 났을때 이동할 메세지 폼 보기(400번에러는 서버로 요청이 오지도 않은경우이기에 이곳처리할것이 없다. 따라서 서버요청변수 타입을 잘 살펴봐야한다.)
	@RequestMapping(value = "/error400", method = RequestMethod.GET)
	public String error400Get() {
		return "";
	}
	
	// 404에러가 났을때 이동할 메세지 폼 보기(web.xml에 기술한다.)
	@RequestMapping(value = "/error404", method = RequestMethod.GET)
	public String error404Get() {
		return "errorPage/error404";
	}
	
	// JSP페이지에서 에러발생시 공사중화면으로 보내어 보여주는 폼
	@RequestMapping(value = "/errorMessage1Get", method = RequestMethod.POST)
	public String errorMessage1GetPost() {
		return "errorPage/errorMessage1";
	}
	
	// 405에러가 났을때 이동할 메세지 폼 보기(web.xml에 기술한다.)
	@RequestMapping(value = "/error405", method = RequestMethod.GET)
	public String error405Get() {
		return "errorPage/error405";
	}
	
	// servlet에러(500)가 났을때 이동할 메세지 폼...
	@RequestMapping(value = "/error500Check", method = RequestMethod.GET)
	public String error500CheckGet(HttpSession session) {
		return "errorPage/errorMain";
	}
	
	// 500에러가 났을때 이동할 메세지 폼 보기(web.xml에 기술한다.)
	@RequestMapping(value = "/error500", method = RequestMethod.GET)
	public String error500Get() {
		return "errorPage/error500";
	}
	
	// 500에러(NumberFormatException)가 났을때 이동할 메세지 폼 보기(web.xml에 기술한다.)
	@RequestMapping(value = "/errorNumberFormat", method = RequestMethod.GET)
	public String errorNumberFormatGet() {
		return "errorPage/errorNumberFormat";
	}
	
	// NullPointerException에러 발생 메소드
	@RequestMapping(value = "/errorNullPointerCheck", method = RequestMethod.GET)
	//public String errorNullPointerCheckGet(@RequestParam(name="name",defaultValue="",required=false) String name) {
	public String errorNullPointerCheckGet(String name) {
		System.out.println("name : " + name);
		if(name.equals("admin")) return "";
		return "errorPage/errorMain";
	}

	// NullPointerException에러가 났을때 이동할 메세지 폼 보기(web.xml에 기술한다.)
	@RequestMapping(value = "/errorNullPointer", method = RequestMethod.GET)
	public String errorNullPointerGet() {
		return "errorPage/errorNullPointer";
	}
	
	// 400 번 에러처리에 도움을 주기위한 예외처리....
	// @ExceptionHandler(value = Exception.class)
//	public ResponseEntity<Map<String, String>> ExceptionHandler(Exception e) {
//		System.out.println("e : " + e.getMessage());
//		
//		HttpHeaders responseHeaders = new HttpHeaders();
//		HttpStatus httpStatus = HttpStatus.BAD_REQUEST;
//		
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("error type", httpStatus.getReasonPhrase());
//		map.put("code", "400");
//		map.put("message", "에러 발생");		
//		
//		return new ResponseEntity<Map<String,String>>(map, responseHeaders, httpStatus);
//	}
	
	@ExceptionHandler(value = Exception.class)
	public String exceptionHandler(Exception e, Model model) {
    System.out.println("e : " + e.getMessage());
    
    HttpStatus httpStatus = HttpStatus.INTERNAL_SERVER_ERROR; // 기본값으로 500 설정
    String errorCode = "500";
    String errorMsg = "내부 서버 오류가 발생했습니다.";

    if (e instanceof HttpRequestMethodNotSupportedException) {
        httpStatus = HttpStatus.METHOD_NOT_ALLOWED;
        errorCode = "405";
        errorMsg = "허용되지 않는 메소드입니다.";
    } else if (e instanceof HttpMessageNotReadableException) {
        httpStatus = HttpStatus.BAD_REQUEST;
        errorCode = "400";
        errorMsg = "잘못된 요청입니다.";
    }

    model.addAttribute("errorCode", errorCode);
    model.addAttribute("errorMsg", errorMsg);
    
    return "errorPage/errorMain";
	}
	
	
}
