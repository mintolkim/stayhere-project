package com.example.stayhere.controller;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.stayhere.service.chart.ChartService;

@RestController
@RequestMapping("chart/*")
public class ChartController {
	
	  @Inject ChartService chartservice;
	 
	 // view(jsp)로 넘어가지 않고 호출한 곳에 JSONObject를 리턴함
	  
	 @RequestMapping("montlychart") 
	 public JSONObject montlychart() {
	 return chartservice.getChartData(); 
	 }
	 
	 @RequestMapping("monthchart") 
	 public ModelAndView monthchart() {
		 return new ModelAndView("admin/monthly_chart"); 
		 }
	 
	 @RequestMapping("categorychart") 
	 public ModelAndView categorychart() {
		 return new ModelAndView("admin/category_chart"); 
	 }

	 @RequestMapping("cateChart") 
	 public JSONObject cateChart() {
		 return chartservice.getCateChartData(); 
	 }
}
