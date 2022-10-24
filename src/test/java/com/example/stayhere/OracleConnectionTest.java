package com.example.stayhere;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class OracleConnectionTest {
	//로깅을 위한 변수 선언
		private static final Logger logger=
				LoggerFactory.getLogger(OracleConnectionTest.class);
		private static final String DRIVER
			="oracle.jdbc.driver.OracleDriver";
		//연결문자열 jdbc:oracle:thin:@호스트:포트:sid
		private static final String URL
			="jdbc:oracle:thin:@localhost:1521:xe";
		private static final String USER="spring"; //아이디
		private static final String PW="1234"; //비번

		@Test 
		public void test() throws Exception {
			Class.forName(DRIVER); //드라이버 로딩
			//try ~ with문 으로서  {} 대신 try() 주의
			try(Connection conn=
					DriverManager.getConnection(URL,USER,PW)){
				logger.info("오라클에 연결되었습니다.");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

}
