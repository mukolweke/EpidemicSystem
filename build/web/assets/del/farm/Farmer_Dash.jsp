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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; FARMER DASHBOARD</title>
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
            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();
            int accStatus = DB.getAccountStatus(user_email, DB.getAuthKey(user_email));

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
            int countNotification = 1;
            //DB.countNotifications(user_name);
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
            double lat = DB.getLat(user_email,"farmer");
            double lng = DB.getLng(user_email,"farmer");
            String addr = DB.getAddr(user_email, "farmer");

        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= DB.user_Details(user_email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqPost">
            <%= DB.postPosted()%>
        </sql:query> 

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
                                <li class="" ><a href="#" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-bell"><%=countNotification%></span></a></li>
                                <li class="" ><a href="messages.jsp" class="popover-dismiss" id="not"><span style="padding-top: 5px;" class="glyphicon glyphicon-envelope"></span> <%=msgCount%></a></li>
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
                        <li class="active" ><a href="FarmerDash.jsp"  class="mdl-shadow--6dp" style="border: 1px solid #ddd;border-bottom-color: transparent;">System Dashboard</a></li>
                        <li><a href="SearchPage.jsp">Search Epidemic</a></li>
                    </ul>
                </div>
            </div>
            <!--end navbar TWO-->
        </header>

        <!--middle section-->
        <div class="tab-content"style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
            <div class="tab-pane fade in active" id="main-page">
                <div class="container">
                    <div class="row">
                        <div class="col-md-9">
                            <div class="main-content">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row" style="background-color: #f9f9f9;font-family:'Oxygen-Regular';" >
                                            <div class="col-md-4">
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
                                            <div class="col-md-8">
                                                <!--check if account is confirmed to view message or not-->
                                                <input type="number" class="hidden" value="<%=accStatus%>" id='acc'/>
                                                <!--confirmation message-->
                                                <div class=" alert alert-warning mdl-shadow--2dp" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>

                                                <div class="panel panel-default" style="border-radius: 0px;box-shadow: 20px;">
                                                    <div class="panel-heading" style="background-color: transparent;">
                                                        <h2 class="panel-title" style="font-size: 20px;">Post an Epidemic</h2>
                                                    </div>
                                                    <div class="panel-body">
                                                        <form class="form account-form" method="POST" action="PostEpidemic" style="margin-top: 20px;">
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
                                                            <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--4dp item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">
                                                                
                                                                <div class="mdl-card mdl-cell mdl-cell--12-col-desktop mdl-cell--9-col-tablet mdl-cell--4-col-phone">
                                                                    <div class="mdl-card__supporting-text">
                                                                        <h3><a href="ViewPost.jsp?post_id=${post.post_id}" style="color: #000;">${post.post_title} </a><span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>

                                                                        <p><c:out value="${post.post_desc}"/> </p>
                                                                    </div>
                                                                    <div class="mdl-card__actions">
                                                                        <a href="ViewPost.jsp?post_id=${post.post_id}" class="mdl-button">View More >>> </a>
                                                                    </div>
                                                                </div>
                                                            </section>
                                                        </c:forEach>

                                                        <hr>

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
                        </div>
                        <div class="col-md-3">
                            <div class="panel-heading" style="margin-top: 10px;"><header><h4>User Location</h4></header>
                            </div>
                            <div class="panel-body" style="height: 250px;">
                                <div id="map" style="height: 100%;width: 100%;"></div>
                            </div>
                            <div class="panel-heading" style="margin-top: 10px;"><header><h4>Current System Statistics</h4></header>
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
                </div>
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
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/custom.js"></script>
        <script type="text/javascript" src="../../assets/js/paginate.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>

    </body>
</html>