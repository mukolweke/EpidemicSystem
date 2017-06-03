<%-- 
    Document   : expert-page
    Created on : Mar 31, 2017, 1:57:16 PM
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
    <body style="background-color: #f9f9f9;">
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
                                <%= user_.getUserEmail()%>
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
                        <li class="active" ><a href="ExpertPage.jsp"  class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">System Experts</a></li>
                        <li><a href="FarmerPage.jsp">System Farmers</a></li>
                        <li><a href="Mapping.jsp">System Mapping</a></li>
                    </ul>

                </div>
            </div>
            <!--end navbar TWO-->
        </header>

        <!--middle section-->
        <div class="tab-content"style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
            <div class="tab-pane fade in active" id="main-page">
                <div class="container" style="margin-top: 50px;">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="list-group" role="tablist" id="myTab">
                                <a href="#" class="list-group-item disabled">
                                    Manage Experts
                                </a>
                                <a href="#add_experts" class="list-group-item" role="tab" data-toggle="tab">Add Experts</a>
                                <a href="#view_experts" class="list-group-item" role="tab" data-toggle="tab">View Experts</a>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="add_experts">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"style="background-color: transparent;">
                                            <h3 class="panel-title" style="font-size: 20px;"><span class="glyphicon glyphicon-plus-sign"></span>  Add New Expert</h3>
                                            <p><span class="text-danger"><%= user_error.getErrorMessage()%></span></p>
                                            <p><span class="text-success"><%= user_sucess.getUserSuccess()%></span></p>
                                        </div>
                                        <div class="panel panel-expert">
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
                                </div><!--end tab one-->
                                <div class="tab-pane fade" id="view_experts">
                                    <div class="panel panel-default" style="min-height: 430px;">
                                        <div class="panel-heading"style="background-color: transparent;">
                                            <h3 class="panel-title" style="font-size: 20px;">Farming Experts Details</h3>
                                        </div>
                                        <div class="panel panel-expert">
                                            <div class="panel-body">
                                                <div id="map-canvas" style="height: 200px;">
                                                    <p class="help-block">Map work here</p>
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
                                                            <td>${expert.ip_address}</td>
                                                            <td>
                                                                <ul class="" style="list-style-type:none">
                                                                    <li style="display:inline;"><a class="btn btn-default" href="profile.jsp?prf=${expert.email}">View</a></li>
                                                                    <li style="display:inline;"><a class="btn btn-danger" href="ExpertPage.jsp?upd=${expert.email}">Delete</a></li>
                                                                </ul>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end tab two-->
                        </div><!--end tab content-->
                    </div><!--end row-->
                </div><!-- /.container -->
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
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>
