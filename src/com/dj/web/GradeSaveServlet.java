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
import com.dj.util.StringUtil;
import com.sun.xml.internal.ws.util.StreamUtils;

public class GradeSaveServlet extends HttpServlet{
	
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
		request.setCharacterEncoding("utf-8");
		String gradeName=request.getParameter("gradeName");
		String gradeDesc=request.getParameter("gradeDesc");
		String id=request.getParameter("id");
		Grade grade=new Grade(gradeName,gradeDesc);
		if(StringUtil.isNotEmpty(id)){
			grade.setId(Integer.parseInt(id));
		}
		Connection con=null;
		try {
			con=dbUtil.open();
			int saveNum=0;
			JSONObject result=new JSONObject();
			if(StringUtil.isNotEmpty(id)){
				saveNum=gradeDao.gradeEdit(con, grade);
			}else{
				saveNum=gradeDao.gradeAdd(con, grade);				
			}
			if(saveNum>0){
				result.put("success", "true");
			}else{
				result.put("success", "true");
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
