package com.kbstar.service;

import com.kbstar.dto.Chart;
import com.kbstar.mapper.ChartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service //service annotation을 안하면 @Autowired가 안 먹음
public class ChartService {

    @Autowired
    ChartMapper chartMapper;
    public List<Chart> getMonthlyTotal() throws Exception{
        return chartMapper.getMonthlyTotal();
    }
}
