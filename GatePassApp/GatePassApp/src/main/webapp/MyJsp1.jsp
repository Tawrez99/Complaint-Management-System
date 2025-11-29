<%@ page language="java" import="java.sql.*,java.io.*,java.util.Base64" %>
<%@ page import="gatepass.Database.*" %>

<html>
<head>
<title>Gate Pass Entry Details</title>

<style>
body {
    background-color: #f4f6f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

#gatepass {
    background-color: #ffffff;
    max-width: 700px;
    margin: 50px auto;
    padding: 40px 50px;
    border-radius: 12px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
}

h3 {
    text-align: center;
    color: #333;
    margin-bottom: 40px;
    font-size: 24px;
    font-weight: 600;
}

.form-row {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 20px;
}

.form-group {
    flex: 1;
    min-width: 200px;
    padding: 0 10px;
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    color: #555;
}

input[type="text"], textarea, select {
    width: 100%;
    padding: 10px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    transition: border 0.3s, box-shadow 0.3s;
}

input[type="text"]:focus, textarea:focus, select:focus {
    border-color: #007BFF;
    box-shadow: 0 0 5px rgba(0,123,255,0.3);
    outline: none;
}

textarea {
    resize: vertical;
}

button {
    padding: 12px 30px;
    font-size: 15px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s, transform 0.2s;
}

button[type="submit"] {
    background-color: #007BFF;
    color: white;
    margin-right: 15px;
}

button[type="submit"]:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

button[type="reset"] {
    background-color: #6c757d;
    color: white;
}

button[type="reset"]:hover {
    background-color: #5a6268;
    transform: scale(1.05);
}

#webcam-container {
    text-align: center;
    margin-bottom: 20px;
}

#video {
    border-radius: 8px;
    border: 1px solid #ccc;
    width: 320px;
    height: 240px;
    margin-bottom: 10px;
}

#snapshot {
    width: 320px;
    height: 240px;
    border-radius: 8px;
    border: 1px solid #ccc;
}

@media (max-width: 600px) {
    .form-row {
        flex-direction: column;
    }
    .form-group {
        padding: 0;
    }
}
</style>

<script type="text/javascript">
// Form validation
function Blank_TextField_Validator() {
    var form = document.forms["text_form"];
    if (form.text_name.value == "") { alert("Please fill the NAME"); form.text_name.focus(); return false; }
    if (form.line1.value == "") { alert("Please fill the address"); form.line1.focus(); return false; }
    if (form.vehicle.value == "") { alert("Please fill the vehicle number"); form.vehicle.focus(); return false; }
    if (form.district.value == "") { alert("Please fill the district"); form.district.focus(); return false; }
    if (form.state.value == "") { alert("Please fill the state"); form.state.focus(); return false; }
    if (form.material.value == "") { alert("Please fill the material"); form.material.focus(); return false; }
    if (form.purpose.value == "") { alert("Please fill the purpose"); form.purpose.focus(); return false; }
    return true;
}

// Webcam functionality using WebRTC
let videoStream;

function startWebcam() {
    const video = document.getElementById('video');
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
        .then(function(stream) {
            videoStream = stream;
            video.srcObject = stream;
            video.play();
        })
        .catch(function(err) {
            alert("Error accessing webcam: " + err);
        });
    } else {
        alert("Webcam not supported in this browser.");
    }
}

function takeSnapshot() {
    const video = document.getElementById('video');
    const canvas = document.createElement('canvas');
    canvas.width = 320;
    canvas.height = 240;
    const context = canvas.getContext('2d');
    context.drawImage(video, 0, 0, canvas.width, canvas.height);

    // Show snapshot
    const snapshotImg = document.getElementById('snapshot');
    snapshotImg.src = canvas.toDataURL('image/png');

    // Store snapshot in hidden field
    document.getElementById('webcam_image').value = canvas.toDataURL('image/png');
}

// Stop webcam when leaving page
window.addEventListener('beforeunload', function() {
    if(videoStream) {
        videoStream.getTracks().forEach(track => track.stop());
    }
});
</script>

<%
gatepass.Database db = new gatepass.Database();
String ip = db.getServerIp();

