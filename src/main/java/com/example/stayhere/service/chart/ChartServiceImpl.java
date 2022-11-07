package com.example.stayhere.service.chart;


import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.example.stayhere.model.reservations.dto.ReservationsDTO;
import com.example.stayhere.service.reservations.ReservationsService;

@Service
public class ChartServiceImpl implements ChartService {

	@Inject
	ReservationsService rsservice;
	
	@Override
	public JSONObject getChartData() {
		List<ReservationsDTO> items=rsservice.resTotalMoney();
		//리턴할 최종 json 객체
		JSONObject data=new JSONObject();
		//컬럼을 정의할 json 객체
		JSONObject col1=new JSONObject();
		JSONObject col2=new JSONObject();
		JSONArray title=new JSONArray();
		//json의 cols 객체구성(헤더,제목)
		col1.put("label", "월");
		col1.put("type", "string");
		col2.put("label", "합계");
		col2.put("type", "number");
		//json 배열에 json 객체 추가
		title.add(col1);
		title.add(col2);
		data.put("cols", title);
		//json의 rows 객체구성(바디, 내용)
		JSONArray body=new JSONArray();
		for(ReservationsDTO dto : items) {
			JSONObject name=new JSONObject();//JSONObject는 HashMap과 같음
			name.put("v", dto.getMonth());
			JSONObject money=new JSONObject();
			money.put("v", dto.getMonthlymoney());
			JSONArray row=new JSONArray();
			row.add(name);
			row.add(money);
			JSONObject cell=new JSONObject();
			cell.put("c", row);
			body.add(cell);
		}
		data.put("rows", body);

		return data;
	}

	@Override
	public JSONObject getCateChartData() {
		List<ReservationsDTO> items=rsservice.resCateTotalMoney();
		//리턴할 최종 json 객체
		JSONObject data=new JSONObject();
		//컬럼을 정의할 json 객체
		JSONObject col1=new JSONObject();
		JSONObject col2=new JSONObject();
		JSONArray title=new JSONArray();
		//json의 cols 객체구성(헤더,제목)
		col1.put("label", "숙소유형");
		col1.put("type", "string");
		col2.put("label", "합계");
		col2.put("type", "number");
		//json 배열에 json 객체 추가
		title.add(col1);
		title.add(col2);
		data.put("cols", title);
		//json의 rows 객체구성(바디, 내용)
		JSONArray body=new JSONArray();
		for(ReservationsDTO dto : items) {
			JSONObject name=new JSONObject();
			name.put("v", dto.getRoom_type());
			JSONObject money=new JSONObject();
			money.put("v", dto.getYearmoney());
			JSONArray row=new JSONArray();
			row.add(name);
			row.add(money);
			JSONObject cell=new JSONObject();
			cell.put("c", row);
			body.add(cell);
		}
		data.put("rows", body);

		return data;
	}

}
