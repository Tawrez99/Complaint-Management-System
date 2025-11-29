/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gatepass;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SaveForeignerGatePasData extends HttpServlet {

	Connection conn;
	public void init(ServletConfig config) throws ServletException {
		System.out.println("SaveForeignerGatePasData Init");
		
   	    super.init(config);
	
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{	
		System.out.println("SaveForeignerGatePasData Init");

try{
	response.setContentType("text/html");
	PrintWriter out=response.getWriter();
	System.out.println("Image");
	Demo d=new Demo();
	
	int i=d.getmaxid();
	System.out.print("id*********"+i);
	int id=i+1;
	
	response.reset();
	Connection conn = null;
	Database db = new Database();	
	conn = db.getConnection();
	
		 PreparedStatement ps = 
		 conn.prepareStatement("INSERT INTO GATEPASS_FOREIGNER VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

		String sss=request.getAttribute("image").toString();
		
		  System.out.println("Image file into String-->"+sss);
		   File binaryfile =new File(sss);
		   FileInputStream fs = new FileInputStream(binaryfile);
		   System.out.println("Image inserting in table as binary file-->"+fs);
		   
		  ps.setInt(1,Integer.parseInt(request.getAttribute("srNo").toString()));
                   ps.setString(2,request.getAttribute("workSite").toString());	
                   ps.setString(3,request.getAttribute("visitingDept").toString());
		  	
		
		
		 
		  ps.setString(4,request.getAttribute("name").toString());		
		  ps.setString(5,request.getAttribute("fatherName").toString());		 
		  ps.setString(6,request.getAttribute("desig").toString());
                  ps.setInt(7,Integer.parseInt(request.getAttribute("age").toString()));
                  
		  ps.setString(8,request.getAttribute("localAddress").toString());		 
		  ps.setString(9,request.getAttribute("permanentAddress").toString());		
		  ps.setString(10,request.getAttribute("nationality").toString());
		  
					
		  ps.setString(11,request.getAttribute("valdity_fromDate").toString());		 
		  ps.setString(12,request.getAttribute("valdity_toDate").toString());		
		  		  	 
		  //for image
		  ps.setBinaryStream(13,fs,(int)fs.available()) ;
		  System.out.println("Inserting image value --"+fs.toString());
		 
		  
		  CommonService cs = new CommonService();
		  System.out.println("date  --"+cs.selectDateTime().toString());
		  ps.setString(14,cs.selectDateTime().toString());		 
		  ps.setInt(15,0);	
		  
		  

		  request.setAttribute("image",null);   
		
		  
		  
		   int is =(ps.executeUpdate());
		   ps.close();
		   
		   if(is==1){
			   System.out.println("Data Inserted Successfully");
			   
			   /********delete all the files from the directory***********/
			   request.getHeader("VIA");
			   String ipAddress = request.getHeader("X-FORWARDED-FOR");
			   if(ipAddress == null){
			       ipAddress = request.getRemoteAddr();
			       System.out.println("Incase of null IP -"+ipAddress );
			   }
			    
			   System.out.println("IP and Country-"+ipAddress );
			   
			   
			   File file = new File("////10.3.122.106//Users//bank");        
		        String[] myFiles;      
		            if(file.isDirectory()){  
		                myFiles = file.list();  
		                for (int in=0; in<myFiles.length; in++) {  
		                    File myFile = new File(file, myFiles[in]);   
		                    myFile.delete();  
		                    System.out.println("Data deleted Successfully");
		                    }}  
		            String srNo=request.getAttribute("srNo").toString();
		            
		
		
		
			 request.getRequestDispatcher("PrintForeignerGatePass.jsp?srNo="+srNo).forward(request, response);
			 
			conn.close();  }
		   else{
			   out.println("Problem in Data Insertion");
		   
		   }  
		   }
		   catch (Exception e){
		   System.out.println("Error-"+e.toString());
		   e.printStackTrace();
		   }
		 
		   }
}