// Handle form submission
if("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("text_name");
    String address = request.getParameter("line1");
    String vehicle = request.getParameter("vehicle");
    String district = request.getParameter("district");
    String state = request.getParameter("state");
    String pincode = request.getParameter("pincode");
    String telephone = request.getParameter("number");
    String material = request.getParameter("material");
    String officer = request.getParameter("officertomeet");
    String purpose = request.getParameter("purpose");

    // Save webcam image
    String imageData = request.getParameter("webcam_image");
    String savedImageFile = null;
    if (imageData != null && imageData.startsWith("data:image/png;base64,")) {
        imageData = imageData.replace("data:image/png;base64,", "");
        byte[] imageBytes = Base64.getDecoder().decode(imageData);

        String imagePath = application.getRealPath("/captured_images/");
        File dir = new File(imagePath);
        if (!dir.exists()) dir.mkdirs();

        savedImageFile = "visitor_" + System.currentTimeMillis() + ".png";
        FileOutputStream fos = new FileOutputStream(new File(dir, savedImageFile));
        fos.write(imageBytes);
        fos.close();
    }

    // Save form data to database (example)
    try {
        Connection conn = db.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO gatepass_entries(name,address,vehicle,district,state,pincode,telephone,material,officer,purpose,image_file) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, vehicle);
        ps.setString(4, district);
        ps.setString(5, state);
        ps.setString(6, pincode);
        ps.setString(7, telephone);
        ps.setString(8, material);
        ps.setString(9, officer);
        ps.setString(10, purpose);
        ps.setString(11, savedImageFile);
        ps.executeUpdate();
        ps.close();
        conn.close();
        out.println("<p style='color:green;text-align:center;'>Gate Pass Entry Saved Successfully!</p>");
    } catch(Exception e) {
        out.println("<p style='color:red;text-align:center;'>Error saving data: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
}
%>

</head>
<body onload="startWebcam();">

<div id="gatepass">

    <h3>Gate Pass Details</h3>

    <!-- Webcam -->
    <div id="webcam-container">
        <video id="video" autoplay></video><br>
        <button type="button" onclick="takeSnapshot()">Capture Photo</button><br>
        <img id="snapshot" alt="Captured Image">
    </div>

    <form method="post" name="text_form" enctype="multipart/form-data" onsubmit="return Blank_TextField_Validator()">
        <input type="hidden" name="webcam_image" id="webcam_image">

        <div class="form-row">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="text_name">
            </div>
            <div class="form-group">
                <label>Vehicle Number</label>
                <input type="text" name="vehicle">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>District</label>
                <input type="text" name="district">
            </div>
            <div class="form-group">
                <label>State</label>
                <select name="state">
                    <option value="">Select State</option>
                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                    <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                    <option value="Assam">Assam</option>
                    <option value="Bihar">Bihar</option>
                    <option value="Chhatisgarh">Chhatisgarh</option>
                    <option value="Goa">Goa</option>
                    <option value="Gujarat">Gujarat</option>
                    <option value="Haryana">Haryana</option>
                    <option value="Himachal Pradesh">Himachal Pradesh</option>
                    <option value="Jammu & Kashmir">Jammu & Kashmir</option>
                    <option value="Jharkhand">Jharkhand</option>
                    <option value="Karnataka">Karnataka</option>
                    <option value="Kerala">Kerala</option>
                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                    <option value="Maharashtra">Maharashtra</option>
                    <option value="Manipur">Manipur</option>
                    <option value="Meghalaya">Meghalaya</option>
                    <option value="Mizoram">Mizoram</option>
                    <option value="Nagaland">Nagaland</option>
                    <option value="Odisha">Odisha</option>
                    <option value="Punjab">Punjab</option>
                    <option value="Rajasthan">Rajasthan</option>
                    <option value="Sikkim">Sikkim</option>
                    <option value="Tamil Nadu">Tamil Nadu</option>
                    <option value="Telangana">Telangana</option>
                    <option value="Tripura">Tripura</option>
                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                    <option value="Uttarakhand">Uttarakhand</option>
                    <option value="West Bengal">West Bengal</option>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Pincode</label>
                <input type="text" name="pincode">
            </div>
            <div class="form-group">
                <label>Telephone</label>
                <input type="text" name="number">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Material</label>
                <input type="text" name="material">
            </div>
            <div class="form-group">
                <label>Officer to Meet</label>
                <input type="text" name="officertomeet">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group" style="flex: 1;">
                <label>Purpose</label>
                <textarea name="purpose" rows="3"></textarea>
            </div>
        </div>

        <div style="text-align:center;">
            <button type="submit">Save</button>
            <button type="reset">Reset</button>
        </div>
    </form>
</div>

</body>
</html>
