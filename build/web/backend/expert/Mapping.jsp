<%-- 
    Document   : Profile__
    Created on : Jun 6, 2017, 9:12:52 AM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page import="sys.classes.*" %>
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
        <link rel="shortcut icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
    </head>

    <body onload="notifyStatus()">
        <%
            //create database object
            DB_class DB = new DB_class();

            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
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
            int accStatus = DB.getAccountStatus(user_email, DB.getAuthKey(user_email));

            //error + success messages displayed after update
            Error_class user_error = (Error_class) request.getAttribute("ErrorMessage");
            if (user_error == null) {
                user_error = new Error_class();
            }
            Success_class user_sucess = (Success_class) request.getAttribute("signupSuccess");
            if (user_sucess == null) {
                user_sucess = new Success_class();
            }
//get the counts
            int exCount = DB.countExperts();
            int farmCount = DB.countFarmer();
            int postCount = DB.countPost();
            int blogCount = DB.countBlogs();
            int msgCount = DB.countMsg(user_email);
            int emailCount = DB.countEmail(user_email);
            //get map coordinates
            double lat = DB.getLat(user_email, "expert");
            double lng = DB.getLng(user_email, "expert");
            String addr = DB.getAddr(user_email, "expert");
        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_mail)%>
        </sql:query> 

        <sql:query dataSource="${bgGet}" var="reqMsg">
            <%= DB.getAllMsg(user_email)%>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope" id="fa-msg"> <%=msgCount%> </i> <b class="caret"></b></a>
                        <ul class="dropdown-menu message-dropdown">
                            <%if (msgCount == 0) {%>
                            <li class="divider"></li>
                            <li>
                            <li class="message-preview">
                                <p class="text-capitalize text-center">No Messages</p>
                            </li>
                            <%} else {%>
                            <c:forEach var="msg" items="${reqMsg.rows}">
                                <li class="message-preview">
                                    <a href="../Message.jsp?msg=${msg.msg_id}">
                                        <div class="media">
                                            <span class="pull-left">
                                                <i class="fa fa-envelope fa-2x"></i>
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong></strong>
                                                </h5>
                                                <p>${msg.message}...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                            <li class="message-footer">
                                <a href="../Message.jsp?msg=allMsgs">Read All New Messages</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-at" id="fa-em"> <%=emailCount%></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu message-dropdown">
                            <%if (emailCount == 0) {%>
                            <li class="divider"></li>
                            <li>
                            <li class="message-footer">
                                <p class="text-capitalize text-center">No Email</p>
                            </li>
                            <%} else {%>
                            <li class="divider"></li>
                            <li>
                            <li class="message-footer">
                                <a href="../Message.jsp?msg=allEmails">Read All Email</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="../ViewProfile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li>
                                <a href="../ViewSettings.jsp"><i class="fa fa-fw fa-gear"></i> Settings</a>
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
                            <a href="ExpertDash.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li >
                            <a href="SearchPage.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-search"></i> Search Epidemic</a>
                        </li>
                        <li >
                            <a href="BlogPage.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-book"></i>  Blogs</a>
                        </li>
                        <li class="active">
                            <a href="Mapping.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-map-marker"></i>  Mapping</a>
                        </li>
                        <li>
                            <div class="panel-body" style="height: 250px;">
                                <div id="map" style="height: 100%;width: 100%;"></div>
                            </div>
                        </li>
                        <li>
                            <div style="margin-top: 280px;padding-left: 10px;">
                                <p><a href="#">Copyright &copy; 2017</a></p>
                                <p style="color: #3c3c3c;">Terms of Services Applied</p>
                            </div>
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
                                <small>System Mapping</small>
                            </h1>
                            <!-- Page Heading -->
                            <ol class="breadcrumb">
                                <li>
                                    <i class="fa fa-dashboard"></i>  <a href="ExpertDash.jsp">Dashboard</a>
                                </li>
                                <li class="active">
                                    <i class="fa fa-user"></i> Mapping
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default" style="height: 450px;">
                                <div class="panel-heading" style="height: 30px;">
                                </div>
                                <div class="panel-body">

                                </div>
                            </div>
                        </div>
                    </div>
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
                zoom: 10,
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
        function notifyStatus() {
            //check if messages are available
            if (document.getElementById("countMsg").value !== "0") {
                document.getElementById("fa-msg").style.color = "#FF6666";
            } else if (document.getElementById("countMsg").value === "0") {
                document.getElementById("fa-msg").style.color = "#67b168";
            }
            if (document.getElementById("countEmail").value !== "0") {
                document.getElementById("fa-em").style.color = "#FF6666";
            } else if (document.getElementById("countEmail").value === "0") {
                document.getElementById("fa-em").style.color = "#67b168";
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
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>
    </body>
</html>
