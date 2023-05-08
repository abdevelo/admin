package com.kbstar.marker;

import com.kbstar.dto.MarkerSearch;
import com.kbstar.service.MarkerService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * 4.27 정인보 selectAll 테스트 완료
 *
 */
@Slf4j // 로그 찍을거야
@SpringBootTest
class SearchTest {
    @Autowired
    MarkerService service;
    @Test
    void contextLoads() {
        try {
            MarkerSearch ms = new MarkerSearch("", null); // null 값을 "" 으로 테스트할 경우 어떤 값도 조회되지 않음
            service.search(ms);
        } catch (Exception e) { // 오류 예외처리(자동)
            e.printStackTrace();
        }
    }
}
