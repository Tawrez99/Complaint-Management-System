<!DOCTYPE HTML>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page language="java" import="gatepass.Database.*" %>

<html>
<head>
<title>Visitor Details by Date</title>

<style>
/* ===== Base Styles ===== */
body {
    background: linear-gradient(135deg, #eef2f3, #8e9eab);
    font-family: "Poppins", sans-serif;
    margin: 0;
    padding: 30px;
    color: #2c3e50;
}

h2 {
    text-align: center;
    color: #2d3436;
    font-weight: 700;
    margin-bottom: 40px;
    letter-spacing: 1px;
    text-transform: uppercase;
    background: linear-gradient(135deg, #2980b9, #6dd5fa);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ===== Filter Box ===== */
.filter-box {
    max-width: 750px;
    margin: 0 auto 40px auto;
    background: #ffffff;
    padding: 25px 35px;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 18px;
    transition: 0.3s ease;
}
.filter-box:hover {
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.filter-box label {
    font-weight: 600;
    color: #34495e;
}

.filter-box input[type="date"] {
    padding: 10px 15px;
    border-radius: 8px;
    border: 1px solid #bbb;
    font-size: 15px;
    transition: all 0.3s ease;
}
.filter-box input[type="date"]:focus {
    border-color: #3498db;
    box-shadow: 0 0 5px rgba(52,152,219,0.3);
    outline: none;
}

.filter-box input[type="submit"] {
    background: linear-gradient(135deg, #3498db, #8e44ad);
    color: #fff;
    padding: 10px 22px;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
}
.filter-box input[type="submit"]:hover {
    background: linear-gradient(135deg, #2980b9, #6a11cb);
    transform: translateY(-2px);
}

/* ===== Table Container ===== */
.table-container {
    max-width: 95%;
    margin: 0 auto;
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    padding: 25px;
    overflow: hidden;
}

.table-wrapper {
    overflow-x: auto;
}

/* ===== Table ===== */
table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
}

th {
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    color: #fff;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 0.5px;
    padding: 12px;
}

td {
    text-align: center;
    padding: 12px 8px;
    border-bottom: 1px solid #eaeaea;
    font-size: 14px;
    color: #2c3e50;
}

tr:nth-child(even) {
    background: #f9f9f9;
}
tr:hover {
    background: #f1f7ff;
    transition: 0.3s ease;
}

/* ===== Visitor Photo ===== */
.visitor-photo img {
    border-radius: 10px;
    border: 2px solid #ddd;
    transition: transform 0.3s, border-color 0.3s;
}
.visitor-photo img:hover {
    transform: scale(1.08);
    border-color: #2575fc;
}

/* ===== Action Buttons ===== */
.action-links a {
    display: inline-block;
    margin: 4px;
    padding: 7px 14px;
    font-size: 12px;
    font-weight: 600;
    text-decoration: none;
    color: #fff;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.action-links a:first-child {
    background: #2980b9;
}
.action-links a:first-child:hover {
    background: #1f6694;
}

.action-links a:last-child {
    background: #27ae60;
}
.action-links a:last-child:hover {
    background: #1e8449;
}

/* ===== Responsive Design ===== */
@media (max-width: 768px) {
    .filter-box {
        flex-direction: column;
        align-items: stretch;
    }
    th, td {
        font-size: 12px;
        padding: 8px;
    }
    .action-links a {
        padding: 6px 10px;
        font-size: 11px;
    }
}
</style>
</head>

<body>
<%
    String fromdate = request.getParameter("datum1");
    String todate = request.getParameter("datum");
%>

<h2>Visitor Details by Date Range</h2>

<div class="filter-box">
    <form method="get">
        <label>From:</label>
        <input type="date" name="datum1" value="<%= fromdate != null ? fromdate : "" %>" required>
        <label>To:</label>
        <input type="date" name="datum" value="<%= todate != null ? todate : "" %>" required>
        <input type="submit" value="Search">
    </form>
</div>

<%
    if (fromdate != null && todate != null) {
        try {
            gatepass.Database db = new gatepass.Database();
            Connection conn = db.getConnection();
            String ip = db.getServerIp();

            String selQry = "select * from visitor where entrydate1 between '" + fromdate + "' and '" + todate + "' order by id desc";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(selQry);
%>

<div class="table-container">
<div class="table-wrapper">
<table>
    <thead>
        <tr>
            <th>Actions</th>
            <th>Visitor ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Contact</th>
            <th>Date</th>
            <th>Time</th>
            <th>Photo</th>
            <th>Officer</th>
            <th>Purpose</th>
            <th>Material</th>
        </tr>
    </thead>
    <tbody>
    <%
        while (rs.next()) {
    %>
        <tr>
            <td class="action-links">
                <a href="PRINTTEST.jsp?id=<%= rs.getString(11) %>" target="_blank">Reprint</a>
                <a href="My.jsp?id=<%= rs.getString(11) %>">Gatepass</a>
            </td>
            <td><%= rs.getString(11) %></td>
            <td><%= rs.getString(1).toUpperCase() %></td>
            <td><%= rs.getString(2) %><br><%= rs.getString(14) %><br><%= rs.getString(13) %><br><%= rs.getString(15) %></td>
            <td><%= rs.getString(16) %></td>
            <td><%= rs.getString(12) %></td>
            <td><%= rs.getString(10) %></td>
            <td class="visitor-photo">
                <a href="http://<%=ip %>/visitor/name?id=<%=rs.getString(11) %>" target="_blank">
                    <img src="http://<%=ip %>/visitor/name?id=<%=rs.getString(11) %>" width="80" height="60">
                </a>
            </td>
            <td><%= rs.getString(5) %></td>
            <td><%= rs.getString(7) %></td>
            <td><%= rs.getString(3) %></td>
        </tr>
    <%
        }
        rs.close();
        conn.close();
    } catch (Exception ex) {
        out.println("<p style='color:red;text-align:center;'>Error loading visitor data: " + ex + "</p>");
    }
    }
%>
    </tbody>
</table>
</div>
</div>

</body>
</html>
