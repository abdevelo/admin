package com.kbstar.controller;

import com.kbstar.dto.Msg;
import com.kbstar.util.ChatBotUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.io.IOException;

@Controller
public class ChatbotController {
    @Autowired
    SimpMessagingTemplate template;

    @MessageMapping("/chatbotme") // 특정 Id에게 전송
    public void chatbotme(Msg msg, SimpMessageHeaderAccessor headerAccessor) throws IOException {
        // Msg내에는 Sendid와 content 정보를 가지고 있음
        // 그 정보를 다시 보낸 사람에게(target)에게 "/chsemd"로 보내줌
        String target = msg.getSendid();
        String txt = msg.getContent1();
        //****여기서 NCP Chatbot 연동.......******//
        // NCP( naver cloud platform )
        // ncp의 응답 메세지를 보낸사람에게 뿌려주기
        String result = ChatBotUtil.chat(txt);
        msg.setContent1(result);
        template.convertAndSend("/chsend/"+target,msg);
    }
}