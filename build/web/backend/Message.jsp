<%-- 
    Document   : Message
    Created on : May 3, 2017, 8:59:00 AM
    Author     : Michael Mukolwe
--%>
<%-- 
    Document   : ViewProfile
    Created on : Jun 11, 2017, 7:35:43 AM
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
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../assets/css/plugins/sb-admin.css" rel="stylesheet">
        <link href="../assets/css/plugins/morris.css" rel="stylesheet">
        <link href="../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../assets/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../assets/img/favicon.png" type="image/x-icon"/>
        <link rel="icon" href="../assets/img/favicon.png" type="image/x-icon"/>
    </head>

    <body>
        <%

            //create database object
            DB_class DB = new DB_class();
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();
//            int accStatus = DB.getAccountStatus(user_email, DB.getAuthKey(user_email));

            Sign_class user_details = (Sign_class) request.getSession().getAttribute("user_details");
            if (user_details == null) {
                user_details = new Sign_class();
            }

            String ErrorMessage = (String) request.getAttribute("ErrorMessage");
            if (ErrorMessage == null) {
                ErrorMessage = "";
            }
            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            //get the counts
            int exCount = DB.countExperts();
            int farmCount = DB.countFarmer();
            int postCount = DB.countPost();
            int blogCount = DB.countBlogs();
            int msgCount = DB.countMsg(user_email);
            String msgtyp = request.getParameter("msg");
            int msgid = 0;
            if(!msgtyp.equals("all")){
                 msgid = Integer.parseInt(msgtyp);
            }
            //get map coordinates
            double lat = DB.getLat(user_email, "");
            double lng = DB.getLng(user_email, "");
            String addr = DB.getAddr(user_email, "");

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqMsg">
            <%= DB.getMsg(user_email,msgid)%>
        </sql:query> 

        <sql:query dataSource="${bgGet}" var="reqAllMsg">
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
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="Profile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li>
                                <a href="ViewSettings.jsp"><i class="fa fa-fw fa-gear"></i> Settings</a>
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
                        <li id="side-link">
                            <a href="farmer/FarmerDash.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li id="side-link">
                            <a href="farmer/SearchPage.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-search"></i> Search Epidemic</a>

                        </li>
                        <li>
                            <div style="margin-top: 380px;padding-left: 10px;"><p><a href="#">Copyright &copy; 2017</a></p>
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
                                <small>Messages</small>
                            </h1>
                        </div>
                    </div><!-- /.row -->
                </div>
                <div class="row" style="height: 500px;">
                    <%if (msgtyp.equals("all")) {%>
                    <c:forEach var="msg" items="${reqAllMsg.rows}">
                        <li class="message-preview">
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
                        </li>
                    </c:forEach>
                    <%} else {%>
                    <c:forEach var="msg" items="${reqMsg.rows}">
                        <li class="message-preview">
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
                        </li>
                    </c:forEach>
                    <%}%>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->

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
            <script type="text/javascript" src="../assets/js/jquery.js"></script>
            <script type="text/javascript" src="../assets/js/bootstrap.min.js"></script>
            <script type="text/javascript" src="../assets/js/custom.js"></script>
            <script type="text/javascript" src="../assets/js/paginate.js"></script>

    </body>
</html>
