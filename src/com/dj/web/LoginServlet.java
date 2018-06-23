package com.dj.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dj.dao.UserDao;
import com.dj.model.User;
import com.dj.util.DbUtil;
import com.dj.util.StringUtil;

public class LoginServlet extends HttpServlet{
	
	DbUtil dbUtil=new DbUtil();
	UserDao userDao=new UserDao();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		System.out.println(username+","+password);
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		if(StringUtil.isEmpty(username)||StringUtil.isEmpty(password)){
			request.setAttribute("error", "用户名或密码不能为空");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}else{
			User user=new User(username,password);
			Connection con=null;
			try {
				con=dbUtil.open();
				User cUser=userDao.login(con, user);
				if(cUser==null){
					request.setAttribute("error", "用户名或密码错误");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}else{
					HttpSession session=request.getSession();
					session.setAttribute("cUser", cUser);
					response.sendRedirect("main.jsp");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}
	
	
	
}
