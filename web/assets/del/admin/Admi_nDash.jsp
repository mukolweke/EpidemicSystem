<%-- 
    Document   : AdminDash
    Created on : Apr 6, 2017, 9:45:28 PM
    Author     : Michael Mukolwe
--%>

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
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
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
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();

            //get the counts
            int exCount = DB.countExperts();
            int farmCount = DB.countFarmer();
            int postCount = DB.countPost();
            int blogCount = DB.countBlogs();

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqBlogs">
            <%= DB.blogsPosted()%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqPost">
            <%= DB.postPosted()%>
        </sql:query>


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
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
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
                        <li class="active" ><a href="AdminDash.jsp"  class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">System Dashboard</a></li>
                        <li><a href="ExpertPage.jsp">System Experts</a></li>
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
                <div class="container" >
                    <div class="row">
                        <div class="col-md-9">
                            <div class="main-content">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="panel-heading"><header><h4>Latest Epidemic Posts</h4></header>
                                        </div>
                                        <%
                                            if (postCount != 0) {
                                        %>
                                        <c:forEach var="post" items="${reqPost.rows}">
                                            <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--4dp item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                                <header class="section__play-btn mdl-cell mdl-cell--3-col-desktop mdl-cell--2-col-tablet mdl-cell--4-col-phone mdl-color--teal-100 mdl-color-text--white">
                                                    <a class="" href="#">
                                                        <img class="media-object well well-sm" src="../../assets/img/index.svg" alt="epidemic photo">
                                                    </a>
                                                </header>
                                                <div class="mdl-card mdl-cell mdl-cell--9-col-desktop mdl-cell--6-col-tablet mdl-cell--4-col-phone">
                                                    <div class="mdl-card__supporting-text">
                                                        <h3>${post.post_title} <span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>

                                                        <p><c:out value="${post.post_desc}"/> </p>
                                                    </div>
                                                    <div class="mdl-card__actions">
                                                        <a href="ViewPost.jsp?post_id=${post.post_id}" class="mdl-button">View More >>> </a>
                                                    </div>
                                                </div>
                                            </section>
                                        </c:forEach>

                                        <hr>
                                        <div class="paginate mdl-shadow--2dp"></div>

                                        <%} else {%>
                                        <section class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                            <p style="margin-left: 50px;margin-top: 40px;">There are no Epidemic Posts Posted as yet...</p>
                                        </section>

                                        <%}%>

                                        <br>
                                        <div class="panel-heading"><header><h4>Latest Epidemic Blogs</h4></header>
                                        </div>
                                        <%
                                            if (blogCount != 0) {
                                        %>
                                        <c:forEach var="post" items="${reqBlogs.rows}">
                                            <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--2dp item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                                <header class="section__play-btn mdl-cell mdl-cell--3-col-desktop mdl-cell--2-col-tablet mdl-cell--4-col-phone mdl-color--teal-100 mdl-color-text--white">
                                                    <a class="" href="#">
                                                        <img class="media-object well well-sm" src="../../assets/img/index.svg" alt="epidemic photo">
                                                    </a>
                                                </header>
                                                <div class="mdl-card mdl-cell mdl-cell--9-col-desktop mdl-cell--6-col-tablet mdl-cell--4-col-phone">
                                                    <div class="mdl-card__supporting-text">
                                                        <h3>${post.post_title} <span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>

                                                        <p><c:out value="${post.post_desc}"/> 
                                                    </div>
                                                    <div class="mdl-card__actions">
                                                        <a href="#" class="mdl-button">View More >>> </a>
                                                    </div>
                                                </div>
                                            </section>
                                        </c:forEach>

                                        <hr>
                                        <div class="paginate"></div>

                                        <%} else {%>
                                        <section class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                            <p style="margin-left: 50px;margin-top: 40px;">There are no Epidemic Blogs Posted as yet...</p>
                                        </section>

                                        <%}%>

                                        <br>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="panel-heading" style="margin-top: 40px;"><header><h4>Current System Statistics</h4></header>
                            </div>
                            <div class="panel-body panel-stats">
                                <div class="" style="">
                                    <section class="section--center section--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #3e8f3e;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Current Experts</h4>
                                        <p class="overview_count text-right"><b><%=exCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center section--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #66afe9;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Current Farmers</h4>
                                        <p class="overview_count text-right"><b><%=farmCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center section--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #ff0;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Current Epidemic Post</h4>
                                        <p class="overview_count text-right"><b><%=postCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center section--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #b2DBa1;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Current Expert Blogs</h4>
                                        <p class="overview_count text-right"><b><%=blogCount%></b></p>
                                    </section>
                                    <br/>
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

        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript">
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
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>