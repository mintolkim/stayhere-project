package com.example.stayhere.controller.guest;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.controller.FileUtils;
import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.service.guest.GuestService;

@Controller
@RequestMapping("guest/*")
public class GuestController {
	
	private static final Logger logger = LoggerFactory.getLogger(GuestController.class);
	
	@Inject
	GuestService guestService;
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@RequestMapping("list.do")
	public String list_guest(Model model) {
		List<GuestDTO> list = guestService.list_guest();
		model.addAttribute("list", list);
		return "guest/guest_list";
	}
	
	@RequestMapping("join.do")
	public String insert_guest(Model model) {
		return "guest/guest_join";
	}	

	@RequestMapping("loginCheck")
	public ModelAndView loginCheck(GuestDTO dto, HttpSession session) {
		System.out.println("loginCheck 시작!");
		boolean result = guestService.loginCheck(dto, session);
		ModelAndView mav = new ModelAndView();
		if(result) {
			//로그인 성공시 메인페이지로 이동
			mav.setViewName("main");
		} else {
			//로그인 실패시 로그인 페이지로 리턴
			mav.setViewName("guest/guest_login");
			mav.addObject("message", "error");
		}
		return mav;
	}

	@RequestMapping("insert.do") 
	public ModelAndView insert(GuestDTO dto, ModelAndView mav) { 
		logger.info(dto.toString());
		guestService.insert_Guest(dto); 
		mav.addObject("message","join");
		mav.setViewName("guest/guest_login");
		return mav;
		//return "main"; 
	}

