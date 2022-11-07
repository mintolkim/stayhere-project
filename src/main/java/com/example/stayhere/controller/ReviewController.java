package com.example.stayhere.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.model.guest.dto.GuestDTO;
import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;
import com.example.stayhere.model.review.dto.ReviewDTO;
import com.example.stayhere.model.review_comment.dto.ReCommentDTO;
import com.example.stayhere.service.guest.GuestService;
import com.example.stayhere.service.review.ReviewService;
import com.example.stayhere.service.rooms.RoomsService;
import com.example.stayhere.util.MediaUtils;
import com.example.stayhere.util.Pager;
import com.example.stayhere.util.UploadFileUtils;

@Controller
@RequestMapping("reviews/*")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Inject
	GuestService guestService;

	@Inject
	RoomsService roomsService;

	@Inject
	ReviewService reviewService;

	// 업로드 디렉토리
	@Resource(name = "uploadPath")
	String uploadPath; // c:/upload

	@RequestMapping("list.do")
	public ModelAndView list(
			@RequestParam(defaultValue = "1") int curPage, 
			@RequestParam(defaultValue="review_idx") String select,
			ReviewDTO dto, 
			HttpSession session) throws Exception {
		int view_count = reviewService.countArticle();// 레코드 갯수 계산

		// 페이지 설정
		int pageScale = 6;
		Pager pager = new Pager(pageScale, view_count, curPage);// 한 페이지당 6개개
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<ReviewDTO> list = reviewService.listAll(start, end);
		logger.info(list.toString());
		//댓글 조회수
		//List<ReCommentDTO> recntlist = reviewService.comment(review_idx);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();

		map.put("list", list);
		map.put("view_count", view_count); // 레코드 갯수 파일
		map.put("pager", pager);
		mav.setViewName("reviews/reviewList");
		mav.addObject("map", map);
		return mav;
	}

	//리뷰작성
	//게스트 예약정보-이용완료-후기작성에서 바로
	//room_idx값을 가져와서 작성화면 상단에 room 상세정보를 추가하고 싶은데 404오류 해결을 못해서 우선 단순 작성
	//@RequestMapping("write.do/{room_idx}")
	//public ModelAndView write(@PathVariable int room_idx, HttpSession session){
	//	RoomsDTO room_dto=new RoomsDTO();
	//	room_dto=roomsService.detailRooms(room_idx);
	//	mav.addObject("room", room_dto); 
	//	mav.setViewName("reviews/reviewWrite");
	//	return mav;
	//}
	@RequestMapping("write.do") 
	public ModelAndView write(HttpSession session, @RequestParam int room_idx) { 
		ModelAndView mav=new ModelAndView();
		mav.setViewName("reviews/reviewWrite");
		mav.addObject("room_idx", room_idx);
		return mav;
	}

	// 리뷰글 삽입
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute ReviewDTO dto, HttpSession session) throws Exception {
		String userid = (String)session.getAttribute("userid");
		dto.setUserid(userid);
		reviewService.create(dto);
		return "redirect:/reviews/list.do";
	}

	//리뷰상세페이지
	@RequestMapping(value = "detail.do", method = RequestMethod.GET)
	public String detail(@RequestParam int review_idx, HttpSession session, Model model) throws Exception {
		String userid=(String)session.getAttribute("userid");
		String h_userid=(String)session.getAttribute("h_userid");
		String user="";
		if(userid != null) {//접속한사람이 게스트라면
			user=userid;
		}else if(h_userid != null) {//접속한 사람이 호스트라면
			user=h_userid;
		}
		//접속자가 신고를 눌렀는지 체크(int로 누적카운트 하려다가,, 그냥 다시 y/n으로)
		//int accuse = reviewService.accuseCheck(user, review_idx);
		//조회수증가처리
		reviewService.increaseViewcnt(review_idx, session);
		ReviewDTO reviewDto = reviewService.detail(review_idx);
		model.addAttribute("dto", reviewDto);
		//model.addAttribute("accuse", accuse);
		model.addAttribute("user", user);
		return "reviews/reviewDetail";
	}

	// 리뷰이미지파일 업로드
	@RequestMapping(value = "imageUpload.do")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {

		OutputStream out = null;
		PrintWriter printWriter = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		try {
			// 업로드한 파일 이름
			String fileName = upload.getOriginalFilename();
			// 파일을 바이트 배열로 변환
			byte[] bytes = upload.getBytes();
			String uploadPath = "C:\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\styahere-project\\resources\\imgUpload\\";
			out = new FileOutputStream(new File(uploadPath + fileName));
			// 서버로 업로드
			out.write(bytes);
			//클라이언트에 결과표시
			//String callback = request.getParameter("CKEditorFuncNum");
			// 서버 => 클라이언트로 텍스트 전송(자바스크립트 실행)
			// 여기 이미지 업로드 경로 수정(+"/imgUpload/" 삭제)
			printWriter = response.getWriter();
			String fileUrl = request.getContextPath()+"/imgUpload/" + fileName;
			printWriter.println("{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
			printWriter.flush();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e2) {
				e2.printStackTrace();
			}
		}
		return;
	}

	@ResponseBody // 객체를 json 형식으로 데이터 리턴
	@RequestMapping(value = "uploadAjax.do", method = RequestMethod.POST, 
	produces = "text/plain;charset=utf-8")																								
	// 업로드한 파일정보와 Http 상태코드를 함께 리턴 (HttpStatus, HttpHeaders, HttpBody를 포함)
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		// View의 이름이 아니라 data 자체를 보내는 처리
		return new ResponseEntity<String>(
				UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), 
						file.getBytes()), HttpStatus.OK);
		// 파일성공여부는 uploadAjax.jsp의 function(data,status,req)으로 넘어감
	}

	//파일 내보내기
	@ResponseBody
	@RequestMapping("displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		//서버의 파일을 다운로드하기 위한 스트림
		InputStream in = null;//java.io
		ResponseEntity<byte[]> entity = null;
		try {
			//확장자 검사
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			//헤더 구성 객체
			HttpHeaders headers = new HttpHeaders();
			//InputStream 생성
			in = new FileInputStream(uploadPath + fileName);
			fileName = fileName.substring(fileName.indexOf("_") + 1);
			//다운로드용 컨텐츠 타입
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\""
					+new String(fileName.getBytes("utf-8"), "iso-8859-1")+ "\"");
			//바이트배열(내용), 헤더, 상태코드 3개를 묶어서 전달
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), 
					headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(
					HttpStatus.BAD_REQUEST);//실패했을 때 에러메시지 전달
		} finally {
			if (in != null)
				in.close();//스트림 닫기
		}
		return entity;
	}

	//첨부파일목록 리턴
	@RequestMapping("getAttach/{review_idx}")
	@ResponseBody //view가 아닌 List<String>데이터 자체를 리턴
	public List<String> getAttach(@PathVariable int review_idx) throws Exception{
		return reviewService.getAttach(review_idx);
	}

	//업로드파일 삭제
	@ResponseBody
	@RequestMapping("deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		logger.info("fileName:"+fileName); 
		//확장자 검사
		String formatName=fileName.substring(
				fileName.lastIndexOf(".")+1);//마지막 .다음 문자부터 끝까지 글자
		MediaType mType=MediaUtils.getMediaType(formatName);
		if(mType != null) { //이미지 파일의 원본이미지 삭제
			String front=fileName.substring(0, 12);//0~11까지
			String end=fileName.substring(14);//14부터 끝까지
			new File(uploadPath+(front+end).replace(
					'/',File.separatorChar)).delete();
		}
		//기타종류 원본 파일 삭제(이미지이면 썸네일 삭제)
		new File(uploadPath+fileName.replace(
				'/',File.separatorChar)).delete();
		//레코드 삭제
		reviewService.deleteFile(fileName);

		return new ResponseEntity<String>("deleted"
				,HttpStatus.OK);//uploadAjax.jsp의 if(result=="deleted")와 연결
	}

	// 게스트리뷰리스트
	//@RequestMapping("view.do")
	//public ModelAndView view(int review_idx, HttpSession session) throws Exception {
	//	//조회수 증가 처리(session 처리 확인)
	//	reviewService.increaseViewcnt(review_idx, session);
	//	ModelAndView mav=new ModelAndView();
	//	mav.setViewName("reviews/view");
	//	mav.addObject("dto", reviewService.read(review_idx));
	//	return mav;
	//}

	//첨부파일 목록을 리턴(참고용 board 컨트롤러)
	//ArrayList를 json 배열로 변환하여 리턴
	//@RequestMapping("getAttach/{bno}")
	//@ResponseBody //view가 아닌 List<String>데이터 자체를 리턴
	//public List<String> getAttach(@PathVariable int bno){
	//	return reviewService.getAttach(bno);
	//}

	//리뷰수정
	@RequestMapping("update.do")
	public String update(ReviewDTO dto) throws Exception{
		System.out.println("dto : " + dto);
		if(dto != null) {
			reviewService.update(dto);
		}
		//목록으로 되돌아갈 때
		//return "redirect:/reviews/list.do";
		//상세 화면으로 되돌아갈때
		return "redirect:/reviews/detail.do?review_idx="+dto.getReview_idx();
	}
	
	//리뷰수정페이지이동
	@RequestMapping("edit.do")
	public ModelAndView edit(int review_idx) 
			throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reviews/reviewEdit");
		mav.addObject("dto", reviewService.detail(review_idx));
		//게시물 목록으로 이동
		return mav;
	}

	//리뷰삭제
	@RequestMapping("delete.do")
	public String delete(int review_idx) throws Exception {
		reviewService.delete(review_idx);
		return "redirect:/reviews/list.do";
	}

	//리뷰댓글 리스트
	@RequestMapping(value = "commentlist.do", method = RequestMethod.GET)
	public ModelAndView comment(@RequestParam int review_idx) throws Exception {
		System.out.println("들어온 review_idx: "+review_idx);
		//댓글 불러오기
		List<ReCommentDTO> list = reviewService.comment(review_idx);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map=new HashMap<>();
		map.put("list", list);//댓글리스트
		map.put("review_idx", review_idx);//글번호
		map.put("count", list.size());//댓글리스트
		mav.setViewName("reviews/reviewComment");//포워딩할 뷰
		mav.addObject("map", map);//보낼 데이터*/
		return mav;
	}

	//댓글 달기
	@RequestMapping("addcomment.do")
	public ResponseEntity<Integer> addcomment(int review_idx,String contents, String writer){
		System.out.println("들어온 review_idx: "+review_idx+", writer : "+writer+", contents : "+contents);
		reviewService.addComment(review_idx, writer, contents);
		return new ResponseEntity<Integer>(review_idx,HttpStatus.OK);
	}	

	//리뷰댓글 삭제(들어온 값 확인필요)
	@RequestMapping("delComment.do")
	public ResponseEntity<Integer> delComment(int review_idx,int comment_idx){
		System.out.println("들어온 review_idx: "+review_idx+",comment_idx : "+comment_idx);
		reviewService.delComment(review_idx,comment_idx);
		return new ResponseEntity<Integer>(review_idx,HttpStatus.OK);
	}	


	/*
	 * //신고
	 * @RequestMapping("accuseCheck.do") 
	 * public String accuseCheck(@RequestParam int review_idx) { 
	 * 		reviewService.accuseCheck(review_idx); 
	 * 		return "redirect:/admin/admin_accuse"; 
	 * }
	 * 
	 * //신고취소
	 * @RequestMapping("accuseCancel.do") 
	 * public String accuseCancel(@RequestParam int review_idx) {
	 * 		reviewService.accuseCheck(review_idx); 
	 * 		return "redirect:/admin/admin_accuse"; 
	 * }
	 */
}
