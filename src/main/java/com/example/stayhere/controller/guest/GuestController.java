package com.example.stayhere.controller.guest;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.service.guest.GuestService;

@Controller
@RequestMapping("guest/*")
public class GuestController {
	
	private static final Logger logger = LoggerFactory.getLogger(GuestController.class);
	
	@Inject
	GuestService guestService;
	
	private String uploadPath = "C:\\upload\\test";

	
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

	@RequestMapping("loginCheck.do")
	public ModelAndView loginCheck(GuestDTO dto, HttpSession session) {
		boolean result = guestService.loginCheck(dto, session);
		ModelAndView mav = new ModelAndView();
		if(result) {
			//로그인 성공시 메인페이지로 이동
			mav.setViewName("redirect:/main");
		} else {
			//로그인 실패시 로그인 페이지로 리턴
			mav.setViewName("guest/guest_login");
			mav.addObject("message", "error");
		}
		return mav;
	}

//	@RequestMapping("insert.do") 
//	public ModelAndView insert( GuestDTO dto, ModelAndView mav) { 
//		logger.info(dto.toString());
//		
//		guestService.insert_Guest(dto); 
//		mav.addObject("message","join");
//		mav.setViewName("guest/guest_login");
//		return mav;
//		//return "main"; 
//	}
	
//	@RequestMapping("insert.do") 
//	public String insert(HttpServletRequest request, Model model) throws Exception { 
//		int maxFileSize = 1024 * 1024 * 6;
//		String encType = "utf-8";
//		MultipartRequest multi = null;
//		try {
//			request.setCharacterEncoding("utf-8");
//			multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
//			GuestDTO dto = new GuestDTO();
//			dto.setUserid(multi.getParameter("userid")); 
//			dto.setPasswd(multi.getParameter("passwd"));
//			dto.setPasswd(multi.getParameter("passwd"));
//			dto.setName(multi.getParameter("name"));
//			dto.setEmail(multi.getParameter("email"));
//			dto.setPhone(multi.getParameter("phone"));
//			dto.setProfile_img(multi.getFilesystemName("profile_img"));
//			File file = multi.getFile("profile_img");
//			int ok = guestService.insert_Guest(dto);
//			model.addAttribute("ok", ok);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return "main";
//	}
	
	@RequestMapping("insert.do")
	public String insert(MultipartHttpServletRequest request) throws Exception {
		GuestDTO dto = new GuestDTO();
		dto.setUserid(request.getParameter("userid"));
		dto.setPasswd(request.getParameter("passwd"));
		dto.setName(request.getParameter("name"));
		dto.setEmail(request.getParameter("email"));
		dto.setPhone(request.getParameter("phone"));
		
		MultipartFile f = request.getFile("profile_img");
		String path = request.getRealPath("C:\\upload\\test");
		String fileName = f.getOriginalFilename();
		File uploadFile = new File(path+fileName);
		try {
			f.transferTo(uploadFile);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		dto.setProfile_img(fileName);
		guestService.insert_Guest(dto);
		return "main";
		
//		String fileRealName = file.getOriginalFilename();
//		long size = file.getSize();
//		
//		System.out.println("파일명 : " + fileRealName);
//		System.out.println("파일크기 : " + size);
//		
//		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
//		String uploadFolder = "C:\\upload\\test";
//		UUID uuid = UUID.randomUUID();
//		
//		System.out.println(uuid.toString());
//		
//		String[] uuids = uuid.toString().split("-");
//		String uniqueName = uuids[0];
//		System.out.println("생성된 고유문자열" + uniqueName);
//		System.out.println("확장자명" + fileExtension);
//		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension); 
//		try {
//			file.transferTo(saveFile);
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		guestService.insert_Guest(dto);
//		return "main";
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
	
	@RequestMapping("edit.do")
	public ModelAndView edit(GuestDTO dto, HttpSession session, ModelAndView mav) {
		String userid=(String)session.getAttribute("userid");
		dto.setUserid(userid);
		//비밀번호 체크			
		boolean result = guestService.checkPw(dto.getUserid(), dto.getPasswd());	
		if(result) { 
			//비번이 맞으면 회원정보 수정
			guestService.update_Guest(dto);				
			mav.setViewName( "main");
		}else {
			mav.addObject("message", "비밀번호를 확인하세요.");
			//수정버튼을 누른 후 에는 입력필드에 나타난 정보가 모두 지워지기 때문에 지워지는 현상을 방지하기 위한 코드 처리
			mav.addObject("dto", dto);
			//날짜는 dto가 아닌 시스템에서 자동처리했기 때문에 날짜도 입력필드에서 지워지는 현상을 방지하도록 처리
			mav.addObject("join_date", guestService.view_Guest(dto.getUserid()).getJoin_date());
			mav.setViewName("main");			
		}
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
	
	@RequestMapping("guest_img.do")
	public String guest_img(Model model) {
		return "guest/profile_edit";
	}	
	
//	 @RequestMapping("guest_img.do") 
//	 public String guest_img(@RequestParam("file") MultipartFile file) throws IOException {
//		String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드!
//		long size = file.getSize(); //파일 사이즈
//			
//		System.out.println("파일명 : "  + fileRealName);
//		System.out.println("용량크기(byte) : " + size);
//		//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
//		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
//		String uploadFolder = "/src/main/webapp/resources/images";
//		
//		UUID uuid = UUID.randomUUID();
//		System.out.println(uuid.toString());
//		String[] uuids = uuid.toString().split("-");
//		
//		String uniqueName = uuids[0];
//		System.out.println("생성된 고유문자열" + uniqueName);
//		System.out.println("확장자명" + fileExtension);
//		
//		// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
//		
//		File saveFile = new File(uploadFolder+"\\"+uniqueName + fileExtension);  // 적용 후
//		try {
//			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return "fileupload/upload_ok";
//	 }
//	 	
	
	
}