	@RequestMapping("login.do")
	public String login() {
		return "guest/guest_login";
	}
	
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		guestService.logout(session);
		mav.setViewName("guest/guest_login");
		mav.addObject("message", "logout");
		return mav;
	}

	@RequestMapping("guest_view/{userid}")
	public ModelAndView view(@PathVariable String userid, ModelAndView mav) {
		mav.setViewName("guest/guest_view");
		mav.addObject("dto", guestService.view_Guest(userid));
		return mav;
	}
	
	@RequestMapping("update/{userid}")
	public ModelAndView update(@PathVariable String userid, ModelAndView mav) {
		mav.setViewName("guest/guest_edit");
		mav.addObject("dto", guestService.view_Guest(userid));
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value ="idCheck.do", produces = "text/plain")
	public String idCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String userid = request.getParameter("userid");
		GuestDTO dto = new GuestDTO();
		dto.setUserid(userid);
		int using_user = guestService.loginLookup(dto);
		String result = "" + using_user; // 숫자를 문자열로 변환
		return result;		
	}
	
	@RequestMapping("edit.do")
	public ModelAndView guest_img(GuestDTO dto, HttpSession session, MultipartFile file, ModelAndView mav) throws Exception {
		System.out.println(dto);
		String userid = (String)session.getAttribute("userid");
		dto.setUserid(userid);
		System.out.println(dto);
		String profile_img = dto.getProfile_img();
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String fileName = null;
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		   fileName =  FileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes());   
		   mav.addObject("message","profile");
		   dto.setProfile_img(File.separator + "imgUpload" + File.separator + fileName);
		} else {//null값이면 
		   //fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
			fileName=profile_img;
			System.out.println(fileName);
			dto.setProfile_img(fileName);
		}
		guestService.update_Guest(dto);
		mav.addObject("dto", guestService.view_Guest(userid));
		mav.setViewName("guest/guest_view");
		return mav;
	}	
	
	/* 메일인증 */
	@RequestMapping(value="mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(@ModelAttribute GuestDTO dto, HttpServletRequest request, HttpServletResponse response, String email) throws Exception {
		/* 뷰로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("이메일 : " + email);
		//int result = guestService.emailCheck(email);
		//PrintWriter out = response.getWriter();
		//if(result==0) {
		/* 인증키 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;
		logger.info("인증번호 : " + checkNum);
		HttpSession session = request.getSession();
		String num = Integer.toString(checkNum);
		dto.setEmail(email);
		session.setAttribute("checkNum", checkNum);
		/* 인증키 전송 */
		//guestService.authEmail(response, session, dto);
		guestService.sendEmail(dto, "auth", num);
		//out.close();
		return num;
		//}else {
		//	PrintWriter out2 = response.getWriter();
		//	out2.print("이미 사용된 이메일입니다.");
		//	out2.close();
		//	return "guest/guest_join";
		//}
	}
	
	/* 비밀번호 찾기*/
	@RequestMapping(value="findpw", method=RequestMethod.GET)
	public void findPwGet() throws Exception {
	}
	
	@RequestMapping(value = "findpw", method = RequestMethod.POST)
	public void findPwPOST(@ModelAttribute GuestDTO dto, HttpServletResponse response) throws Exception{
		guestService.findPw(response, dto);
	}	

	@RequestMapping("kakaoLogin")
	public String kakaoLogin(String id, String name, String email, HttpServletRequest request, Model model) throws Exception {
		GuestDTO dto = new GuestDTO();
		HttpSession session = request.getSession();
		dto.setEmail(email);
		try {
			String abc = guestService.findId(email);
			logger.info(abc);
			dto.setUserid(abc);
			logger.info("dto.getUserid:"+dto.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (dto.getUserid() != null) { // 카카오로그인 성공
			logger.info("id:"+id);
			logger.info("email:"+email);
			String findid = guestService.findId(email);
			logger.info("findid:"+findid);
			dto.setUserid(findid);
			logger.info("id:"+dto.getUserid());
			session.setAttribute("name", name);
			session.setAttribute("email", email);
			session.setAttribute("userid", findid);
		} else { // id가 없을 때
			model.addAttribute("email", email);
			model.addAttribute("name", name);
			model.addAttribute("message", "first");
			return "guest/kakao_join";
		}
		model.addAttribute("message", dto.getName() + "님 환영합니다!");
		return "main";
	}
	@RequestMapping("kakao_join")
	public String kakaoJoin() {
		return "guest/kakao_join";
	}	

	@RequestMapping(value="emailCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public boolean emailCheck(String email) {
		/* 뷰로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("이메일 : " + email);
		int result = guestService.emailCheck(email);
		if(result==1) {
			return true;
		}else {
			
			return false;
	}
//	@RequestMapping(value = "testLogin")
//	public String isComplete(HttpSession session) {
//		return "/guest/guest_login"; 
//	}
//
//    //로그인 첫 화면 요청 메소드
//    @RequestMapping(value = "guest_login", method = { RequestMethod.GET, RequestMethod.POST })
//    public String login(Model model, HttpSession session) {
//        
//        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO의 getAuthorizationUrl메소드 호출 */
//        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
//        								
//        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
//        System.out.println("네이버:" + naverAuthUrl);
//        model.addAttribute("url", naverAuthUrl);
//
//        /* 생성한 인증 URL을 View로 전달 */
//        return "guest/guest_login";
//    }
//
//    //네이버 로그인 성공시 callback호출 메소드
//    @RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
//    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
//            throws IOException {
//        System.out.println("여기는 callback");
//        OAuth2AccessToken oauthToken;
//        oauthToken = naverLoginBO.getAccessToken(session, code, state);
//        //로그인 사용자 정보를 읽어온다.
//        apiResult = naverLoginBO.getUserProfile(oauthToken);
//        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
//        model.addAttribute("result", apiResult);
//        System.out.println("result : "+apiResult);
        /* 네이버 로그인 성공 페이지 View 호출 */
//      JSONObject jsonobj = jsonparse.stringToJson(apiResult, "response");
//      String snsId = jsonparse.JsonToString(jsonobj, "id");
//      String name = jsonparse.JsonToString(jsonobj, "name");
//      UserVO vo = new UserVO();
//      vo.setUser_snsId(snsId);
//      vo.setUser_name(name);
//      System.out.println(name);
//      try {
//          vo = service.naverLogin(vo);
//      } catch (Exception e) {
//          // TODO Auto-generated catch block
//          e.printStackTrace();
//      }
//      session.setAttribute("login",vo);
//      return new ModelAndView("user/loginPost", "result", vo);
//        return "guest/naverSuccess";
    }	

	
//	@RequestMapping(value = "/memberloginform.do", method = RequestMethod.GET)
//	public ModelAndView memberLoginForm(HttpSession session) {
//		ModelAndView mav = new ModelAndView();
//		/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
//		//String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
//		String kakaoUrl = KakaoController.getAuthorizationUrl(session);
//		/* 생성한 인증 URL을 View로 전달 */
//		mav.setViewName("memberloginform");
//		// 네이버 로그인
//		//mav.addObject("naver_url", naverAuthUrl);
//		// 카카오 로그인
//		mav.addObject("kakao_url", kakaoUrl);
//		return mav;
//	}// end memberLoginForm()


}
