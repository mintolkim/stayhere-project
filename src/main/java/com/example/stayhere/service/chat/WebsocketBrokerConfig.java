package com.example.stayhere.service.chat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import lombok.extern.slf4j.Slf4j;

@Configuration
@EnableWebSocketMessageBroker
@Slf4j
public class WebsocketBrokerConfig implements WebSocketMessageBrokerConfigurer {


	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		
		log.info("configureMessageBroker 실행");
		//for subscribe prefix
		registry.enableSimpleBroker("/user");
		//for publish prefix
		registry.setApplicationDestinationPrefixes("/app");
		//user destination provides ability to have unique user queue
		//registry.setUserDestinationPrefix("/user");
		
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		log.info("registerStompEndpoints 실행");
		registry.addEndpoint("/broadcast")
			.withSockJS()
			.setHeartbeatTime(60_000);
//
//		//when browser or network cause problems fallback allows realtime connectivity 
//		registry.addEndpoint("/broadcast")
//				.withSockJS()
//				.setHeartbeatTime(60_000);
	}

//	@Override
//	public boolean configureMessageConverters(List<MessageConverter> messageConverters) {
//		
//		DefaultContentTypeResolver resolver = new DefaultContentTypeResolver();
//		resolver.setDefaultMimeType(MimeTypeUtils.APPLICATION_JSON);
//		MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
//		converter.setObjectMapper(new ObjectMapper());
//		converter.setContentTypeResolver(resolver);
//		messageConverters.add(converter);
//		
//		return false;
//	}


}