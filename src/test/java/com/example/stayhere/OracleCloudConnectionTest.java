package com.example.stayhere;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class OracleCloudConnectionTest {
	//로깅을 위한 변수
	private static final Logger logger = 
			LoggerFactory.getLogger(OracleCloudConnectionTest.class);
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";  //jdbc드라이버
	private static final String URL = "jdbc:oracle:thin:@spotlight_medium?TNS_ADMIN=C:/Wallet_spotlight";  //url
	private static final String USER = "ADMIN";  //계정정보
	private static final String PW = "Spotlight123";  //비밀번호	
	
	@Test
	public void test() throws Exception {
		Class.forName(DRIVER); //드라이버 로딩
		//try~with문
		try(Connection conn = DriverManager.getConnection(URL, USER, PW)) {
			//System.out.println()문과 동일한 효과
			//로거를 사용하면 서버시스템 부하가 적게 발행한다.
			logger.info("오라클 클라우드에 연결되었습니다."); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
