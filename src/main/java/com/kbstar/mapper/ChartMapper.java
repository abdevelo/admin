package com.kbstar.mapper;

import com.kbstar.dto.Chart;
import com.kbstar.frame.KBMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ChartMapper {
    // key 값은 없고 value값은 Chart가 됨
    // 지금 현재 상황으로는 KBMapper를 상속받아서 할 필요가 없음 CRUD를 사용하지 않기 때문
    // 하지만 향후에 AnalysisKBMapper 등을 만들어서 상속해서 사용할 수도 있음

    List<Chart> getMonthlyTotal();



}
