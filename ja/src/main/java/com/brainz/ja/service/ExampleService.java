package com.brainz.ja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brainz.ja.mapper.SQLMapper;

@Service
public class ExampleService {
	
	@Autowired
	private SQLMapper sqlMapper;
	
	public void test() {
		sqlMapper.test();
	}
}
