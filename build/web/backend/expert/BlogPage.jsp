<%-- 
    Document   : blog-page
    Created on : Apr 7, 2017, 12:35:15 AM
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
        <title>FEWS &CenterDot; EXPERT DASHBOARD</title>
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

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
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
                                <%= user.getUserEmail()%>
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
                        <li><a href="ExpertDash.jsp">System Dashboard</a></li>
                        <li><a href="SearchPage.jsp" >Search Epidemic</a></li>
                        <li class="active"><a href="BlogPage.jsp" class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">Blog</a></li>
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
                        <div class="col-md-9" style="min-height: 500px;">
                            <div class="main-content">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form class="form account-form" method="POST" action="Login">
                                            <div class="row">
                                                <div class="form-group mdl-shadow--6dp">
                                                    <textarea class="form-control" rows="3"></textarea>                                </div>
                                                <div class="form-group  mdl-shadow--4dp">
                                                    <button type="submit" class="btn btn-primary btn-block pull-right" tabindex="4">
                                                        Post Blog <span class="glyphicon glyphicon-share" style="margin-left: 10px;"></span></i>
                                                    </button>
                                                </div> <!-- /.form-group -->
                                            </div>
                                        </form>   
                                        <hr>
                                        <h4 class="">Recent Blogs</h4>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-3">
                            <section class="section--center prof--center mdl-grid mdl-grid--no-spacing" style="margin-top: 10px;width: 100%;">
                                <div class="" style="margin-top: 10px;height: 200px;width: 250px;padding-left: 20px;">
                                    <img id="blah" src="../../assets/img/1.jpg" style="height: 200px;width: 200px;" class="img-thumbnail" alt="Profile image" />
                                </div>
                                <c:forEach var="user" items="${reqUsers.rows}">
                                    <div class="panel panel-default" style="padding-left: 20px;">
                                        <div class="panel-body">
                                            <header><h4>${user.name}</h4></header>
                                            <p><span class="glyphicon glyphicon-calendar"></span> : ${user.reg_date}</p>
                                            <p><span class="glyphicon glyphicon-map-marker"></span> : ${user.addr}</p>
                                            <hr>
                                            <p><span class="glyphicon glyphicon-phone"></span> : ${user.phone}</p>
                                            <p><span class="glyphicon glyphicon-envelope"></span> :${user.email}</p>
                                            <form action="" method="">
                                                <!--submit user id-->
                                                <div class="form-group">
                                                    <a class="btn btn-primary" style="border-radius: 0px; width: 100%;"href="settings.jsp?user_email=<%=user_.getUserEmail()%>">EDIT PROFILE</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </section>
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