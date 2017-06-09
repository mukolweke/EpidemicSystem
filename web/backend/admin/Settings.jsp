<%-- 
    Document   : FarmerDash
    Created on : Apr 6, 2017, 9:46:11 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page import="sys.classes.*,java.util.Date" %>

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
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom CSS -->
        <link href="../../assets/css/plugins/sb-admin.css" rel="stylesheet"/>
        <link href="../../assets/css/plugins/morris.css" rel="stylesheet"/>
        <link href="../../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/custom.css" rel="stylesheet"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon"/>
    </head>

    <body>
        <%
            //session active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            //database object
            DB_class db = new DB_class();

            //get user logged email
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
            String user_email = user.getUserEmail();
            //or
            String user_mail = request.getParameter("user_email");
            if (user_mail == null) {
                user_mail = user.getUserEmail();
            }

            //get account status
            int accStatus = db.getAccountStatus(user_email, db.getAuthKey(user_email));

            //error + success messages displayed after update
            Error_class user_error = (Error_class) request.getAttribute("ErrorMessage");
            if (user_error == null) {
                user_error = new Error_class();
            }
            Success_class user_sucess = (Success_class) request.getAttribute("signupSuccess");
            if (user_sucess == null) {
                user_sucess = new Success_class();
            }
            //get map coordinates
            double lat = db.getLat(user_email, "admin");
            double lng = db.getLng(user_email, "admin");
            String addr = db.getAddr(user_email, "admin");
        %>
        <sql:setDataSource var='bgGet' driver='<%= db.jstlDriver()%>' url='<%= db.jstlUrl()%>' user='<%= db.jstlUser()%>'  password='<%= db.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= db.user_Details(user_mail)%>
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
                    <a class="navbar-brand" href="../../index.jsp"><span style="color:#5cb85c;">FEWS</span> Admin</a>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="Profile.jsp?prf_id=<%=db.getUserId(user_email)%>"><i class="fa fa-fw fa-user"></i> Profile</a>
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

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb">
                                <li class="active">
                                    <i class="fa fa-dashboard"></i> <a href="FarmerDash.jsp">Dashboard</a>
                                </li>
                                <li>
                                    <i class="fa fa-gear"></i> Settings
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-12">
                            <!--check if account is confirmed to view message or not-->
                            <input type="number" class="hidden" value="<%=accStatus%>" id='acc'/>
                            <!--confirmation message-->
                            <div class=" alert alert-warning mdl-shadow--2dp" id="alert_status" >A confirmation email was sent to <strong><%=user.getUserEmail()%></strong>. Please verify your account!</div>
                            <p style="margin-top: 10px;"><span class="text-danger" style="margin-bottom: 30px;"><%= user_error.getErrorMessage()%></span></p>
                            <p><span class="text-success" style="margin-bottom: 30px;"><%= user_sucess.getUserSuccess()%></span></p>
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel-body" style="height: 250px;">
                                <div id="map" style="height: 100%;width: 100%;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel-body">
                                <div class="row" >
                                    <div class="col-md-3">
                                        <div class="list-group" role="tablist" id="myTab">
                                            <a href="#" class="list-group-item disabled">
                                                Personal Settings
                                            </a>
                                            <a href="#profile_setting" class="list-group-item" role="tab" data-toggle="tab">Profile</a>
                                            <a href="#account_setting" class="list-group-item" role="tab" data-toggle="tab">Account</a>
                                        </div>
                                    </div>
                                    <!--tabs content-->
                                    <div class="col-md-9">
                                        <div class="tab-content">
                                            <div class="tab-pane fade in active" id="profile_setting">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading"style="background-color: transparent;">
                                                        <h3 class="panel-title">Public Profile Settings</h3>
                                                        <p style="margin-top: 10px;"><span class="text-danger" style="margin-bottom: 30px;"><%= user_error.getErrorMessage()%></span></p>
                                                        <p><span class="text-success" style="margin-bottom: 30px;"><%= user_sucess.getUserSuccess()%></span></p>
                                                    </div>
                                                    <c:forEach var="user" items="${reqUsers.rows}">
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-md-7">
                                                                    <form class="form account-form" action="Settings" method="post">
                                                                        <div class="form-group">
                                                                            <label >Full Name:</label>
                                                                            <input type="text" name="userFullName" class="form-control" id="userFullName" placeholder="${user.name}" tabindex="1">
                                                                        </div> <!-- /.form-group -->
                                                                        <div class="form-group">
                                                                            <label>User Phone:</label>
                                                                            <input type="text" name="userPhone" class="form-control" id="userPhone" placeholder="${user.phone}" tabindex="1">
                                                                        </div> <!-- /.form-group -->
                                                                        <div class="form-group">
                                                                            <label>User Location</label>
                                                                            <input type="text" name="userLocation" class="form-control" id="userLocation" placeholder="${user.addr}" tabindex="1">
                                                                        </div> <!-- /.form-group -->
                                                                        <input type="hidden" name="lat" id="lat"/>
                                                                        <input type="hidden" name="lng" id="lng"/>
                                                                        <div class="form-group">
                                                                            <label>Email Address</label><span class="help-block">If you want to change email contact Admin</span>
                                                                            <input type="text" name="" class="form-control" id="userEmail" value="${user.email}" tabindex="1" disabled>
                                                                        </div> <!-- /.form-group -->
                                                                        <input type="hidden" name="userEmail" value="<%=user.getUserEmail()%>"/>
                                                                        <input type="hidden" name="settingType" value="profile_settings"/>
                                                                        <div class="form-group">
                                                                            <button type="submit" class="btn btn-primary" tabindex="4">
                                                                                EDIT PROFILE <span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                                <div class="col-md-5">
                                                                    <form class="form account-form" action="" method="">
                                                                        <div class="form-group">
                                                                            <label>Profile Picture</label>
                                                                            <div class="row">
                                                                                <div class="col-xs-6 col-md-7">
                                                                                    <a href="#" type="file"class="thumbnail">
                                                                                        <img src="../../assets/img/1.jpg"alt="...">
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                        </div> <!-- /.form-group -->
                                                                        <input name="settingType" value="pic_settings" type="hidden"/>
                                                                        <div class="form-group">
                                                                            <button type="submit" class="btn btn-default" tabindex="4">
                                                                                UPDATE PICTURE<span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                                                            </button>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>       
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="account_setting">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading"style="background-color: transparent;">
                                                        <h3 class="panel-title">Account Settings</h3>
                                                    </div>
                                                    <div class="panel-body">
                                                        <h3 class="panel-title" style="">Change Password:</h3>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-8" style="margin-left: 10px;">
                                                            <form action="Settings" class="" method="post">
                                                                <input name="settingType" value="pass_settings" type="hidden"/>
                                                                <input type="hidden" name="userEmail" value="<%=user.getUserEmail()%>"/>
                                                                <div class="form-group">
                                                                    <label>Old Password:</label>
                                                                    <input type="password" name="user-old-pass" class="form-control" placeholder="e.g. ******" tabindex="1">
                                                                </div> <!-- /.form-group -->
                                                                <div class="form-group">
                                                                    <label>New Password:</label>
                                                                    <input type="password" name="user-new-pass" class="form-control"  placeholder="e.g. ******" tabindex="1">
                                                                </div> <!-- /.form-group -->
                                                                <p class="help-block">Must be more than 6 characters</p>
                                                                <div class="form-group">
                                                                    <label>Confirm New Password:</label>
                                                                    <input type="password" name="user-con-new-pass" class="form-control"  placeholder="e.g. ******" tabindex="1">
                                                                </div> <!-- /.form-group -->
                                                                <div class="form-group">
                                                                    <button type="submit" class="btn btn-primary" tabindex="4">
                                                                        UPDATE PASSWORD <span class="glyphicon glyphicon-edit" style="margin-left: 10px;"></span></i>
                                                                    </button>               
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel panel-default">
                                                    <div class="panel-heading"style="background-color: transparent;">
                                                        <h3 class="panel-title">Delete Account</h3>
                                                    </div>
                                                    <div class="panel-body">
                                                        <p>Delete Account; Once deleted you will lost your details</p>
                                                        <form class="" action="Settings" method="post">
                                                            <input name="settingType" value="account_settings" type="hidden"/>
                                                            <input type="hidden" name="userEmail" value="<%=user.getUserEmail()%>"/>
                                                            <div class="form-group">
                                                                <button type="submit" class="btn btn-danger" tabindex="4">
                                                                    DELETE ACCOUNT <span class="glyphicon glyphicon-off" style="margin-left: 10px;"></span>
                                                                </button>                                
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->

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
            </script>
            <!--javascript files-->
            <script type="text/javascript" src="../../assets/js/jquery.js"></script>
            <script type="text/javascript" src="../../assets/js/bootstrap.min.js"></script>
            <script type="text/javascript" src="../../assets/js/custom.js"></script>
            <script type="text/javascript" src="../../assets/js/paginate.js"></script>
    </body>
</html>
