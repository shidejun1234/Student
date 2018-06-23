package com.dj.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.dj.dao.GradeDao;
import com.dj.model.Grade;
import com.dj.model.PageBean;
import com.dj.util.DbUtil;
import com.dj.util.JsonUtil;
import com.dj.util.ResponseUtil;

public class GradeDeleteServlet extends HttpServlet{
	
	DbUtil dbUtil=new DbUtil();
	GradeDao gradeDao=new GradeDao();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String delIds=request.getParameter("delIds");
		Connection con=null;
		try {
			con=dbUtil.open();
			JSONObject result=new JSONObject();
			int delNum=gradeDao.gradeDelect(con, delIds);
			if(delNum>0){
				result.put("delNum", delNum);
				result.put("success", "true");
			}else{
				result.put("errMsg", "删除失败");
			}
			ResponseUtil.write(response, result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				dbUtil.close(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
