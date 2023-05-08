package com.kbstar.controller;

import com.kbstar.dto.Marker;
import com.kbstar.dto.MarkerSearch;
import com.kbstar.service.MarkerService;
import com.kbstar.util.FileUploadUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.sql.ClientInfoStatus;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/marker")
public class MarkerController {

    @Autowired
    MarkerService markerService;

    String dir = "marker/";

    @Value("${uploadimgdir}") //application.properties 내의 경로설정 변수가 여기로 입력됨
    String uploaddir;
    @RequestMapping("/add")
    public String add(Model model){
        model.addAttribute("center",dir+"add");
        return "index";
    }

    @RequestMapping("/all")
    public String all(Model model) throws Exception {
        List<Marker> list = markerService.get();
        model.addAttribute("mlist", list);
        model.addAttribute("center",dir+"all");
        return "index";
    }


    @RequestMapping("/addimpl")
    public String addimpl(Model model, Marker marker) throws Exception {
        MultipartFile mf = marker.getImgF();
        String imgname = mf.getOriginalFilename();
        marker.setImg(imgname);
        markerService.register(marker);
        FileUploadUtil.saveFile(mf,uploaddir); //util에서 파일덩어리 입력 시 경로에 저장해주는 유틸있음
        return "redirect:/marker/all";
    }

    @RequestMapping("/updateimpl")
    public String updateimpl(Model model, Marker marker) throws Exception {
        MultipartFile mf = marker.getImgF();
        String imgname = mf.getOriginalFilename();
        if ( imgname.equals("") || imgname == null ){
            markerService.modify(marker);
        }else {
            marker.setImg(imgname);
            markerService.modify(marker);
            FileUploadUtil.saveFile(mf,uploaddir);
        }
        return "redirect:/marker/detail?id="+marker.getId();
    }

    @RequestMapping("/detail")
    public String detail(Model model, int id) throws Exception {
        Marker marker = null;
        marker = markerService.get(id);
        model.addAttribute("gmarker", marker);
        model.addAttribute("center",dir+"detail");
        return "index";
    }

    @RequestMapping("/search")
    public String search(Model model, MarkerSearch ms) throws Exception {
        List<Marker> list = markerService.search(ms);
        model.addAttribute("ms", ms); //서버로 들어온 ms의 값을 ms에 다시 넣고 ---> 아래
        model.addAttribute("mlist", list);
        model.addAttribute("center", dir + "all"); //all 에서 만들 때 빼가서 써라 ~~~
        return "index";
    }

}
