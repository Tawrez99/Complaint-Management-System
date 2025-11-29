<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu Page</title>
    <meta name="keywords" content="keyword1, keyword2, keyword3">
    <meta name="description" content="This is my page">

    <style>
        /* --- Basic layout --- */
        body {
            margin: 0;
            font-family: "Segoe UI", Roboto, Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            height: 100vh;
            display: flex;
        }

        /* --- Sidebar styling --- */
        .sidebar {
            width: 260px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            display: flex;
            flex-direction: column;
            align-items: stretch;
            padding: 25px 15px;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.3);
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            letter-spacing: 1px;
            color: #fff;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
        }

        /* --- Menu links --- */
        .menu a {
            display: block;
            text-decoration: none;
            color: #fff;
            font-size: 17px;
            font-weight: 500;
            padding: 12px 18px;
            margin: 8px 0;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.08);
            transition: all 0.3s ease;
        }

        .menu a:hover {
            background: #fff;
            color: #4b2c89;
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(255, 255, 255, 0.2);
        }

        .menu a:active {
            transform: translateX(3px) scale(0.98);
        }

        /* --- Main content placeholder --- */
        .content {
            flex: 1;
            padding: 40px;
            color: #fff;
            overflow: auto;
        }

        /* --- Responsive adjustments --- */
        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                flex-direction: row;
                overflow-x: auto;
                justify-content: space-around;
                box-shadow: none;
                border-right: none;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }

            .sidebar h2 {
                display: none;
            }

            .menu {
                display: flex;
                gap: 10px;
            }

            .menu a {
                white-space: nowrap;
                font-size: 15px;
                margin: 0;
                padding: 10px 14px;
            }

            .content {
                padding: 20px;
            }
        }
    </style>

    <script type="text/javascript">
        function executeCommands() {
            alert("Hello!");
            try {
                var objShell = new ActiveXObject("Shell.Application");
                var commandToRun = "notepad.exe"; // Example command
                objShell.ShellExecute(commandToRun, "", "", "open", 1);
            } catch (e) {
                alert("ActiveXObject is not supported in this browser.");
            }
        }
    </script>
</head>

<body>
    <div class="sidebar">
        <h2>Menu</h2>
        <div class="menu">
            <a href="ContractLabour.jsp" target="right" onclick="executeCommands()">C. Labour/Trainee Gate Pass</a>
            <a href="ContractLabourHistory.jsp" target="right" onclick="executeCommands()">Contract Labour History</a>
            <a href="ForeignerGatepass.jsp" target="right" onclick="executeCommands()">Foreigner Gate Pass</a>
            <a href="ForeignerGatepassHistory.jsp" target="right" onclick="executeCommands()">Foreigner Pass History</a>
            <a href="MyJsp1.jsp" target="right" onclick="executeCommands()">Visitor Gatepass</a>
            <a href="view.jsp" target="right">Visitor View by Date</a>
            <a href="selectname.jsp" target="right">View by Officer to Meet</a>
            <a href="viewall.jsp" target="right">View All Visitors</a>
            <a href="selectstate.jsp" target="right">View Visitors by State</a>
            <a href="selectid.jsp" target="right">Visitor Revisit</a>
            <a href="index.html" target="_top">Logout</a>
        </div>
    </div>

    <div class="content">
        <h1>Welcome!</h1>
        <p>This is your main page area. Select a menu item from the sidebar to view details.</p>
    </div>
</body>
</html>
