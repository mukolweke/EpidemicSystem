<%-- 
    Document   : ViewCharts
    Created on : Jun 6, 2017, 12:42:21 AM
    Author     : Michael Mukolwe
--%>
<%@page import="sys.classes.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>FEWS ADMIN &CenterDot; DASHBOARD</title>


        <!-- Bootstrap Core CSS -->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../../assets/css/plugins/sb-admin.css" rel="stylesheet">
        <link href="../../assets/css/plugins/morris.css" rel="stylesheet">
        <link href="../../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <!--javascript mapwork-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete" async defer></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    </head>

    <body>
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
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../../index.jsp"><span><img src="../../assets/img/favicon.png" style="height: 40px;width: 50px;"></span>FARMERS &CenterDot; EPIDEMIC &CenterDot; SYSTEM </a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>  <%= user.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li class="divider"></li>
                            <li>
                                <a href="Logout"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li >
                            <a href="AdminDash.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" style="color:#5cb85c;" data-target="#experts"><i class="fa fa-fw fa-users"></i> Experts <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="experts" class="collapse">
                                <li>
                                    <a href="AddExpert.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-plus"></i>  Add Experts</a>
                                </li>
                                <li>
                                    <a href="ViewExpert.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-table"></i>  View Experts</a>
                                </li>
                            </ul>
                        </li>
                        <li class="active">
                            <a href="ViewFarmer.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-users"></i>  Farmers</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" style="color:#5cb85c;" data-target="#mapping"><i class="fa fa-fw fa-map-marker"></i>  Mapping <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="mapping" class="collapse">
                                <li>
                                    <a href="ViewTables.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-table"></i>  Tables</a>
                                </li>
                                <li>
                                    <a href="ViewCharts.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-bar-chart-o"></i>  Charts</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <div style="margin-top: 280px;padding-left: 10px;"><p><a href="#">Copyright &copy; 2017</a></p>
                                <p style="color: #3c3c3c;">Terms of Services Applied</p></div>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper" style="min-height: 700px;">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="page-header">
                                <small> <i class="fa fa-bar-chart-o"></i> View System Charts</small>
                            </h1>
                            <!-- Page Heading -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="AdminDash.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-bar-chart-o"></i> View Charts
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->


                    <div class="row" style="height: 430px;">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div style="margin-top:20px;width: 100%;height: 400px;">
                                    <div id="map" style="height: 100%;width: 100%;"></div>
                                </div>
                                <div class="panel-heading">
                                    <h3 class="panel-title"> View Charts Panel</h3>
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
                <!-- /.container-fluid -->
            </div>
            <!-- /#page-wrapper -->
        </div>
        <!-- /#wrapper -->
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
        <!--javascript files-->
        <script src="../../assets/js/jquery.js"></script>
        <script src="../../assets/js/bootstrap.min.js"></script>
    </body>

</html>
