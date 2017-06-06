<%-- 
    Document   : farmer-page
    Created on : Mar 31, 2017, 1:57:31 PM
    Author     : Michael Mukolwe
--%>

<%@page import="sys.classes.*" %>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body style="background-color: #f9f9f9;">
        <%

            //create database object
            DB_class DB = new DB_class();
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
            if (request.getParameter("upd") != null) {
                DB.deactivateAccount(request.getParameter("upd"));
            }//            int countNotification = DB.countNotifications(user_name);
            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            //get map coordinates
            double lat = DB.getLat("onchieng@gmail.com", "farmer");
            double lng = DB.getLng("onchieng@gmail.com", "farmer");
            String addr = DB.getAddr("onchieng@gmail.com", "farmer");


        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqFarmer">
            <%= DB.getFarmer()%>
        </sql:query>

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
                        <li class="active" ><a href="FarmerPage.jsp"  class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">System Farmers</a></li>
                        <li><a href="Mapping.jsp">System Mapping</a></li>
                    </ul>
                </div>
            </div>
            <!--end navbar TWO-->
        </header>

        <!--middle section-->
        <div class="tab-content"style="background-color: #f9f9f9;font-family:'Oxygen-Regular';height: 450px;">
            <div class="tab-pane fade in active" id="main-page">
                <div class="container" style="margin:20px auto;width: 800px;">
                    <div class="panel-heading"style="background-color: transparent;">
                        <h3 class="panel-title" style="font-size: 20px;">FEWS Farmers Details</h3>
                    </div>
                    <div class="panel panel-expert">
                        <div class="panel-body">
                            <div id="map-canvas" style="height: 200px;">
                                <div id="map" style="width: 100%;height: 100%;"></div>
                            </div>
                            <hr/>
                            <table style="margin-top: 50px;"class="table table-condensed table-hover">
                                <tr >
                                    <th>#</th>
                                    <th>FULL NAME</th>
                                    <th>EMAIL</th>
                                    <th>PHONE #</th>
                                    <th>LOCATION</th>
                                    <th>ACTION</th>
                                </tr>
                                <c:forEach var="expert" items="${reqFarmer.rows}">
                                    <tr>
                                        <td>${expert.farmer_id}</td>
                                        <td>${expert.name}</td>
                                        <td>${expert.email}</td>		
                                        <td>${expert.phone}</td>
                                        <td>${expert.ip_address}</td>
                                        <td>
                                            <ul class="" style="list-style-type:none">
                                                <li style="display:inline;"><a class="btn btn-default" href="profile.jsp?prf=${expert.email}">View</a></li>
                                                <li style="display:inline;"><a class="btn btn-danger" href="FarmerPage.jsp.jsp?upd=${expert.email}">Delete</a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                            <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-sm">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                            ...
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /.container -->
                    </div>
                </div>
            </div>
        </div>
        <!--end middle section-->

        <!-- Footer -->
        <footer class="hidden">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>

        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://maps.googleapis.com/maps/api/js?key= AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <script type="text/javascript">
            function initAutocomplete() {
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat:<%=lat%>, lng:<%=lng%>},
                    zoom: 13,
                    mapTypeId: 'roadmap'
                });

                var marker = new google.maps.Marker({
                    position: {
                        lat: <%=lat%>, lng: <%=lng%>
                    },
                    label: "F",
                    map: map
                });
            }

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
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#blah')
                                .attr('src', e.target.result);
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>
