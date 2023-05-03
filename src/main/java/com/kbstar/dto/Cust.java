package com.kbstar.dto;

import lombok.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Cust {
    @Size(min=4, max=10, message="최소4개 최대10개 입니다.")
    @NotEmpty(message = "아이디는 필수항목입니다.")
    private String id;
    @Size(min=5, max=10, message="최소5개 최대10개 입니다.")
    @NotEmpty(message = "패스워드는 필수항목입니다.")
    private String pwd;
    @NotEmpty(message = "이름은 필수항목입니다.")
    private String name;
}
