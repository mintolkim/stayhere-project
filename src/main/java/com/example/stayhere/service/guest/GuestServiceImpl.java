package com.example.stayhere.service.guest;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.stayhere.model.guest.dao.GuestDAO;
import com.example.stayhere.model.guest.dto.GuestDTO;

import ch.qos.logback.classic.Logger;

@Service
public class GuestServiceImpl implements GuestService {

	@Inject
	GuestDAO guestDao;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@Override
	public List<GuestDTO> list_guest() {
		return guestDao.list_guest();
	}

	@Override
	public void insert_Guest(GuestDTO dto){
		guestDao.insert_Guest(dto);
	}

	@Override
	public void update_Guest(GuestDTO dto) {
		guestDao.update_Guest(dto);

	}

	@Override
	public void delete_Guest(String userid) {
		guestDao.delete_Guest(userid);
	}

	@Override
	public boolean loginCheck(GuestDTO dto, HttpSession session) {
		boolean result = guestDao.loginCheck(dto);
		if(result) { //로그인 성공시 세션에 저장
			//GuestDTO dto2 = view_Guest(dto.getUserid());
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", dto.getName());
		}
		return result;
	}
	
	@Override
	public boolean isPasswdMatch(String passwd, String dbpasswd) {
		return pwdEncoder.matches(passwd, dbpasswd);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public GuestDTO view_Guest(String userid) {
		return guestDao.view_Guest(userid);
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		return guestDao.checkPw(userid, passwd);
	}

	@Override
	public int idCheck(String userid) throws Exception {
		return guestDao.idCheck(userid);
	}

	@Override
	public int loginLookup(GuestDTO dto) {
		return guestDao.loginLookup(dto);
	}

	@Override
	public void sendEmail(GuestDTO dto, String div, String num) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; //구글 이용시 smtp.gmail.com
		String hostSMTPid = "project-test-user@naver.com";
		String hostSMTPpwd = "project!test";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "project-test-user@naver.com";
		String fromName = "stayhere 관리자";
		String subject = "";
		String msg = "";
		
		if(div.equals("findpw")) {
			subject = "STAYHERE 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += dto.getUserid() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += dto.getPasswd() + "</p></div>";
		} else if(div.equals("auth")) {
			System.out.println("메일 인증 발송 직전!");
			subject = "STAYHERE 인증 코드입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += "[인증번호] " + num + "입니다. <br>인증번호 확인란에 기입하여 주십시오.</h3></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = dto.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			//email.setSSL(true);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //구글 이용시 465
			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			//email.setTLS(true);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
		
	}

	@Override
	public void findPw(HttpServletResponse response, GuestDTO dto) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		GuestDTO ck = guestDao.view_Guest(dto.getUserid());
		PrintWriter out = response.getWriter();
		String num= "";
		// 가입된 아이디가 없으면
		if(guestDao.idCheck(dto.getUserid()) == 0) {
			out.print("등록되지 않은 아이디입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!dto.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pwd = "";
			for(int i = 0; i < 10; i++) {
				pwd+=(char)((Math.random()*26)+97);
			}
			
			dto.setPasswd(pwd);
			// 비밀번호 변경
			guestDao.updatePw(dto);
			// 비밀번호 변경 메일 발송
			sendEmail(dto, "findpw", num);
			
			String encodeigpasswd = pwdEncoder.encode(pwd);
			dto.setPasswd(encodeigpasswd);
			guestDao.updatePw(dto);
			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}
	
//
//	@Override
//	public void authEmail(HttpServletResponse response, HttpSession session, GuestDTO dto) throws Exception {
//		response.setContentType("text/html;charset=utf-8");
//		int checkNum = (int)session.getAttribute("checkNum");
//		System.out.println("인증번호넘어왔는지 확인 : " + checkNum);		
//		String num = Integer.toString(checkNum);
//		sendEmail(dto, "auth", num);
//	}

	@Override
	public int emailCheck(String email) {
		System.out.println("이메일 체크 시작!");
		return guestDao.emailCheck(email);
	}

//	@Override
//	public String getReturnAccessToken(String code) {
//		String access_Token = "";
//		String refresh_token = "";
//        String reqURL = "http://kauth.kakao.com/oauth/token";
//        try {
//           URL url = new URL(reqURL);
//           HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//           
//            //HttpURLConnection 설정 값 셋팅
//            conn.setRequestMethod("POST");
//            conn.setDoOutput(true);
//            
//            // buffer 스트림 객체 값 셋팅 후 요청
//            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//            StringBuilder sb = new StringBuilder();
//            sb.append("grant_type=authorization_code");
//            sb.append("&client_id=8b61a1ad6f82b03d8425e14339a0f7e3");  //앱 KEY VALUE
//            sb.append("&redirect_uri=http://localhost/kakao/kakaoLogin"); // 앱 CALLBACK 경로
//            sb.append("&code=" + code);
//            bw.write(sb.toString());
//            bw.flush();
//            
//            //  RETURN 값 result 변수에 저장
//            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//            String br_line = "";
//            String result = "";
//
//            while ((br_line = br.readLine()) != null) {
//                result += br_line;
//            }
//
//            JsonParser parser = new JsonParser();
//            JsonElement element = parser.parse(result);
//            
//            // 토큰 값 저장 및 리턴
//            access_Token = element.getAsJsonObject().get("access_Token").getAsString();
//            refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
//
//            br.close();
//            bw.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return access_Token;
//	}
//
//	@Override
//	public Map<String, Object> getUserInfo(String access_token) {
//		Map<String,Object> map =new HashMap<>();
//		String reqURL = "https://kapi.kakao.com/v2/user/me";
//        try {
//            URL url = new URL(reqURL);
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("GET");
//           //요청에 필요한 Header에 포함될 내용
//            con.setRequestProperty("Authorization", "Bearer " + access_token);
//            int responseCode = con.getResponseCode();
//            System.out.println("responseCode : " + responseCode);
//            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//            String br_line = "";
//            String result = "";
//            while ((br_line = br.readLine()) != null) {
//                result += br_line;
//            }
//            System.out.println("response:" + result);
//            JsonParser parser = new JsonParser();
//            JsonElement element = parser.parse(result);
//            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//            String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
//            map.put("name", nickname);
//            map.put("profile_image", profile_image);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return map;
//	}
//
//	@Override
//	public void kakao_logout(String access_token) {
//		String reqURL ="https://kapi.kakao.com/v2/user/logout";
//        try {
//            URL url = new URL(reqURL);
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("POST");
//            con.setRequestProperty("Authorization", "Bearer " + access_token);
//            int responseCode = con.getResponseCode();
//            System.out.println("responseCode : " + responseCode);
//            if(responseCode ==400) throw new RuntimeException("카카오 로그아웃 오류");
//            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//            String br_line = "";
//            String result = "";
//            while ((br_line = br.readLine()) != null) {
//                result += br_line;
//            }
//            System.out.println("결과 : " + result);
//        }catch(IOException e) {
//        	e.printStackTrace();
//        }
//	}



	@Override
	public GuestDTO loginOkNick(GuestDTO dto) {
		return guestDao.loginOkNick(dto);
	}

	@Override
	public String memberOne(String email) throws Exception {
		return guestDao.memberOne(email);
	}

	@Override
	public String findId(String email) {
		return guestDao.findId(email);
	}

	@Override
	public String findByPasswd(String userid) {
		return guestDao.findByPasswd(userid);
	}

}
