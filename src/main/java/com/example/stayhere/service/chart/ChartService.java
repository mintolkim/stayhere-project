package com.example.stayhere.service.chart;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

public interface ChartService {
	public JSONObject getChartData();//월별차트
	public JSONObject getCateChartData();//숙소별차트
}
