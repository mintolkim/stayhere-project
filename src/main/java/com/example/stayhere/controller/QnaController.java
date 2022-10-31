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

import com.example.stayhere.model.qna.dto.QnaDTO;
import com.example.stayhere.model.qna_comment.dto.QnaCommentDTO;
import com.example.stayhere.service.qna.QnaService;
import com.example.stayhere.util.MediaUtils;
import com.example.stayhere.util.Pager;
import com.example.stayhere.util.UploadFileUtils;


 @Controller 
 @RequestMapping("qna/*")
 public class QnaController {
	 private static final Logger logger=LoggerFactory.getLogger(SearchController.class);

	 @Resource(name="uploadPath")
		String uploadPath;
	 
	 @Inject
		QnaService qnaService;
	 //qna전체글 목록
	 @RequestMapping(value = "qnalist.do", method = RequestMethod.GET)
		public ModelAndView list(
				@RequestParam(defaultValue="all") String category,
				@RequestParam(defaultValue="q_idx") String select,
				@RequestParam(defaultValue = "") String keyword,
				@RequestParam(defaultValue ="1") int curPage) throws Exception {
		 //레코드 갯수 계산하기
		 int count = qnaService.countqna(keyword, category);
		 //페이지관련 설정
		 int pageScale = 8;
		 Pager pager = new Pager(pageScale, count, curPage);
		 int start = pager.getPageBegin();
		 int end = pager.getPageEnd();
		 //리스트작업
		 List<QnaDTO> list = qnaService.listQna(start, end, keyword, category,select);
		 ModelAndView mav = new ModelAndView();
		 Map<String, Object> map=new HashMap<>();
		 map.put("list", list);
		 map.put("count", count);
		 map.put("pager", pager);
		 map.put("select", select);
		 map.put("keyword", keyword);
		 map.put("category", category);
		 mav.setViewName("qna/qnalist");//포워딩할 뷰
		 mav.addObject("map", map);//보낼 데이터*/
		 return mav;
	 }
	 //qna글 상세보기(비밀글 체크)
	 @RequestMapping(value = "qnaview.do", method = RequestMethod.GET)
		public String view(@RequestParam int q_idx,Model model) throws Exception {
		 System.out.println("들어온 q_idx: "+q_idx);
		 String check=qnaService.passwdck(q_idx);//비밀번호가 있는지 체크
		 if(check==null) {//비밀번호가 없으면
			 return "redirect:/qna/qnadetail.do?q_idx="+q_idx;
			}else {//비밀번호가 있으면
				model.addAttribute("q_idx",q_idx);
			 return "qna/qnasecret";
			}
	 }
	 //qna글 상세
	 @RequestMapping(value = "qnadetail.do", method = RequestMethod.GET)
	 public String detail(@RequestParam int q_idx,Model model,HttpSession session) throws Exception {
		 String userid=(String)session.getAttribute("userid");
		 String h_userid=(String)session.getAttribute("h_userid");
		 System.out.println("들어온 q_idx: "+q_idx+",userid : "+userid+", h_userid : "+h_userid);
		 String user="";
		 if(userid != null) {//접속한사람이 게스트라면
			 user=userid;
		 }else if(h_userid != null) {//접속한 사람이 호스트라면
			 user=h_userid;
		 }
		 //글 스크랩했는지 확인
		 int scrap = qnaService.scrapcheck(user,q_idx);
		 //글 좋아요했는지 확인
		 int likey = qnaService.likeycheck(user,q_idx);
		 //조회수 증가처리
		 qnaService.addviewcount(q_idx,session);
		 QnaDTO dto = qnaService.detailQna(q_idx);
		 model.addAttribute("dto",dto);
		 model.addAttribute("scrap",scrap);
		 model.addAttribute("likey",likey);
		 return "qna/qnadetail";
	 }
	//qna글의 댓글불러오기
		 @RequestMapping(value = "commentlist.do", method = RequestMethod.GET)
		 public ModelAndView comment(@RequestParam int q_idx) throws Exception {
			 System.out.println("들어온 q_idx: "+q_idx);
			 //댓글 불러오기
			 List<QnaCommentDTO> list=qnaService.comment(q_idx);
			 ModelAndView mav = new ModelAndView();
			 Map<String, Object> map=new HashMap<>();
			 map.put("list", list);//댓글리스트
			 map.put("q_idx", q_idx);//글번호
			 map.put("count", list.size());//댓글리스트
			 mav.setViewName("qna/qnacomment");//포워딩할 뷰
			 mav.addObject("map", map);//보낼 데이터*/
			 return mav;
		 }
	 
	 //qna글 비밀번호 체크
	 @RequestMapping(value = "passwdck.do", method = RequestMethod.POST)
	 public String passwdch(@RequestParam int q_idx,@RequestParam String passwd,
			 Model model) throws Exception {
		 System.out.println("들어온 q_idx: "+q_idx+", 비밀번호 : "+passwd);
		 int check=qnaService.checkpd(q_idx,passwd);
		 if(check==1) {//비밀번호가 맞으면
			 return "redirect:/qna/qnadetail.do?q_idx="+q_idx;
		 }else {//틀리면
			 model.addAttribute("message","비밀번호가 맞지 않습니다.");
			 model.addAttribute("q_idx",q_idx);
			 return "qna/qnasecret";
		 }
	 }
	 //qna 댓글 달기
	 @RequestMapping("addcomment.do")
	 public ResponseEntity<Integer> addcomment(int q_idx,String contents,String writer){
		 System.out.println("들어온 q_idx: "+q_idx+", writer : "+writer+", contents : "+contents);
		 qnaService.addcomment(q_idx, writer, contents);
		 return new ResponseEntity<Integer>(q_idx,HttpStatus.OK);
	 }	
	//qna 대댓글 달기
		 @RequestMapping("addcomment2.do")
		 public ResponseEntity<Integer> addcomment(int q_idx,String contents,String writer,int comment_idx){
			 System.out.println("들어온 q_idx: "+q_idx+", writer : "+
		 writer+", contents : "+contents+",comment_idx : "+comment_idx);
			 QnaCommentDTO dto = qnaService.viewComment(comment_idx);
			 int ref=dto.getRef(); //답변 그룹 번호
			 int re_step=dto.getRe_step()+1; //출력순번(수정 +1)
			 int re_level=dto.getRe_level()+1; //답변 단계(수정 +1)
			 dto.setWriter(writer);
			 dto.setContents(contents);
			 dto.setQ_idx(q_idx);
			 dto.setRef(ref);
			 dto.setRe_step(re_step);
			 dto.setRe_level(re_level);
			 //댓글 순서조정
			 qnaService.updateStep(ref, re_step);
			 //대댓글 쓰기
			 qnaService.addcomment2(dto);
			 return new ResponseEntity<Integer>(q_idx,HttpStatus.OK);
		 }	
	//qna 댓글 삭제
		 @RequestMapping("delcomment.do")
		 public ResponseEntity<Integer> delcomment(int q_idx,int comment_idx){
			 System.out.println("들어온 q_idx: "+q_idx+",comment_idx : "+comment_idx);
			 //댓글삭제
			 qnaService.delcomment(q_idx,comment_idx);
			 return new ResponseEntity<Integer>(q_idx,HttpStatus.OK);
		 }	
	//qna글 스크랩
		 @RequestMapping("addscrap.do")
		 public ResponseEntity<Integer> addscrap(int q_idx,String userid){
			 System.out.println("들어온 q_idx: "+q_idx+",userid : "+userid);
			 //스크랩추가
			 qnaService.addscrap(q_idx,userid);
			 return new ResponseEntity<Integer>(1,HttpStatus.OK);
		 }
	//qna글 좋아요
		 @RequestMapping("addlikey.do")
		 public ResponseEntity<Integer> addlikey(int q_idx,String userid){
			 System.out.println("들어온 q_idx: "+q_idx+",userid : "+userid);
			 //좋아요추가
			 qnaService.addlikey(q_idx,userid);
			 return new ResponseEntity<Integer>(1,HttpStatus.OK);
		 }
	//qna글 스크랩 취소
		 @RequestMapping("delscrap.do")
		 public ResponseEntity<Integer> delscrap(int q_idx,String userid){
			 System.out.println("들어온 q_idx: "+q_idx+",userid : "+userid);
			 //스크랩추가
			 qnaService.delscrap(q_idx,userid);
			 return new ResponseEntity<Integer>(1,HttpStatus.OK);
		 }
	//qna글 좋아요 취소
		 @RequestMapping("dellikey.do")
		 public ResponseEntity<Integer> dellikey(int q_idx,String userid){
			 System.out.println("들어온 q_idx: "+q_idx+",userid : "+userid);
			 //좋아요추가
			 qnaService.dellikey(q_idx,userid);
			 return new ResponseEntity<Integer>(1,HttpStatus.OK);
		 }
    //qna글 채택하기
		 @RequestMapping("selectcoment.do")
		 public ResponseEntity<Integer> selectcoment(int q_idx,int comment_idx){
			 System.out.println("들어온 q_idx: "+q_idx+",comment_idx : "+comment_idx);
			 //댓글채택
			 qnaService.selectcoment(q_idx,comment_idx);
			 return new ResponseEntity<Integer>(q_idx,HttpStatus.OK);
		 }	
	//qna 글쓰기
		 @RequestMapping("qnawrite.do")
		 public  String write() {
			return "qna/qnawrite";
		 }
	//이미지 업로드
		@RequestMapping(value = "fileupload.do")
		public void imageUpload(HttpServletRequest request, 
				HttpServletResponse response, 
				@RequestParam MultipartFile upload) throws Exception{

			OutputStream out = null;
			PrintWriter printWriter = null;
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");

			try {
				//업로드한 파일 이름
				String fileName=upload.getOriginalFilename();
				//파일을 바이트 배열로 변환
				byte[] bytes=upload.getBytes();
				//이미지를 업로드할 디렉토리
				String uploadPath="C:\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\styahere-project\\resources\\imgUpload\\";
				out=new FileOutputStream(new File(uploadPath+fileName));
				//서버로 업로드
				out.write(bytes);
				//서버 => 클라이언트로 텍스트 전송(자바스크립트 실행)
				printWriter=response.getWriter();
				String fileUrl=request.getContextPath()+"/imgUpload/"+fileName;
				printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
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
		
		@ResponseBody //객체를 json 형식으로 데이터 리턴
		@RequestMapping(value = "uploadAjax.do", method = RequestMethod.POST
				, produces = "text/plain;charset=utf-8")//한글이 깨지지 않도록 처리
		public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
			System.out.println("uploadPath : "+uploadPath+", 파일명 : "+file.getOriginalFilename()+",파일크기 : "+file.getBytes());
			//View의 이름이 아니라 data 자체를 보내는 처리
			return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, 
					file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
			//파일성공여부는 uploadAjax.jsp의 function(data,status,req)으로 넘어감
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
			qnaService.deleteFile(fileName);
			
			return new ResponseEntity<String>("deleted"
					,HttpStatus.OK);//uploadAjax.jsp의 if(result=="deleted")와 연결
		}
		// qna글 삽입
		@RequestMapping("insert.do")
		public String insert(@ModelAttribute QnaDTO dto, HttpSession session) 
				throws Exception {
			//세션에서 사용자아이디를 가져옴
			String userid=(String)session.getAttribute("userid");
			 String h_userid=(String)session.getAttribute("h_userid");
			 String user="";
			 if(userid != null) {//접속한사람이 게스트라면
				 user=userid;
			 }else if(h_userid != null) {//접속한 사람이 호스트라면
				 user=h_userid;
			 }
			dto.setUserid(user);
			qnaService.create(dto);
			//게시물 목록으로 이동
			return "redirect:/qna/qnalist.do";
		}
	//qna 첨부파일 가져오기
		@RequestMapping("getAttach/{q_idx}")
		@ResponseBody //view가 아닌 List<String>데이터 자체를 리턴
		public List<String> getAttach(@PathVariable int q_idx) throws Exception{
			return qnaService.getAttach(q_idx);
		}
	//qna글 수정페이지이동
		@RequestMapping("qnaedit.do")
		public ModelAndView edit(int q_idx) 
				throws Exception {
			ModelAndView mav=new ModelAndView();
			mav.setViewName("qna/qnaedit");
			mav.addObject("dto", qnaService.detailQna(q_idx));
			//게시물 목록으로 이동
			return mav;
		}
	//qna글 수정
		//게시물 내용 수정
		@RequestMapping("update.do")
		public String update(QnaDTO dto) throws Exception{
			System.out.println("dto : "+dto);
			if(dto != null) {
				qnaService.update(dto);
			}
			return "redirect:/qna/qnadetail.do?q_idx="+dto.getQ_idx();
		}
		@RequestMapping("delete.do")
		public String delete(int q_idx) throws Exception {
			qnaService.delete(q_idx);
			return "redirect:/qna/qnalist.do";
		}
		
 }
 
