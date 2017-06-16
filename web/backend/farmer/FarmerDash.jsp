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
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../../assets/css/plugins/sb-admin.css" rel="stylesheet">
        <link href="../../assets/css/plugins/morris.css" rel="stylesheet">
        <link href="../../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../../assets/css/custom.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon"/>
    </head>

    <body onload="notify()">
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
            String post_succ = (String) request.getAttribute("post_succ");
            if (post_succ == null) {
                post_succ = "";
            }
            String post_error = (String) request.getAttribute("post_error");
            if (post_error == null) {
                post_error = "";
            }
            String ErrorMessage = (String) request.getAttribute("ErrorMessage");
            if (ErrorMessage == null) {
                ErrorMessage = "";
            }

            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
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

            //get map coordinates
            double lat = DB.getLat(user_email, "farmer");
            double lng = DB.getLng(user_email, "farmer");
            String addr = DB.getAddr(user_email, "farmer");

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqPost">
            <%= DB.postPosted()%>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"> <%=msgCount%></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu message-dropdown">
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
                                <a href="../Message.jsp?msg=all">Read All New Messages</a>
                            </li>
                        </ul>
                    </li>
                    <li class="clearfix"></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
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
                        <li id="side-link" class="active">
                            <a href="FarmerDash.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li id="side-link">
                            <a href="SearchPage.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-search"></i> Search Epidemic</a>

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
                                Dashboard <small>Farmer</small>
                            </h1>
                            <ol class="breadcrumb">
                                <li class="active">
                                    <i class="fa fa-dashboard"></i> Dashboard
                                </li>
                            </ol>
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-12">
                            <!--check if account is confirmed to view message or not-->
                            <input type="number" class="hidden" value="" id='acc'/>
                            <!--confirmation message-->
                            <div class=" alert alert-warning mdl-shadow--2dp" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-users fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><%=exCount%></div>
                                            <div>Current Experts</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-yellow">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-file fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><%=postCount%></div>
                                            <div>Total Posts!</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-green">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-users fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><%=farmCount%></div>
                                            <div>Current Farmers</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-red">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-file fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><%=blogCount%></div>
                                            <div>Total Blogs!</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                <div class="panel panel-default" style="border-radius: 0px;">
                                    <div class="panel-heading" style="background-color: transparent;">
                                        <h2 class="panel-title" style="font-size: 20px;">Post an Epidemic</h2>
                                    </div>
                                    <div class="panel-body">
                                        <form class="form account-form" method="POST" action="PostEpidemic">
                                            <div class="row">
                                                <div class="col-md-7">
                                                    <div class="form-group mdl-shadow--4dp">
                                                        <input type="text" name="blog-title" class="form-control" id="blog-title" placeholder="Epidemic Title" tabindex="1">
                                                    </div> <!-- /.form-group -->
                                                </div>
                                                <div class="col-md-5">
                                                    <span class="text-danger" style="margin-bottom: 30px;"><%= ErrorMessage%></span>
                                                    <span class="text-success" style="margin-bottom: 30px;"><%= post_succ%></span>
                                                    <span class="text-danger" style="margin-bottom: 30px;"><%= post_error%></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <input type="hidden" name="blogdate" value="<%= (new java.util.Date().toLocaleString())%>"/>
                                            </div>              
                                            <div class="form-group mdl-shadow--4dp">
                                                <textarea class="form-control" rows="3" maxlength="1000" name="blog-content" placeholder="Type in your post or content here"></textarea>
                                            </div>
                                            <input type="hidden" value="<%= user_.getUserEmail()%>" name="useremail"/>
                                            <div class="row">
                                                <div class="col-md-7">
                                                    <div class="form-group">
                                                        <label for="exampleInputFile">Photo...</label>
                                                        <input type="file" id="exampleInputFile" style="border-radius: 0px;height: 20px;">
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-group " style="margin-top: 20px;">
                                                        <button type="submit" class="btn btn-success btn-block btn-post pull-right mdl-shadow--4dp" tabindex="4">
                                                            Post Epidemic <span class="glyphicon glyphicon-share" style="margin-left: 10px;"></span></i>
                                                        </button>
                                                    </div> <!-- /.form-group -->
                                                </div>
                                            </div>

                                        </form> 
                                    </div>
                                </div>

                                <div class="main-content">
                                    <div class="panel panel-default" >
                                        <div class="panel-heading" style="background-color: transparent;">
                                            <h2 class="panel-title" style="font-size: 20px;">Latest posted Epidemics</h2>
                                        </div>
                                        <%
                                            if (postCount != 0) {
                                        %>
                                        <c:forEach var="post" items="${reqPost.rows}">
                                            <div class="container-fluid item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">

                                                <div class="mdl-card mdl-cell mdl-cell--12-col-desktop mdl-cell--9-col-tablet mdl-cell--4-col-phone">
                                                    <div class="mdl-card__supporting-text">
                                                        <h4>${post.post_title} <span style="margin-left: 70px;"class="h3_span fa fa-calendar"> <c:out value="${post.reg_date}"/></span></h4>

                                                        <p><c:out value="${post.post_desc}"/> <a href="ViewPost.jsp?post_id=${post.post_id}" class="mdl-button">[Read more...] </a></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <hr>
                                        <div class="paginate"></div>
                                        <%} else {%>
                                        <section class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                            <p style="margin-left: 50px;margin-top: 40px;">There are no Epidemic Posts Posted as yet...</p>
                                        </section>
                                        <%}%>
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
                if (!window.Notification) {
                    alert('Sorry, not supported');
                } else {
                    Notification.requestPermission(function (p) {
                        if (p === 'denied') {
                            document.getElementById("response").innerHTML = "Denied Notification";
                        } else if (p === 'granted') {
                            if (Notification.permission === 'default') {
                                alert('allow notifications');
                            } else {
                                notify = new Notification('Notification', {
                                    body: 'You Have Messages...',
                                    icon: '../assets/img/1.jpg',
                                    tag: 'all'
                                });

                                notify.onclick = function () {
                                    window.location = '../Message.jsp?msg=' + this.tag;
                                };
                            }
                        }
                    });
                }
                
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
