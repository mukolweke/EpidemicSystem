<%-- 
    Document   : AdminDash
    Created on : Jun 6, 2017, 12:17:02 AM
    Author     : Michael Mukolwe
--%>

<%@page import="sys.classes.*" %>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script src="https://maps.googleapis.com/maps/api/js?key= AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <script type="text/javascript">
            function initAutocomplete() {
                var autocomplete = new google.maps.places.Autocomplete(document.getElementById('user-location'));
                google.maps.event.addListener(autocomplete, 'place_changed', function () {
                    var place = autocomplete.getPlace();
                    document.getElementById("lat").value = place.geometry.location.lat();
                    document.getElementById("lng").value = place.geometry.location.lng();

                });
            }
            ;
        </script>
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
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../../index.jsp">FEWS Admin</a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu message-dropdown">
                            <li class="message-preview">
                                <a href="#">
                                    <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="message-preview">
                                <a href="#">
                                    <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="message-preview">
                                <a href="#">
                                    <div class="media">
                                        <span class="pull-left">
                                            <img class="media-object" src="http://placehold.it/50x50" alt="">
                                        </span>
                                        <div class="media-body">
                                            <h5 class="media-heading"><strong>John Smith</strong>
                                            </h5>
                                            <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="message-footer">
                                <a href="#">Read All New Messages</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu alert-dropdown">
                            <li>
                                <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#">View All</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="Profile.jsp?prf_id=<%=DB.getUserId(user_.getUserEmail())%>"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li>
                                <a href="Settings.jsp"><i class="fa fa-fw fa-gear"></i> Settings</a>
                            </li>
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
                        <li>
                            <a href="AdminDash.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li class="active">
                            <a href="javascript:;" data-toggle="collapse" data-target="#experts"><i class="fa fa-fw fa-users"></i> System Experts <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="experts" class="collapse">
                                <li class="active">
                                    <a href="AddExpert.jsp"><i class="fa fa-fw fa-plus"></i>  Add Experts</a>
                                </li>
                                <li>
                                    <a href="ViewExpert.jsp"><i class="fa fa-fw fa-table"></i>  View Experts</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="ViewFarmer.jsp"><i class="fa fa-fw fa-users"></i> System Farmers</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#mapping"><i class="fa fa-fw fa-map-marker"></i>  Mapping <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="mapping" class="collapse">
                                <li>
                                    <a href="ViewTables.jsp"><i class="fa fa-fw fa-table"></i>  Tables</a>
                                </li>
                                <li>
                                    <a href="ViewCharts.jsp"><i class="fa fa-fw fa-bar-chart-o"></i>  Charts</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <div style="margin-top: 300px;padding-left: 10px;"><p><a href="#">Copyright &copy; 2017</a></p>
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
                                <small> <i class="fa fa-plus-circle"></i> Add new Expert</small>
                            </h1>
                            <!-- Page Heading -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="AdminDash.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-user-md"></i> Add Expert
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->


                    <div class="row" style="height: 430px;">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"> Add Expert Form</h3>
                                    <p><span class="text-danger"><%= user_error.getErrorMessage()%></span></p>
                                    <p><span class="text-success"><%= user_sucess.getUserSuccess()%></span></p>
                                </div>
                                <div class="panel-body">
                                    <form class="form account-form" method="post" action="ExpertPage">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <input type="text" name="user-name" class="form-control" placeholder="Full Name" tabindex="1">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" name="user-email" class="form-control" placeholder="Email Address" tabindex="1">
                                            </div> <!-- /.form-group -->
                                            <div class="form-group">
                                                <input type="text" name="user-phone" class="form-control" placeholder="Phone Contact" tabindex="1">
                                            </div> <!-- /.form-group -->

                                            <input type="hidden" name="lat" id="lat"/>
                                            <input type="hidden" name="lng" id="lng"/>
                                            <input type="hidden" name="reg_date" value="<%= (new java.util.Date().toLocaleString())%>"/>
                                            <div class="form-group">
                                                <select name="field-study" style="width:100%;height: 40px;">
                                                    <option class="disabled">Expert Speciality</option>
                                                    <option value="all">All</option>
                                                    <option value="farming">Farming</option>
                                                    <option value="animals">Animals</option>
                                                    <option value="weather">Weather</option>
                                                    <option value="soil">Soil</option>
                                                    <option value="water">Water</option>
                                                </select>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6" style="margin-top: 20px;">
                                                    <input type="text" name="user-location" id="user-location" class="form-control" placeholder="City of Operation" tabindex="2">
                                                </div> <!-- /.form-group -->

                                                <div class="form-group col-md-6">
                                                    <input type="password" name="user-password" style="margin-top: 20px;"class="form-control" placeholder="Password" tabindex="2">
                                                </div> <!-- /.form-group -->
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <img id="blah" src="../../assets/img/1.jpg" style="margin-left: 30px;" class="img-thumbnail" alt="Profile image" />
                                            <input type='hidden' name="photo" class="btn btn-primary" onchange="readURL(this);" />

                                            <div class="form-group" style="margin-top: 70px;">
                                                <button type="submit" class="btn btn-success btn-block btn-lg" tabindex="4">
                                                    Add Expert <span class="glyphicon glyphicon-plus" style="margin-left: 10px;"></span></i>
                                                </button>
                                            </div> <!-- /.form-group -->
                                        </div>
                                    </form> 
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
        <!--javascript files-->
        <script src="../../assets/js/jquery.js"></script>
        <script src="../../assets/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>

        <script src="../../assets/js/plugins/morris/raphael.min.js"></script>
        <script src="../../assets/js/plugins/morris/morris.min.js"></script>
        <script src="../../assets/js/plugins/morris/morris-data.js"></script>

    </body>

</html>
