<%-- 
    Document   : search-page
    Created on : Apr 7, 2017, 12:44:09 AM
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
        <link href="../../assets/css/custom.css" rel="stylesheet"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
        <script>
            var request = new XMLHttpRequest();
            function searchInfo() {
                var name = document.vinform.name.value;
                var url = "../filter.jsp?val=" + name;
                try {
                    request.onreadystatechange = function () {
                        if (request.readyState === 4) {
                            var val = request.responseText;
                            document.getElementById('mylocation').innerHTML = val;
                        }
                    };//end of function
                    request.open("GET", url, true);
                    request.send();
                } catch (e) {
                    alert("Unable to connect to server");
                }
            }
        </script>
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

            //get the counts
            int exCount = DB.countExperts();
            int farmCount = DB.countFarmer();
            int postCount = DB.countPost();
            int blogCount = DB.countBlogs();
            int searchResult = 0;

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
            <nav class="navbar navbar-default navbar-fixed-top " role="navigation">
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
                        <li class="active"><a href="SearchPage.jsp" class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">Search Epidemic</a></li>
                        <li><a href="BlogPage.jsp">Blog</a></li>
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
                                        <form class="form account-form" name="vinform">
                                            <div class="row">
                                                <div class="col-md-11">
                                                    <div class="form-group">
                                                        <input type="text" class="form-control" name="name" style="width: 100%;border-radius: 0px;height: 48px;" placeholder="INSERT SEARCH FILTER ..." onkeyup="searchInfo()" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <hr>
                                        <div style="margin-top: 50px;">
                                            <span id="mylocation"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="panel-heading" style="margin-top: 40px;"><header><h4>Current System Statistics</h4></header>
                            </div>
                            <div class="panel-body panel-stats">
                                <div class="" style="">
                                    <section class="section--center sect--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #3e8f3e;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Experts</h4>
                                        <p class="overview_count_ex" style="padding-left: 100px;"><b><%=exCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center sect--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #66afe9;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Farmers</h4>
                                        <p class="overview_count_ex text-right" style="padding-left: 100px;"><b><%=farmCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center sect--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #ff0;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Epidemic Post</h4>
                                        <p class="overview_count_ex text-right"  style="padding-left: 45px;"><b><%=postCount%></b></p>
                                    </section>
                                    <br/>
                                    <section class="section--center sect--center--stats mdl-grid mdl-grid--no-spacing mdl-shadow--6dp" style="background-color: #b2DBa1;border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                        <h4>Expert Blogs</h4>
                                        <p class="overview_count_ex text-right"  style="padding-left: 55px;"><b><%=blogCount%></b></p>
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