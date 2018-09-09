package com.nikhil;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


import javax.servlet.annotation.*;


@MultipartConfig
@WebServlet("/CustomerSection")
public class CustomerSection extends HttpServlet {
	private static final long serialVersionUID = 1L;

  
    public CustomerSection() {
        // TODO Auto-generated constructor stub
    	super();
    }

	
    
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
        CustomerDAOImpl cust = new CustomerDAOImpl();
        String path = ("C:/Users/HP/Desktop/");
		String name = request.getParameter("name");
		String pwd = request.getParameter("psw");
		String email = request.getParameter("email");
		Part filePart = request.getPart("file");
		String submitType = request.getParameter("submit");
	//	String fileName = getFileName(filePart);
		
		OutputStream out = null;
	    InputStream filecontent = null;
	    final PrintWriter writer = response.getWriter();
	    File file = File.createTempFile("personFace", ".jpg");
	    try {
	    //	File file = File.createTempFile("personFace", ".jpg");
	        out = new FileOutputStream(file);
	        filecontent = filePart.getInputStream();
	        
	        int read = 0;
	        final byte[] bytes = new byte[1024];
	        
	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        request.getRequestDispatcher("Login.html").forward(request, response);
	      //  writer.println("New file " + fileName + " created at " + path);
	    } catch (FileNotFoundException fne) {
	        writer.println("You either did not specify a file to upload or are "
	                + "trying to upload a file to a protected or nonexistent "
	                + "location.");
	        writer.println("<br/> ERROR: " + fne.getMessage());
	        
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	        if (filecontent != null) {
	            filecontent.close();
	        }
	        if (writer != null) {
	            writer.close();
	        }
	    }
	    
	    FaceDetect detect = new FaceDetect();
	//File file1 = new File("C:/Users/HP/Desktop/"+fileName);
	   // File file1 = File.createTempFile("personFace", ".jpg");
		System.out.println(file);
		String faceid = detect.getFaceId(file);
		System.out.println(faceid);
		if(submitType.equals("signupbtn")){
		Customer l = new Customer();
		l.setName(name); 
		l.setPassword(pwd);
		l.setEmailid(email);
		l.setFaceid(faceid);
		
		cust.addCustomer(l);
		
	
		
		
	}
	}
//	private String getFileName(final Part part) {
//	   
//	    for (String content : part.getHeader("content-disposition").split(";")) {
//	        if (content.trim().startsWith("filename")) {
//	            return content.substring(
//	                    content.indexOf('=') + 1).trim().replace("\"", "");
//	        }
//	    }
//	    return null;
//	}
}
