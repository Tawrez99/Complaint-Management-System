package gatepass;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/saveContractLabourDetails")
public class SaveContractLabourData extends HttpServlet {

	Connection conn;
	public void init(ServletConfig config) throws ServletException {
		System.out.println("SaveContractLabourData Init");
		
   	    super.init(config);
	
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{	
		System.out.println("SaveContractLabourData Init");

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
		 conn.prepareStatement("INSERT INTO GATEPASS_CONTRACT_LABOUR VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

		String sss=request.getAttribute("image").toString();
		
		  System.out.println("Image file into String-->"+sss);
		   File binaryfile =new File(sss);
		   FileInputStream fs = new FileInputStream(binaryfile);
		   System.out.println("Image inserting in table as binary file-->"+fs);
		   
		  ps.setInt(1,Integer.parseInt(request.getAttribute("srNo").toString()));
		  
		  if(request.getAttribute("refNo")=="" || request.getAttribute("refNo")==null || request.getAttribute("refNo")==" "){
			  ps.setInt(2,0);  
		  }
		  else{
			  ps.setInt(2,Integer.parseInt(request.getAttribute("refNo").toString()));	 
		  }
		 
		  //ps.setString(2,request.getAttribute("refNo").toString());
		  ps.setString(3,request.getAttribute("renwlTypeSel").toString());
		 
		  ps.setString(4,request.getAttribute("name").toString());		
		  ps.setString(5,request.getAttribute("fatherName").toString());		 
		  ps.setString(6,request.getAttribute("desig").toString());		

		  //ps.setString(7,request.getAttribute("age").toString());
		  ps.setInt(7,Integer.parseInt(request.getAttribute("age").toString()));	
		  ps.setString(8,request.getAttribute("localAddress").toString());		 
		  ps.setString(9,request.getAttribute("permanentAddress").toString());		
		  
		  
		  ps.setString(10,request.getAttribute("contrctrNameAddress").toString());
		  
		  ps.setString(11," ");		 
		  //ps.setString(12," ");	
		  
		 // ps.setString(11,request.getAttribute("workSite").toString());		 
		 ps.setString(12,request.getAttribute("vehicleNumber").toString());	
		  
		  ps.setString(13,request.getAttribute("identification").toString());		
		  ps.setString(14,request.getAttribute("valdity_fromDate").toString());		 
		  ps.setString(15,request.getAttribute("valdity_toDate").toString());		
		  		  	 
		  //for image
		  ps.setBinaryStream(16,fs,(int)fs.available()) ;
		  System.out.println("Inserting image value --"+fs.toString());
		 
		  
		  CommonService cs = new CommonService();
		  System.out.println("date  --"+cs.selectDateTime().toString());
		  ps.setString(17,cs.selectDateTime().toString());		 
		  ps.setInt(18,0);	
		  
		  

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
			   
			   
			   File file = new File("////10.3.111.103//Users//bank");        
		        String[] myFiles;      
		            if(file.isDirectory()){  
		                myFiles = file.list();  
		                for (int in=0; in<myFiles.length; in++) {  
		                    File myFile = new File(file, myFiles[in]);   
		                    myFile.delete();  
		                    System.out.println("Data deleted Successfully");
		                    }}  
		            String srNo=request.getAttribute("srNo").toString();
		            
		    /* ************************************************** */
		          
		/*	String srNo=request.getAttribute("srNo").toString();
			String refNo=request.getAttribute("refNo").toString();
			String renwlTypeSel=request.getAttribute("renwlTypeSel").toString();
			String name=request.getAttribute("name").toString();
			String fatherName=request.getAttribute("fatherName").toString();
			String desig=request.getAttribute("desig").toString();
			String age=request.getAttribute("age").toString();
			String localAddress=request.getAttribute("localAddress").toString();
			String permanentAddress=request.getAttribute("permanentAddress").toString();
			String contrctrNameAddress=request.getAttribute("contrctrNameAddress").toString();
			//String workSite=request.getAttribute("workSite").toString();
			
			//String vehicleNumber=request.getAttribute("vehicleNumber").toString();
			String identification=request.getAttribute("identification").toString();
			String valdity_fromDate=request.getAttribute("valdity_fromDate").toString();
			String valdity_toDate=request.getAttribute("valdity_toDate").toString();

			

			request.setAttribute("srNo", srNo);
			request.setAttribute("refNo", refNo);
			request.setAttribute("renwlTypeSel", renwlTypeSel);
			request.setAttribute("name", name);
			request.setAttribute("fatherName", fatherName);
			request.setAttribute("desig", desig);
			request.setAttribute("age", age);
			request.setAttribute("localAddress", localAddress);
			request.setAttribute("permanentAddress", permanentAddress);
			request.setAttribute("contrctrNameAddress", contrctrNameAddress);
			//request.setAttribute("workSite", workSite);
			//request.setAttribute("vehicleNumber", vehicleNumber);
			request.setAttribute("identification", identification);
			
			request.setAttribute("valdity_fromDate", valdity_fromDate);
			request.setAttribute("valdity_toDate", valdity_toDate);*/
			
		
		
			 request.getRequestDispatcher("PrintContractLabour.jsp?srNo="+srNo).forward(request, response);
			 
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
