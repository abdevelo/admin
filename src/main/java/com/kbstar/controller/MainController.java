package com.kbstar.controller;

import com.kbstar.dto.Adm;
import com.kbstar.dto.Cust;
import com.kbstar.dto.Item;
import com.kbstar.service.AdmService;
import com.kbstar.service.SalesService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpSession;
import java.util.List;

@Slf4j
@Controller
public class MainController {
    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    AdmService admService;

    @Value("${adminserver}")
    String adminserver;

    @Autowired
    SalesService salesService;

    @RequestMapping("/")
    public String main(Model model) throws Exception {
        model.addAttribute("adminserver", adminserver);
        return "index";
    }

    @RequestMapping("/charts")
    public String charts(Model model){
        model.addAttribute("center", "charts");
        return "index";
    }

    @RequestMapping("/livecharts")
    public String livecharts(Model model){
        model.addAttribute("adminserver", adminserver);
        model.addAttribute("center", "livecharts");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model,String redirectURL){
        model.addAttribute("center", "login");
        model.addAttribute("redirectURL", redirectURL);
        return "index";
    }

    @RequestMapping("/loginimpl")
    public String loginimpl(Model model, String id, String pwd, HttpSession session, String redirectURL){
        Adm adm = null;
        String nextPage = "loginfail";
        try {
            adm = admService.get(id);
            if(adm != null && encoder.matches(pwd, adm.getPwd())){
                nextPage = "loginok";
                session.setMaxInactiveInterval(100000);// 한 session의 제한시간
                session.setAttribute("loginadm",adm); //session에 logincust라는 이름으로 cust를 넣어줌 --> login을 메모리에 제한시간만큼 유지
                if(redirectURL == null || redirectURL.equals("")){
                    return "redirect:/";
                }else{
                    return "redirect:"+redirectURL;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("시스템 장애 잠시 후 다시 로그인 하세요.");
        }
        model.addAttribute("center", nextPage);
        return "index";
    }


    @RequestMapping("/register")
    public String register(Model model, String id, String pwd, String lev){
        model.addAttribute("center", "register");
        return "index";
    }

    @RequestMapping("/registerimpl")
    public String registerimpl(Model model, Adm adm, HttpSession session) throws Exception {
        //cust객체의 id,pwd,name이라는 필드가 input태그 name들의 요소와 일치하면 자동으로 dto가되서 들어온다
        try {
            adm.setPwd(encoder.encode(adm.getPwd())); // 0502 화면에서 입력한 pwd를 가져와서 암호화 후 다시 cust객체의 pwd에 입력
            admService.register(adm);
            session.setMaxInactiveInterval(100000);// 한 session의 제한시간
            session.setAttribute("loginadm",adm);
        } catch (Exception e) {
            throw new Exception("가입 오류");
        }
        model.addAttribute("radm", adm);
        // model.addAttribute("center", "registerok"); // center->registerok 로 바꿔 register완료된 후 registerok.jsp 화면이 나오도록
        return "redirect:/";
    }


    @RequestMapping("/adminfo")
    public String adminfo(Model model, String id) throws Exception {
        Adm adm =null;
        try {
            adm = admService.get(id);
        } catch (Exception e) {
            throw new Exception("시스템 장애");
        }
        model.addAttribute("adminfo", adm);
        model.addAttribute("center", "adminfo");
        return "index";
    }


    @RequestMapping("/logoutimpl")
    public String logoutimpl(Model model, HttpSession session){
        // logout이라는 클래스?함수?를 스프링에서 사용 중이므로 logoutimpl로 명명
        if(session !=null){
            session.invalidate();
            //invalidate : logout시 세션 정보를 없애는 함수
        }
        return "redirect:/";
    }

    @RequestMapping("/websocket")
    public String websocket(Model model ){
        model.addAttribute("adminserver", adminserver);
        model.addAttribute("center", "websocket");
        return "index";
    }

    @RequestMapping("/callcenter")
    public String callcenter(Model model){
        model.addAttribute("adminserver", adminserver);
        model.addAttribute("center", "callcenter");
        return "index";
    }



}
