package com.spring.javaclassS16.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
		) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "?öå?õê ?ûêÎ£åÍ? ?Ç≠?†ú ?êò?óà?äµ?ãà?ã§.");
			model.addAttribute("url", "/user/userList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "?öå?õê ?ûêÎ£åÍ? ?Ç≠?†ú ?ã§?å®~~");
			model.addAttribute("url", "/user/userList");
		}
		
		
		return "include/message";
	}
	
}
