package com.example.stayhere.model.host.dao;


import java.util.Map;

import com.example.stayhere.model.host.dto.HostDTO;

public interface HostDAO {
	 public boolean loginCheck(HostDTO dto);
	 public HostDTO viewHost(String h_userid);
	 public void insert(HostDTO host);
	 public int idCheck(String h_userid);
	 public void update(HostDTO host);
	 public void delete(String h_userid);
}
