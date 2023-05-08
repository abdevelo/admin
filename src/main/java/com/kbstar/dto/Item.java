package com.kbstar.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Item {
    private int id; //sequence 값
    private String name;
    private int price;
    private String imgname;
    private Date rdate; // 현재 날짜

    private MultipartFile img; //0504 파일올리기 , 화면 단 input창의 name속성과 동일 값이어야 함

    public Item(int id, String name, int price, String imgname, Date rdate) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imgname = imgname;
        this.rdate = rdate;
    }
}
