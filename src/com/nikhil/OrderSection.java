package com.nikhil;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Reader;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;

@WebServlet("/OrderSection")
public class OrderSection extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrderSection() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		String submitType = request.getParameter("submit");
		if (submitType.equals("Order")) {
			request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);

		}

		

	}

}
