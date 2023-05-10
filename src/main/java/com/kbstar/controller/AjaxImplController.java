package com.kbstar.controller;

import com.kbstar.dto.Adm;
import com.kbstar.dto.Chart;
import com.kbstar.service.AdmService;
import com.kbstar.service.ChartService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AjaxImplController {

    @Autowired
    AdmService admService;
    @Autowired
    ChartService chartService;

    @RequestMapping("/checkid")
    public Object checkid(String id) throws Exception {
        int result = 0;
        Adm adm = null;
        adm = admService.get(id);
        if (adm != null) {
            result = 1;
        }
        return result;  // result =1 ->  사용할 수 없는 아이디
    }

    @RequestMapping("/chart1")
    public Object chart1() throws Exception {
        List<Chart> list = chartService.getMonthlyTotal();
        JSONArray fma = new JSONArray();
        JSONArray ma = new JSONArray();
        for ( Chart c : list ){
            if ( c.getGender().toUpperCase().equals("F")){
                fma.add(c.getTotal());
            }else {
                ma.add(c.getTotal());
            }
        }
        JSONObject fmo = new JSONObject();
        JSONObject mo = new JSONObject();
        fmo.put("name", "Female"); //첫번째 객체 ( 로그에서 보이는 것은 상관 없음 )
        fmo.put("data", fma);
        mo.put("name", "Male");
        mo.put("data", ma);
        JSONArray data = new JSONArray();
        data.add(fmo);
        data.add(mo);
        return data;
    }
}
