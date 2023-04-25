package com.kbstar.controller;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Random;


@RestController
public class ItemImplController {

    @RequestMapping("/chart0301")
    public Object chart0301() {
        // 배열 in 배열 형태 [ [], [], .....]
        JSONArray ja = new JSONArray();
        for (int i = 1; i <= 5; i++) {
            Random r = new Random();
            int num = r.nextInt(20) + 1;
            JSONArray jadata = new JSONArray();
            jadata.add("data" + num); // 데이터의 이름을 가상으로 만듦
            jadata.add(num);
            ja.add(jadata);
        }
        return ja;
    }

    @RequestMapping("/chart0302")
    public Object chart0302() {
        JSONObject jo = new JSONObject();
        JSONArray age = new JSONArray();
        for (int i = 1; i <= 10; i++) {
            age.add(i);
        }
        JSONArray ja = new JSONArray();
        for (int i = 1; i <= 10; i++) {
            Random r = new Random();
            int num = r.nextInt(50000) + 1;
            ja.add(num);
        }
        jo.put("age", age);
        jo.put("data2", ja);
        return jo;
    }

    @RequestMapping("/chart0303")
    public Object chart0303(){
        JSONObject jo = new JSONObject();
        JSONArray[] countries = {new JSONArray(),new JSONArray(),new JSONArray(),new JSONArray()};

        for(JSONArray country : countries){
            for (int i =1; i<33; i++){
                Random r = new Random();
                int num = r.nextInt(100)+1;
                country.add(num);
            }
        }// countries배열 내의 각 객체(또 다른 배열)에 32개의 랜덤 숫자를 넣었음

        String[] countryName = {"china", "usa", "eu", "india"};


            for ( int i=0; i< countries.length; i++){
                jo.put(countryName[i], countries[i]);
            }
        return jo;
    }
//    public Object chart0303() {
//        JSONObject jo = new JSONObject();
//
//        JSONArray china = new JSONArray();
//        JSONArray usa = new JSONArray();
//        JSONArray eu = new JSONArray();
//        JSONArray india = new JSONArray();
//
//        for (int i = 1; i < 33; i++) {
//            Random r = new Random();
//            int num = r.nextInt(100) + 1;
//            china.add(num);
//        }
//
//        for (int i = 1; i < 33; i++) {
//            Random r = new Random();
//            int num = r.nextInt(100) + 1;
//            usa.add(num);
//        }
//
//        for (int i = 1; i < 33; i++) {
//            Random r = new Random();
//            int num = r.nextInt(100) + 1;
//            eu.add(num);
//        }
//
//        for (int i = 1; i < 33; i++) {
//            Random r = new Random();
//            int num = r.nextInt(100) + 1;
//            india.add(num);
//        }
//        jo.put("china", china);
//        jo.put("usa", usa);
//        jo.put("eu", eu);
//        jo.put("india", india);
//
//        return jo;
//    }


}
