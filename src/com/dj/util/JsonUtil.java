package com.dj.util;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Date;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JsonUtil {
	
	public static JSONArray formatRsToJsonArray(ResultSet rs)throws Exception{
		ResultSetMetaData md=rs.getMetaData();
		int num=md.getColumnCount();
		JSONArray array=new JSONArray();
		while(rs.next()){
			JSONObject ob=new JSONObject();
			for(int i=1;i<=num;i++){
				Object object=rs.getObject(i);
				if(object instanceof Date){
					ob.put(md.getColumnName(i),DateUtil.formatDate((Date)object, "yyyy-MM-dd"));
				}else{
					ob.put(md.getColumnName(i), rs.getObject(i));					
				}
			}
			array.add(ob);
		}
		return array;
	}

}
