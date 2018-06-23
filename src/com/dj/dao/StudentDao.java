package com.dj.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dj.model.PageBean;

public class StudentDao {
	public ResultSet studentList(Connection con,PageBean pageBean)throws Exception{
		StringBuffer sb=new StringBuffer("select * from student s,grade g where s.gradeId=g.id");
		if(pageBean!=null){
			sb.append(" limit "+pageBean.getStart()+","+pageBean.getRows());
		}
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		return pstmt.executeQuery();
	}
	
	public int studentCount(Connection con)throws Exception{
		StringBuffer sb=new StringBuffer("select count(*) as total from student s,grade g where s.gradeId=g.id");
		PreparedStatement pstmt=con.prepareStatement(sb.toString());
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			return rs.getInt("total");
		}else{
			return 0;
		}
	}
}
