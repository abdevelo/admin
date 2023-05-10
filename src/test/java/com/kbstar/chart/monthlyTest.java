package com.kbstar.chart;

import com.kbstar.dto.Chart;
import com.kbstar.service.ChartService;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@Slf4j
@SpringBootTest
class monthlyTest {
    @Autowired
    ChartService service;
    @Test
void contextLoads() {
        // [] 배열
        // [{},{},.. ] 객체 in 배열
        // [{key:value},{},.. ] 키:값 in 객체 in 배열
    try {
        List<Chart> list = service.getMonthlyTotal();
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
        fmo.put("name", "Female"); //첫번째 객체
        fmo.put("data", fma);
        mo.put("name", "Male");
        mo.put("data", ma);

        JSONArray data = new JSONArray();
        data.add(fmo);
        data.add(mo);

        log.info("------------------------------------------");
        log.info(data.toJSONString());
        log.info("------------------------------------------");
        log.info(fmo.toJSONString());
        log.info(mo.toJSONString());
        log.info("------------------------------------------");

    } catch (Exception e) {
        log.info("조회 에러......");
        e.printStackTrace();
        }
    }
}
