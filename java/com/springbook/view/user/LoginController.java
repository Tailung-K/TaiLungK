package com.springbook.view.user;

//import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springbook.biz.user.UserVO;
import com.springbook.biz.user.impl.UserDAO;

@Controller
public class LoginController {
    private Logger logger = LoggerFactory.getLogger( this.getClass() );

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String loginView(@ModelAttribute("user") UserVO vo) {
		
	    logger.debug("로그인 화면으로 이동...");
		
		vo.setId("test");
		vo.setPassword("test123");
		
		return "login.jsp";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserVO vo, UserDAO userDAO, HttpSession session) {
	    
	    logger.debug("login post vo :: " + vo.toString());
        logger.debug("login post session :: " + session.toString());
        
	    
		if (vo.getId() == null || vo.getId().equals("")) {
			throw new IllegalArgumentException("아이디는 반드시 입력해야 합니다.");
		}
		
		UserVO user = userDAO.getUser(vo);
		
		if (user != null) {
			session.setAttribute("userName", user.getName());
//			return "dataTransform.do";
			return "getList.do";
		} else {
            return "login.jsp";
		}
	}
}
