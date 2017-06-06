<%-- 
    Document   : Mapping
    Created on : May 18, 2017, 9:20:05 AM
    Author     : Michael Mukolwe
--%>

<%@page import="sys.classes.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; Expert Page</title>
        <!--css links-->
        <link href="../../assets/css/material.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <style type="text/css">
            img{
                max-width:200px;
                margin-bottom: 5px;
                max-height: 200px;
                min-height: 200px;
                min-width: 200px;
            }
            input[type=file]{
                padding:10px;
            }
            .tablesorter input[type="image"] {
                margin-right: 10px;
            }
        </style>
        <!--javascript mapwork-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete" async defer></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    </head>
    <body style="background-color: #f9f9f9;">
        <%

            //create database object
            DB_class DB = new DB_class();
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
            String user_name = user.getUserEmail();
//            int countNotification = DB.countNotifications(user_name);
            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();


        %>

        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqCoordsF">
            <%= DB.coordsF()%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqCoordsE">
            <%= DB.coordsE()%>
        </sql:query>


        <script type="text/javascript">
            //farmer location details
            function initAutocomplete() {
                var locationFarmer = [
            <c:forEach items="${reqCoordsF.rows}" var="coordsF" varStatus="status">
                    ['${coordsF.addr}',${coordsF.lat},${coordsF.lng}]
                <c:if test="${!status.last}">
                    ,
                </c:if>
            </c:forEach>
                ];
                // expert location details
                var locationExpert = [
            <c:forEach items="${reqCoordsE.rows}" var="coordsE" varStatus="status">
                    ['${coordsE.addr}',${coordsE.lat},${coordsE.lng}]
                <c:if test="${!status.last}">
                    ,
                </c:if>
            </c:forEach>
                ];

                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: -0.3031, lng: 36.08},
                    zoom: 6,
                    mapTypeId: 'satellite'
                });

                var contentString = "Hi You!!!";
                var infowindow = new google.maps.InfoWindow({
                    content: contentString
                });
                var i;
                //farmer
                for (i = 0; i < locationFarmer.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(locationFarmer[i][1], locationFarmer[i][2]),
                        label: "F",
                        draggable: true,
                        map: map
                    });
                    google.maps.event.addListener(marker, 'click', (function (marker, i) {
                        return function () {
                            infowindow.setContent(locationFarmer[i][0] + ", Farmer");
                            infowindow.open(map, marker);
                        };
                    })(marker, i));
                }
                //expert
                for (i = 0; i < locationExpert.length; i++) {
                    marker2 = new google.maps.Marker({
                        position: new google.maps.LatLng(locationExpert[i][1], locationExpert[i][2]),
                        label: "E",
                        draggable: true,
                        map: map
                    });
                    google.maps.event.addListener(marker2, 'click', (function (marker, i) {
                        return function () {
                            infowindow.setContent(locationExpert[i][0] + ", Expert");
                            infowindow.open(map, marker);
                        };
                    })(marker2, i));
                }
                marker.addListener('click', function () {
                    infowindow.open(map, marker);
                });
                marker2.addListener('click', function () {
                    infowindow.open(map, marker2);
                });
            }

            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(drawPieChart);
            google.charts.setOnLoadCallback(drawBarChart);

            function drawPieChart() {

                var populatedData = [
                    ['Data', 'System Data'],
                    ['System Experts', <%=DB.countExperts()%>],
                    ['System Farmers', <%=DB.countFarmer()%>],
                    ['Epidemic Post', <%=DB.countPost()%>],
                    ['Epidemic Blogs', <%=DB.countBlogs()%>]
                ];

                var data = google.visualization.arrayToDataTable(populatedData);


                var options = {
                    title: 'SYSTEM STATS',
                    is3D: true
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(data, options);
            }

            function drawBarChart() {

                var dataPopulated = google.visualization.arrayToDataTable([
                    ["Expert Field", "# Post", {role: "style"}],
                    ["Farming", 8, "#5cb85c"],
                    ["Animals", 10, "#5cb85c"],
                    ["Weather", 19, "#5cb85c"],
                    ["Soil", 21, "#5cb85c"],
                    ["Water", 1, "#5cb85c"]
                ]);

                var view = new google.visualization.DataView(dataPopulated);
                view.setColumns([0, 1,
                    {calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation"},
                    2]);

                var options = {
                    title: "Number of Epidemic Posts per ExpertField",
                    width: 600,
                    height: 400,
                    bar: {groupWidth: "90%"},
                    legend: {position: "none"}
                };
                var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
                chart.draw(view, options);
            }
        </script>
        <header>
            <!--navbar one-->
            <nav class="navbar navbar-primary " style="background-color: #fff;"role="navigation">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="../../index.jsp"><span style="color:#5cb85c;">FEWS</span> LOGO</a>
                    </div>

                    <div class="collapse navbar-collapse" id="">
                        <div class="dropdown navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"></span></a></li>
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span></a></li>

                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user.getUserEmail()%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="AdminDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
            <!--end navbar one-->
            <!--nav two-->
            <div class="nav-two navbar">
                <div class="container">
                    <ul class="nav navbar-nav">
                        <li><a href="AdminDash.jsp" >System Dashboard</a></li>
                        <li><a href="ExpertPage.jsp">System Experts</a></li>
                        <li><a href="FarmerPage.jsp">System Farmers</a></li>
                        <li class="active" ><a href="Mapping.jsp" class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">System Mapping</a></li>
                    </ul>
                </div>
            </div>
            <!--end navbar TWO-->
        </header>

        <!--middle section-->
        <div class=""style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
            <div style="margin-top:20px;width: 100%;height: 400px;">
                <div id="map" style="height: 100%;width: 100%;"></div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="glyphicon glyphicon-signal"></i> Area Chart</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div id="piechart" style="width: 100%; height: 400px;"></div>
                                    </div>
                                    <div class="col-md-6">
                                        <div id="barchart_values" style="width: 100%; height: 400px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
        </div>
        <!--end middle section-->

        <!-- Footer -->
        <footer class="">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>

        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript">

            function notify() {
                if (document.getElementById("not").value !== "0") {
                    document.getElementById("not").style.color = "#FF6666";
                } else if (document.getElementById("not").value === "0") {
                    document.getElementById("not").style.color = "yellow";
                }

                //check if account is confirmed
                if (document.getElementById("acc").value === "0") {
                    document.getElementById("alert_status").style.display = "block";
                } else if (document.getElementById("acc").value === "1") {
                    document.getElementById("alert_status").style.display = "none";
                }
            }

        </script>
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>
