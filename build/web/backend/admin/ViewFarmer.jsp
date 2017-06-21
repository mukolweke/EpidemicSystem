<%-- 
    Document   : ViewFarmer
    Created on : Jun 6, 2017, 12:41:18 AM
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
    </head>

    <body>
        <%

            //create database object
            DB_class DB = new DB_class();
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
            if (request.getParameter("upd") != null) {
                DB.deactivateAccount(request.getParameter("upd"));
            }            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            //get map coordinates
            double lat = DB.getLat("onchieng@gmail.com", "admin");
            double lng = DB.getLng("onchieng@gmail.com", "admin");
            String addr = DB.getAddr("onchieng@gmail.com", "admin");


        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqFarmer">
            <%= DB.getFarmer()%>
        </sql:query>

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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user.getUserEmail()%> <b class="caret"></b></a>
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

            <div id="page-wrapper">
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="page-header">
                                <small> <i class="fa fa-list"></i> View Farmers</small>
                            </h1>
                            <!-- Page Heading -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="AdminDash.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-user-md"></i> View Farmers
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->


                    <div class="row" style="height: 430px;">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">View Farmers Table
                                        <span class="pull-right">
                                            <form action="ReportServlet">
                                                <input type="text" name="file_name" class="hidden" value="Farmers Report"/>
                                                <input type="submit" class="btn-success" value="Generate Farmers report">
                                            </form>
                                        </span>
                                    </h3>
                                </div>
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
                                        <c:forEach var="farmer" items="${reqFarmer.rows}">
                                            <tr>
                                                <td>${farmer.farmer_id}</td>
                                                <td>${farmer.name}</td>
                                                <td>${farmer.email}</td>		
                                                <td>${farmer.phone}</td>
                                                <td>${farmer.addr}</td>
                                                <td>
                                                    <ul class="" style="list-style-type:none">
                                                        <li style="display:inline;"><a class="btn btn-default" href="../ViewProfile.jsp?prf_em=${farmer.email}&prf_id=0">View</a></li>
                                                        <li style="display:inline;"><a class="btn btn-danger" href="ViewFarmer.jsp?upd=${farmer.email}">Delete</a></li>
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
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
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
    </body>

</html>
