package com.kbstar.dto;

import lombok.*;
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class ItemSearch {
    private String name;
    private Integer price;
//    private int price;
    //int는 널을 받지 못하지만 객체형태인 integer는 null 값을 받을 수 있음
    private String startdate;
    private String enddate;
}