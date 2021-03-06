<%-- 
    Document   : ViewExpert
    Created on : Jun 6, 2017, 12:41:08 AM
    Author     : Michael Mukolwe
--%>

<%@page import="sys.classes.*" %>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>FEWS &CenterDot;View Experts</title>
        <!-- Bootstrap Core CSS -->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../../assets/css/plugins/sb-admin.css" rel="stylesheet">
        <link href="../../assets/css/plugins/morris.css" rel="stylesheet">
        <link href="../../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">

        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <!--        <script type="text/javascript">
                    function initAutocomplete() {
                        var autocomplete = new google.maps.places.Autocomplete(document.getElementById('user-location'));
                        google.maps.event.addListener(autocomplete, 'place_changed', function () {
                            var place = autocomplete.getPlace();
                            document.getElementById("lat").value = place.geometry.location.lat();
                            document.getElementById("lng").value = place.geometry.location.lng();
        
                        });
                    }
                    ;
                </script>-->
    </head>
    <body>
        <%

            //create database object
            DB_class DB = new DB_class();

//            int countNotification = DB.countNotifications(user_name);
            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            if (request.getParameter("upd") != null) {
                DB.deactivateAccount(request.getParameter("upd"));
            }
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }

            //get the error / success msg
            Error_class user_error = (Error_class) request.getAttribute("addUserErr");
            if (user_error == null) {
                user_error = new Error_class();
            }
            Success_class user_sucess = (Success_class) request.getAttribute("addSuccess");
            if (user_sucess == null) {
                user_sucess = new Success_class();
            }

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqExpert">
            <%= DB.getExpert()%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqCoordsE">
            <%= DB.coordsE()%>
        </sql:query>
        <script type="text/javascript">
            function initAutocomplete() {
//                expert location details
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
                    mapTypeId: 'roadmap'
                });

                var contentString = "Hi You!!!";
                var infowindow = new google.maps.InfoWindow({
                    content: contentString
                });
                var i;
                //expert
                for (i = 0; i < locationExpert.length; i++) {
                    marker2 = new google.maps.Marker({
                        position: new google.maps.LatLng(locationExpert[i][1], locationExpert[i][2]),
                        label: "E",
                        draggable: true,
                        map: map
                    });
                    google.maps.event.addListener(marker2, 'click', (function (marker2, i) {
                        return function () {
                            infowindow.setContent(locationExpert[i][0] + ", Expert");
                            infowindow.open(map, marker);
                        };
                    })(marker2, i));
                }
                marker2.addListener('click', function () {
                    infowindow.open(map, marker2);
                });
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
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
                        <li class="active">
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
                        <li>
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
                                <small> <i class="fa fa-list"></i> View Experts</small>
                            </h1>
                            <!-- Page Heading -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="AdminDash.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-user-md"></i> View Experts
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->


                    <div class="row" style="height: 430px;">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"> View Expert Table
                                        <span class="pull-right">
                                            <form action="ReportServlet">
                                                <input type="text" name="type" class="hidden" value="Experts"/>
                                                <input type="submit" class="btn-success" value="Generate Experts report">
                                            </form>
                                        </span>
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div style="margin-top:20px;width: 100%;height: 300px;">
                                        <div id="map" style="height: 100%;width: 100%;"></div>
                                    </div>
                                    <hr/>
                                    <table style="margin-top: 50px;"class="table table-condensed table-hover">
                                        <tr >
                                            <th>#</th>
                                            <th>FULL NAME</th>
                                            <th>EMAIL</th>
                                            <th>PHONE #</th>
                                            <th>EXPERTISE</th>
                                            <th>LOCATION</th>
                                            <th>ACTION</th>
                                        </tr>
                                        <c:forEach var="expert" items="${reqExpert.rows}">
                                            <tr>
                                                <td>${expert.expert_id}</td>
                                                <td>${expert.name}</td>
                                                <td>${expert.email}</td>		
                                                <td>${expert.phone}</td>
                                                <td>${expert.field}</td>
                                                <td>${expert.addr}</td>
                                                <td>
                                                    <ul class="" style="list-style-type:none">
                                                        <li style="display:inline;"><a class="btn btn-default" href="../ViewProfile.jsp?prf_em=${expert.email}&prf_id=0">View</a></li>
                                                        <li style="display:inline;"><a class="btn btn-danger" href="ViewExpert.jsp?upd=${expert.email}">Delete</a></li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
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
        <script src="https://maps.googleapis.com/maps/api/js?key= AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <script type="text/javascript">
            $(function () {
                $('#myTab a:first').tab('show');
            });

            function deactivate(){
                db.deactivateAccount(userEmail);
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
        <!--javascript files-->
        <script src="../../assets/js/jquery.js"></script>
        <script src="../../assets/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>

        <script src="../../assets/js/plugins/morris/raphael.min.js"></script>
        <script src="../../assets/js/plugins/morris/morris.min.js"></script>
        <script src="../../assets/js/plugins/morris/morris-data.js"></script>

    </body>

</html>
