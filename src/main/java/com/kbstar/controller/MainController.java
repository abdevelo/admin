package com.kbstar.controller;

import com.kbstar.dto.Item;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.util.List;

@Controller
public class MainController {
    @RequestMapping("/")
    public String main(){
        return "index";
    }

    @RequestMapping("/charts")
    public String charts(Model model){
        model.addAttribute("center", "charts");
        return "index";
    }

}
