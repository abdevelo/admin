package com.kbstar;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@EnableWebSocketMessageBroker // WebSocket message handling을 활성화
@Configuration // java Config 설정 클래스임을 표시
public class StomWebSocketConfig implements WebSocketMessageBrokerConfigurer{
    // StomWebSocketConfig는 WebSocketMessageBrokerConfigurer의 구현체

    @Value("${serviceserver}")
    String serviceserver;
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {

        // STOMP 메시지를 처리하는 데 사용할 웹소켓 엔드포인트를 등록
        // '/ws', '/wss', '/chbot'경로를 등록하고 접근을 허용한 "http://127.0.0.1" 줏로 소캣울 샹송
        registry.addEndpoint("/ws").setAllowedOrigins("http://127.0.0.1",serviceserver).withSockJS();
        // setAllowedOrigins : 현재 admin은 127.0.0.1:8088 이지만 127.0.0.1로 접속한 것도 여기로(/ws) 접속되도록 허가해주겠다.

        registry.addEndpoint("/wss").setAllowedOrigins("http://127.0.0.1").withSockJS();
        registry.addEndpoint("/chbot").setAllowedOrigins("http://127.0.0.1").withSockJS();
    }

    /* 어플리케이션 내부에서 사용할 path를 지정할 수 있음 */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 메세지 브로커의 구성을 위한 메소드
        // '/send'와 '/broadcast' 두 가지 큐를 구독하고, 구독자에게 해당 큐에 있는 메세지를 전달하는 데 사용
        // 큐 = 메일함( 메세지가 배달 되는 ), 강사님은 통로라고 칭하심 
        // 클라이언트는 어떤 큐를 구독할지 명확히 해야 함
        // 메세지 브로커는 구독한 클라이언트에게 어떤 메세지가 전달될 지 정확히 해야 함
        registry.enableSimpleBroker("/send","/sendadm");
    }
}