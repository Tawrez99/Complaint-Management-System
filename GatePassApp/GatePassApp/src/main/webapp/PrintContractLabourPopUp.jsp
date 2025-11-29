<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*, gatepass.Database.*" %>

<html>
<head>
<title>Print Contract Labour Gate Pass</title>

<!-- 🌈 Modern Styling -->
<style>
body {
  font-family: "Segoe UI", Arial, sans-serif;
  background: #f0f4ff;
  margin: 0;
  padding: 20px;
}

.container {
  background: #fff;
  width: 450px;
  margin: auto;
  padding: 25px 30px;
  border-radius: 15px;
  box-shadow: 0px 4px 15px rgba(0,0,0,0.2);
  border: 1px solid #ddd;
}

.header {
  text-align: center;
  color: #003366;
  border-bottom: 2px solid #0078d4;
  padding-bottom: 10px;
  margin-bottom: 20px;
}

.header h2 {
  margin: 0;
  font-size: 20px;
}

.info-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 10px;
}

.info-table td {
  padding: 8px 5px;
  vertical-align: top;
}

.info-table td.label {
  font-weight: bold;
  color: #333;
  width: 40%;
}

.photo-box {
  text-align: center;
  margin-top: 10px;
}

.photo-box img {
  width: 120px;
  height: 150px;
  border: 2px solid #0078d4;
  border-radius: 8px;
  object-fit: cover;
}

.print-btn {
  display: block;
  margin: 20px auto;
  background-color: #0078d4;
  color: white;
  border: none;
  padding: 8px 18px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: 0.3s;
}

.print-btn:hover {
  background-color: #005fa3;
  transform: translateY(-2px);
}

footer {
  text-align: center;
  font-size: 11px;
  color: #555;
  margin-top: 10px;
}

@media print {
  .print-btn { display: none; }
  body { background: white; }
  .container {
    box-shadow: none;
    border: none;
    width: 100%;
  }
}
</style>
</head>

<body onload="window.print()">
<%
  String srNo = request.getParameter("srNo");
  Connection conn = null;
  Statement st = null;
  ResultSet rs = null;
  String name = "", fatherName = "", desig = "", age = "", localAddr = "", permAddr = "",
         contractor = "", vehicle = "", identification = "", fromDate = "", toDate = "", issueDate = "";
  byte[] photoBytes = null;

  try {
    gatepass.Database db = new gatepass.Database();
    conn = db.getConnection();
    st = conn.createStatement();

    String query = "SELECT SER_NO, NAME, FATHER_NAME, DESIGNATION, AGE, LOCAL_ADDRESS, PERMANENT_ADDRESS, " +
                   "CONTRACTOR_NAME_ADDRESS, VEHICLE_NO, IDENTIFICATION, TO_CHAR(UPDATE_DATE, 'DD-MON-YYYY'), " +
                   "VALIDITY_FROM, VALIDITY_TO, PHOTO " +
                   "FROM GATEPASS_CONTRACT_LABOUR WHERE SER_NO=" + srNo;

    rs = st.executeQuery(query);
    if (rs.next()) {
      name = rs.getString("NAME");
      fatherName = rs.getString("FATHER_NAME");
      desig = rs.getString("DESIGNATION");
      age = rs.getString("AGE");
      localAddr = rs.getString("LOCAL_ADDRESS");
      permAddr = rs.getString("PERMANENT_ADDRESS");
      contractor = rs.getString("CONTRACTOR_NAME_ADDRESS");
      vehicle = rs.getString("VEHICLE_NO");
      identification = rs.getString("IDENTIFICATION");
      issueDate = rs.getString(11);
      fromDate = rs.getString("VALIDITY_FROM");
      toDate = rs.getString("VALIDITY_TO");
      photoBytes = rs.getBytes("PHOTO");
    }
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    try { if (rs != null) rs.close(); } catch(Exception e) {}
    try { if (st != null) st.close(); } catch(Exception e) {}
    try { if (conn != null) conn.close(); } catch(Exception e) {}
  }

  String base64Image = "";
  if (photoBytes != null) {
    base64Image = Base64.getEncoder().encodeToString(photoBytes);
  }
%>

<div class="container">
  <div class="header">
    <h2>CONTRACT LABOUR GATE PASS</h2>
    <p><b>SR No:</b> <%= srNo %></p>
  </div>

  <table class="info-table">
    <tr><td class="label">Name:</td><td><%= name %></td></tr>
    <tr><td class="label">Father’s Name:</td><td><%= fatherName %></td></tr>
    <tr><td class="label">Designation:</td><td><%= desig %></td></tr>
    <tr><td class="label">Age:</td><td><%= age %></td></tr>
    <tr><td class="label">Local Address:</td><td><%= localAddr %></td></tr>
    <tr><td class="label">Permanent Address:</td><td><%= permAddr %></td></tr>
    <tr><td class="label">Contractor:</td><td><%= contractor %></td></tr>
    <tr><td class="label">Vehicle No.:</td><td><%= vehicle %></td></tr>
    <tr><td class="label">Identification:</td><td><%= identification %></td></tr>
    <tr><td class="label">Validity:</td><td><%= fromDate %> to <%= toDate %></td></tr>
    <tr><td class="label">Issue Date:</td><td><%= issueDate %></td></tr>
  </table>

  <div class="photo-box">
    <% if (photoBytes != null && base64Image.length() > 0) { %>
      <img src="data:image/png;base64,<%= base64Image %>" alt="Captured Photo"/>
    <% } else { %>
      <div style="border:1px solid #ccc; width:120px; height:150px; margin:auto; 
                  display:flex; align-items:center; justify-content:center; color:#777;">
        No Photo
      </div>
    <% } %>
  </div>

  <button class="print-btn" onclick="window.print()">🖨️ Print</button>

  <footer>
    © <%= java.time.Year.now() %> Gate Pass Management System | NFL Panipat
  </footer>
</div>
</body>
</html>
