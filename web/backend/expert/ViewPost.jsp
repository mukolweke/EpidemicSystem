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
        <link href="../../assets/css/custom.css" rel="stylesheet"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
        async defer></script>
        <style type="text/css">
            #map {
                height: 50%;
            }
        </style>
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

            int user_id = DB.getUserId(user_email);

            String post_id = request.getParameter("post_id");
            int postid = Integer.parseInt(post_id);
            //doesnt go below count zero or beyond
            if (postid <= 0) {
                postid = 1;
            } else if (postid > DB.countPost()) {
                postid = 1;
            }

            String date = request.getParameter("time");
            String comment = request.getParameter("blog-comment");
            int countComm = DB.countComment(postid);

            if (comment != null || date != null) {
                DB.postComment(post_id, user_id, comment, date);
            }
            //MAPP WORK
            double lat = DB.postLat(postid);
            double lng = DB.postLng(postid);

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="getPost">
            <%= DB.getPost(postid)%>
        </sql:query>
        <sql:query dataSource="${bgGet}" var="allPost">
            <%= DB.allTitle()%>
        </sql:query>
        <sql:query dataSource="${bgGet}" var="getComment">
            <%= DB.getComment(postid)%>
        </sql:query>
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
                    label: "P",
                    map: map
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="Profile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><i class="fa fa-fw fa-user"></i> Profile</a>
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
                            <a href="ExpertDash.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="SearchPage.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-search"></i> Search Epidemic</a>
                        </li>
                        <li>
                            <a href="BlogPage.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-book"></i>  Blogs</a>
                        </li>
                        <li>
                            <a href="Mapping.jsp" style="color:#5cb85c"><i class="fa fa-fw fa-map-marker"></i>  Mapping</a>
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

            <div id="page-wrapper">

                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="row">
                        <div class="col-lg-12">
                            <ol class="breadcrumb">
                                <li class="active">
                                    <i class="fa fa-dashboard"></i> <a href="ExpertDash.jsp">Dashboard</a>
                                </li>
                                <li>
                                    <i class="fa fa-user"></i> View Post
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
                        <div class="col-lg-12">
                            <!--middle section-->
                            <div class="tab-content"style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
                                <div class="tab-pane fade in active" id="main-page">
                                    <div class="container" >
                                        <div class="row">
                                            <div class="col-md-9">
                                                <div class="main-content">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <c:forEach var="post" items="${getPost.rows}">
                                                                <section class="section--center mdl-grid mdl-grid--no-spacing" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                                                    <h2>${post.post_title} </h2>
                                                                    <h4><span class="fa fa-calendar"> <c:out value="${post.reg_date}"/></span></h4>
                                                                    <header class=" ">
                                                                        <div class="panel-body" style="height: 200px;">
                                                                            <div id="map" style="width: 100%;height: 100%;"></div>
                                                                        </div>
                                                                    </header>
                                                                    <hr>
                                                                    <div class="mdl-card mdl-cell mdl-cell--12-col-desktop mdl-cell--6-col-tablet mdl-cell--4-col-phone">
                                                                        <div class="mdl-card__supporting-text">
                                                                            <p style="line-height: 2.5;"><c:out value="${post.post_desc}"/> </p>
                                                                        </div>
                                                                    </div>
                                                                </section>
                                                                <hr>
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <p class="text-center"><a href="ViewPost.jsp?post_id=${post.post_id - 1}"><<< <%=DB.getTitle(postid - 1)%></a></p>
                                                                    </div>
                                                                    <div class="col-md-4 clearfix"></div>
                                                                    <div class="col-md-4">
                                                                        <p class="text-center"><a href="ViewPost.jsp?post_id=${post.post_id + 1}"><%=DB.getTitle(postid + 1)%> >>></a></p>
                                                                    </div>
                                                                </div>

                                                                <hr>
                                                                <div class="comment-panel">
                                                                    <div class="container">
                                                                        <p style="font-weight: bold;"><%=countComm%> comments</p>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col-md-2">
                                                                            <a class="" href="#">
                                                                                <img class="well well-sm" src="../../assets/img/1.jpg" style="height: 70px;width: 80%;" alt="epidemic photo">
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-md-10">
                                                                            <form action="ViewPost.jsp?post_id=${post.post_id}" method="post">
                                                                                <input type="hidden" name="post_id" value="${post.post_id}"/>
                                                                                <input type="hidden" name="user_id" value="${post.user_id}"/>
                                                                                <input type="hidden" name="time" value="<%=new Date()%>"/>
                                                                                <div class="form-group ">
                                                                                    <input class="form-control" name="blog-comment" style="height: 70px;"placeholder="Type in your post or content here"/>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>

                                                                    <hr>
                                                                    <div class="">
                                                                        <c:forEach var="comments" items="${getComment.rows}">
                                                                            <div class="row">
                                                                                <div class="col-md-2 clearfix"></div>
                                                                                <div class="col-md-2">
                                                                                    <a class="" href="#">
                                                                                        <img class="well well-sm" src="../../assets/img/1.jpg" style="height: 70px;width: 80%;" alt="epidemic photo">
                                                                                    </a>
                                                                                </div>
                                                                                <div class="col-md-8">
                                                                                    <p>${comments.comm_desc}</p>
                                                                                </div>
                                                                            </div>
                                                                        </c:forEach>

                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3 clearfix">
                                                <div class="panel" style="margin-top: 50px;">
                                                    <div class="panel-body">
                                                        <h4 style="margin-bottom: 30px;text-decoration: underline;">Other Latest Posts</h4>
                                                        <c:forEach var="title" items="${allPost.rows}">
                                                            <p><a href="ViewPost.jsp?post_id=${title.post_id}">${title.post_title}</a></p>
                                                            <hr>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- /.container -->
                                </div>
                            </div>
                            <!--end middle section-->
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
