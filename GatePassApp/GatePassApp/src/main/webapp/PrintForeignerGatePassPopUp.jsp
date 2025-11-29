<%-- 
    Document   : PrintForeignerGatePassPopUp
    Created on : 30 Aug, 2014, 11:08:16 AM
    Author     : Hrishikesh
--%>

<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>

<head>

  <%
	String srNo=request.getParameter("srNo").toString();
	System.out.println("Image Pop Up for--"+srNo);
	Connection conn = null;
    	Statement st=null;
 	gatepass.Database db = new gatepass.Database();	
	conn = db.getConnection();
	String ip = db.getServerIp();
		st=conn.createStatement();
		String qry = "SELECT SER_NO,VISIT_DEPT,WORKSITE,NAME,FATHER_NAME,DESIGNATION,AGE,LOCAL_ADDRESS,PERMANENT_ADDRESS,NATIONALITY,TO_CHAR(VALIDITY_PERIOD_FROM,'DD-MON-YYYY'),TO_CHAR(VALIDITY_PERIOD_TO,'DD-MON-YYYY'),PHOTO_IMAGE,to_char(sysdate,'MM-MON-YYYY') FROM GATEPASS_FOREIGNER where SER_NO='"+srNo+"'";
		ResultSet rs = st.executeQuery(qry); // Executing the Query
		while(rs.next()){
    		System.out.println("Select all data from Qry--"+qry);
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Untitled Page</title>
<meta name="GENERATOR" content="Created by BlueVoda Website builder http://www.bluevoda.com">
<meta name="HOSTING" content="Hosting Provided By VodaHost http://www.vodahost.com">
<style type="text/css">
div#container
{
   width: 800px;
   height: 600px;
   margin-top: 0px;
   margin-left: 0px;
   text-align: left;
}
<style type="text/css" media="print">
        @page 
        {
            size: auto;   /* auto is the initial value */
            margin: 0mm;  /* this affects the margin in the printer settings */
        }
</style>
<style type="text/css">
body
{
   background-color: #FFFFFF;
   color: #000000;
}
</style>


<style type="text/css">
a:hover
{
   color: #C988A3;
}
</style>
<!--[if lt IE 7]>
<style type="text/css">
   img { behavior: url("pngfix.htc"); }
</style>
<![endif]-->
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="320" height="450">
  <tr>
    <td width="100%" height="30" colspan="10">
    <p align="center">FOREIGNER GATE PASS</td>
  </tr>
  <tr>
    <td width="70%" height="19" colspan="7"><font size="2">Foreigner Gate Pass Ser No. -</font> </td>
    <td width="30%" height="19" colspan="3"><font  size="4">&nbsp;&nbsp;&nbsp;<%=rs.getString(1) %></font> </td>
  </tr>
  <tr>
    <td width="40%" height="19" colspan="4"><font size="3"><font  size="2">Visiting Dept:</font></td>
    <td width="60%" height="19" colspan="6"><font  size="1"><%=rs.getString(2) %></font> </td>
  </tr>
  <tr>
    <td width="100%" height="19" colspan="10" align="center"><font  size="2" >(Work Site: NFL, Panipat)</font></td>
  </tr>
  <tr>
    <td width="20%" height="19" colspan="2"><font size="2">1. Name : </font></td>
    <td width="80%" height="19" colspan="8"><font size="1"><%=rs.getString(4) %></font> </td>
  </tr>
  <tr>
    <td width="30%" height="16" colspan="3"><font size="2">2. Father's Name : </font></td>
    <td width="30%" height="16" colspan="3"><font size="1"><%=rs.getString(5) %></font></td>
    <td width="40%" height="90" colspan="4" rowspan="5" align="center"><img src="ShowImage.jsp?srNo=<%=rs.getString(1) %>" id="Image5" align="middle" border="0" style="width:100px;height:85px;"></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3"><font size="1"><font size="2"><font size="2">3.Designation : </font></font></font></td>
    <td width="30%" height="19" colspan="3"><font size="1"><%=rs.getString(6) %></font></td>
  </tr>
  <tr>
    <td width="20%" height="19" colspan="2"><font size="2">4. Age : </font></td>
    <td width="40%" height="19" colspan="4"><font size="1"><%=rs.getString(7) %></font></td>
  </tr>

  <tr>
    <td width="30%" height="18" colspan="3"><font size="2"> Address : </font></td>
    
  </tr>

  <tr>
    <td width="30%" height="19" colspan="3"><font size="2">6. Local : </font></td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(8) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3"><font size="2">7. Permanent : </font></td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(9) %></font></td>
  </tr>

    <tr>
    <td width="30%" height="19" colspan="3"><font size="2">8. Nationality :</font></td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(10) %></font></td>
  </tr>
  
  <tr>
    <td width="30%" height="19" colspan="3"><font size="2">9. Date of Issue : </font></td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(14) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3"><font size="2">10. Valid Up To : </font></td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(11) %> - </font>  <font size="1"><%=rs.getString(12) %></font></td>
  </tr>
 
   <tr>
    <td width="100%" height="10" colspan="10">
   </td>
  </tr>
  
  
    <tr>
    <td width="50%" height="19" colspan="5"><font size="1">Sign Of the Card Holder</font></td>
    <td width="50%" height="19" colspan="5"><font size="1">Sign Of Issuing Authority with Stamp</font></td>
  </tr>
  <tr>
    <td width="100%" height="19" colspan="10" align="center"><font  size="3" >INSTURCTION</font></td>
  </tr>
  <tr>
<td width="100%" height="19" colspan="10" align="left"><font  size="1" >1. This card may be produced before the security staff as and when when demanded.</font></td>
  <tr>
<td width="100%" height="19" colspan="10" align="left"><font  size="1" >2. This card is not transferable.</font></td>
   </tr>
     <tr>  
<td width="100%" height="19" colspan="10" align="left"><font  size="1" >3. Loss of card may please be reported immediately to the issuing authority.</font></td>
    </tr>
      <tr> 
 <td width="100%" height="19" colspan="10" align="left"><font  size="1" >4. The card holder is not  guaranteed employment by the contractor. This only permits him to enter factory premises, as and when 
 required by the contractor. </font></td>
   
  </tr>
  <tr>
    <td width="100%" height="10" colspan="10">&nbsp;</td>
  </tr>

</table>


</body>
<% 
                } rs.close();conn.close();
%>
</html>
