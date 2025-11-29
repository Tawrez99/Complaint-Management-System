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
		String qry = "SELECT SER_NO,REF_NO,RENEWAL_NO,NAME,FATHER_NAME,DESIGNATION,AGE,LOCAL_ADDRESS,PERMANENT_ADDRESS,CONTRACTOR_NAME_ADDRESS,WORKSITE,VEHICLE_NO,IDENTIFICATION,TO_CHAR(VALIDITY_PERIOD_FROM,'DD-MON-YYYY'),TO_CHAR(VALIDITY_PERIOD_TO,'DD-MON-YYYY'),PHOTO_IMAGE,to_char(sysdate,'MM-MON-YYYY') FROM GATEPASS_CONTRACT_LABOUR where SER_NO='"+srNo+"'";
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

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="320" height="430">
  <tr>
    <td width="100%" height="63" colspan="10">
    <p align="center">&nbsp;</td>
  </tr>
  <tr>
    <td width="70%" height="19" colspan="7">&nbsp;</td>
    <td width="30%" height="19" colspan="3"><font  size="2"><%=rs.getString(1) %></font> </td>
  </tr>
  <tr>
    <td width="40%" height="19" colspan="4">&nbsp;</td>
    <td width="60%" height="19" colspan="6"><font  size="1"><%=rs.getString(10) %></font> </td>
  </tr>
  <tr>
    <td width="100%" height="19" colspan="10">&nbsp;</td>
  </tr>
  <tr>
    <td width="20%" height="19" colspan="2">&nbsp;</td>
    <td width="80%" height="19" colspan="8"><font size="1"><%=rs.getString(4) %></font> </td>
  </tr>
  <tr>
    <td width="30%" height="16" colspan="3"></td>
    <td width="30%" height="16" colspan="3"><font size="1"><%=rs.getString(5) %></font></td>
    <td width="40%" height="90" colspan="4" rowspan="5"><img src="ShowImage.jsp?srNo=<%=rs.getString(1) %>" id="Image5" align="LEFT" border="0" style="width:96px;height:78px;"></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3">&nbsp;</td>
    <td width="30%" height="19" colspan="3"><font size="1"><%=rs.getString(6) %></font></td>
  </tr>
  <tr>
    <td width="20%" height="19" colspan="2">&nbsp;</td>
    <td width="40%" height="19" colspan="4"><font size="1"><%=rs.getString(7) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="18" colspan="3"></td>
    <td width="30%" height="18" colspan="3"><font size="1"><%=rs.getString(13) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="18" colspan="3"></td>
    <td width="30%" height="18" colspan="3"><font size="1"><%=rs.getString(8) %></font></td>
  </tr>

  <tr>
    <td width="30%" height="19" colspan="3">&nbsp;</td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(9) %></font></td>
  </tr>
  <tr>
    <td width="100%" height="19" colspan="10"><font size="1"><%=rs.getString(9) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3">&nbsp;</td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(17) %></font></td>
  </tr>
  <tr>
    <td width="30%" height="19" colspan="3">&nbsp;</td>
    <td width="70%" height="19" colspan="7"><font size="1"><%=rs.getString(14) %> - </font>  <font size="1"><%=rs.getString(15) %></font></td>
  </tr>
  <tr>
    <td width="70%" height="19" colspan="7">&nbsp;</td>
    <td width="30%" height="19" colspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td width="40%" height="19" colspan="4">&nbsp;</td>
    <td width="60%" height="19" colspan="6">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="19" colspan="10">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
    <td width="10%" height="1"></td>
  </tr>
  <tr>
    <td width="100%" height="87" colspan="10">&nbsp;</td>
  </tr>

</table>


</body>
<% } rs.close();conn.close();
%>
</html>