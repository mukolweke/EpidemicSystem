<%-- 
    Document   : ViewPost
    Created on : May 20, 2017, 6:49:49 PM
    Author     : Michael Mukolwe
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page import="sys.classes.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; ADMIN DASHBOARD</title>
        <!--css links-->
        <link href="../../assets/css/material.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon"/>
        <script src="https://maps.googleapis.com/maps/api/js?key= AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete"
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
        <header>
            <!--navbar one-->
            <nav class="navbar navbar-primary " role="navigation">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    <a class="navbar-brand" href="../../index.jsp"><span><img src="../../assets/img/favicon.png" style="height: 40px;width: 50px;"></span>FARMERS &CenterDot; EPIDEMIC &CenterDot; SYSTEM </a>
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
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
            <!--end navbar one-->
        </header>

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
                                                <h3><span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>
                                                <header class="mdl-cell mdl-cell--12-col-desktop mdl-cell--2-col-tablet mdl-cell--4-col-phone mdl-color--teal-100 mdl-color-text--white">
                                                    <div class="panel-body" style="height: 200px;">
                                                        <div id="map" style="width: 100%;height: 100%;"></div>
                                                    </div>
                                                </header>
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
                                                            <img class="well well-sm" src="../../assets/img/index.svg" style="height: 70px;width: 100%;" alt="epidemic photo">
                                                        </a>
                                                    </div>
                                                    <div class="col-md-10">
                                                        <form action="ViewPost.jsp?post_id=${post.post_id}" method="get">
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
                                                                    <img class="well well-sm" src="../../assets/img/index.svg" style="height: 70px;width: 100%;" alt="epidemic photo">
                                                                </a>
                                                            </div>
                                                            <div class="col-md-8">
                                                                <p>${comments.comment_desc}</p>
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

        <!-- Footer -->
        <footer class="">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>

        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>