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

    <body onload="notifyStatus()">
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

            String ErrorMessage = (String) request.getAttribute("ErrorMessage");
            if (ErrorMessage == null) {
                ErrorMessage = "";
            }
            //check if session is active
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
            int user_id;
            if (!request.getParameter("prf_em").isEmpty()) {
                user_id = DB.getUserId(request.getParameter("prf_em"));
            } else {
                user_id = Integer.parseInt(request.getParameter("prf_id"));
            }
            //get the counts
            int exCount = DB.countExperts();
            int farmCount = DB.countFarmer();
            int postCount = DB.countPost();
            int blogCount = DB.countBlogs();
            int msgCount = DB.countMsg(user_email);
            int emailCount = DB.countEmail(user_email);
            //get map coordinates
            double lat = DB.getLat(user_email, "");
            double lng = DB.getLng(user_email, "");
            String addr = DB.getAddr(user_email, "");

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
                    <a class="navbar-brand" href="../index.jsp"><span><img src="../assets/img/favicon.png" style="height: 40px;width: 50px;"></span>FARMERS EPIDEMIC SYSTEM </a>
                </div>
                <!-- Top Menu Items -->

                <ul class="nav navbar-right top-nav">
                    <% if (DB.getAuthKey(user_.getUserEmail().toString()) == 1) {%>
                    <%} else {%>
                    <input type="number" class="hidden" value="<%=msgCount%>" id="countMsg"/>
                    <input type="number" class="hidden" value="<%=emailCount%>" id="countEmail"/>
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
                                    <a href="../backend/Message.jsp?msg=${msg.msg_id}">
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
                                <a href="../backend/Message.jsp?msg=allMsgs">Read All New Messages</a>
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
                                <a href="../backend/Message.jsp?msg=allEmails">Read All Email</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                    <%}%>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%= user_.getUserEmail()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <% if (DB.getAuthKey(user_.getUserEmail().toString()) == 1) {%>
                            <li class="divider"></li>
                            <li>
                                <a href="Logout"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                            <%} else {%>

                            <li>
                                <a href="ViewProfile.jsp?prf_id=<%=DB.getUserId(user_email)%>"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                            <li>
                                <a href="ViewSettings.jsp"><i class="fa fa-fw fa-gear"></i> Settings</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="Logout"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                </ul>
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <%if (DB.getAuthKey(user_email) == 1) {%>
                        <li >
                            <a href="admin/AdminDash.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" style="color:#5cb85c;" data-target="#experts"><i class="fa fa-fw fa-users"></i> Experts <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="experts" class="collapse">
                                <li>
                                    <a href="admin/AddExpert.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-plus"></i>  Add Experts</a>
                                </li>
                                <li>
                                    <a href="admin/ViewExpert.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-table"></i>  View Experts</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="admin/ViewFarmer.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-users"></i>  Farmers</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" style="color:#5cb85c;" data-target="#mapping"><i class="fa fa-fw fa-map-marker"></i>  Mapping <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="mapping" class="collapse">
                                <li>
                                    <a href="admin/ViewTables.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-table"></i>  Tables</a>
                                </li>
                                <li>
                                    <a href="admin/ViewCharts.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-bar-chart-o"></i>  Charts</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <div style="margin-top: 280px;padding-left: 10px;"><p><a href="#">Copyright &copy; 2017</a></p>
                                <p style="color: #3c3c3c;">Terms of Services Applied</p></div>
                        </li>
                        <%} else if (DB.getAuthKey(user_email) == 2) {%>

                        <li>
                            <a href="expert/ExpertDash.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="expert/SearchPage.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-search"></i> Search Epidemic</a>

                        </li>
                        <li>
                            <a href="expert/BlogPage.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-book"></i>  Blogs</a>
                        </li>
                        <li>
                            <a href="expert/Mapping.jsp" style="color:#5cb85c;"><i class="fa fa-fw fa-map-marker"></i>  Mapping</a>
                        </li>
                        <li>
                            <div class="panel-body" style="height: 250px;">
                                <div id="map" style="height: 100%;width: 100%;"></div>
                            </div>
                        </li>
                        <li>
                            <div style="margin-top: 300px;padding-left: 10px;"><p><a href="#">Copyright &copy; 2017</a></p>
                                <p style="color: #3c3c3c;">Terms of Services Applied</p></div>
                        </li>

                        <%} else if (DB.getAuthKey(user_email) == 3) {%>

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

                        <%}%>
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
                                Profile <small>User</small>
                            </h1>
                        </div>
                    </div><!-- /.row -->

                    <div class="row">
                        <%
                            //active session
                            int u_id = DB.getUserId(user_email);

                            if (u_id == user_id) {
                                String email = user_email;
                                int postCountUser = DB.countPostUser(user_email);
                        %>

                        <sql:query dataSource="${bgGet}" var="reqUsers">
                            <%= DB.user_Details(email)%>
                        </sql:query>

                        <sql:query dataSource="${bgGet}" var="reqPosts">
                            <%= DB.user_Posts(email)%>
                        </sql:query>
                        <div class="container" style="">
                            <div class="col-md-3">
                                <section class="section--center prof--center mdl-grid mdl-grid--no-spacing" style="margin-top: 10px;width: 100%;">
                                    <div class="" style="margin-top: 10px;height: 200px;width: 250px;padding-left: 20px;">
                                        <img id="blah" src="../assets/img/1.jpg" style="height: 200px;width: 200px;" class="img-thumbnail" alt="Profile image" />
                                    </div>
                                    <c:forEach var="user" items="${reqUsers.rows}">
                                        <div class="container-fluid">
                                            <header><h4>${user.name}</h4></header>
                                            <p><span class="glyphicon glyphicon-calendar"></span> : ${user.reg_date}</p>
                                            <p><span class="glyphicon glyphicon-map-marker"></span> : ${user.addr}</p>
                                            <hr>
                                            <p><span class="glyphicon glyphicon-phone"></span> : ${user.phone}</p>
                                            <p><span class="glyphicon glyphicon-envelope"></span> :${user.email}</p>
                                            <form action="" method="">
                                                <!--submit user id-->
                                                <div class="form-group">
                                                    <a class="btn btn-primary" style="border-radius: 0px; width: 100%;"href="ViewSettings.jsp?user_email=<%=user_.getUserEmail()%>">EDIT PROFILE</a>
                                                </div>
                                            </form>
                                        </div>
                                    </c:forEach>
                                </section>
                            </div> 
                            <div class="col-md-8">
                                <!--check if account is confirmed to view message or not-->
                                <input type="number" class="hidden" value="" id='acc'/>
                                <!--confirmation message-->
                                <div class="alert alert-warning mdl-shadow--2dp" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>
                                <div class="panel-body" style="height: 200px;">
                                    <div id="map" style="width: 100%;height: 100%;"></div>
                                </div>
                                <div class="panel panel-default" style = "margin-top: 20px;border-radius: 0px;box-shadow: 20px;"> 
                                    <div class="panel-heading" style="background-color: transparent;">
                                        <h2 class="panel-title" style="font-size: 20px;">Epidemic Post</h2>
                                    </div>
                                    <div class="" id="mypost">
                                        <%if (postCountUser != 0) {%>
                                        <c:forEach var="post" items="${reqPosts.rows}">
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
                                        <div class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                            <p style="margin-left: 50px;margin-top: 40px;">User hasn't posted any Epidemic Reports...</p>
                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>

                            <%} else {
                                String email = DB.getUserEmail(user_id);
                                int email_frm = DB.getUserId(user_email);
                                int email_to = user_id;
                                int postCountUser = DB.countPostUser(email);
                                String msg = request.getParameter("msg-content");
                                if (msg != null) {
                                    DB.postMsg(email_frm, email_to, msg);
                                }
                            %>
                            <sql:query dataSource="${bgGet}" var="reqUsers">
                                <%= DB.user_Details(email)%>
                            </sql:query>

                            <sql:query dataSource="${bgGet}" var="reqPosts">
                                <%= DB.user_Posts(email)%>
                            </sql:query>
                            <div class="container" style="">
                                <div class="col-md-3">
                                    <section class="section--center prof--center mdl-grid mdl-grid--no-spacing" style="margin-top: 10px;width: 100%;">
                                        <div class="" style="margin-top: 10px;height: 200px;width: 250px;padding-left: 20px;">
                                            <img id="blah" src="../assets/img/1.jpg" style="height: 200px;width: 200px;" class="img-thumbnail" alt="Profile image" />
                                        </div>
                                        <c:forEach var="user" items="${reqUsers.rows}">
                                            <div class="panel" style="padding-left: 20px;">
                                                <div class="panel-body">
                                                    <header><h4>${user.name}</h4></header>
                                                    <p><span class="glyphicon glyphicon-calendar"></span> : ${user.reg_date}</p>
                                                    <p><span class="glyphicon glyphicon-map-marker"></span> : ${user.addr}</p>
                                                    <hr>
                                                    <p><span class="glyphicon glyphicon-phone"></span> : ${user.phone}</p>
                                                    <p><span class="glyphicon glyphicon-envelope"></span> :${user.email}</p>
                                                    <div class="form-group">
                                                        <a class="btn btn-success" style="border-radius: 0px; height: 30px;width: 100%;" data-toggle="collapse" data-parent="#accordion" href="#collapseMsg">SEND MESSAGE</a>
                                                    </div> 
                                                    <div id="collapseMsg" class="panel-collapse collapse">
                                                        <div class="">
                                                            <p class="help-block">Message Form</p>
                                                            <form action="ViewProfile.jsp?prf_id=<%=user_id%>" method="post">
                                                                <div class="form-group">
                                                                    <textarea class="form-control" rows="3" style="width: 100%;" maxlength="1000" name="msg-content" required></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input type="submit" value="SEND" style="border-radius: 0px; width: 100%;"class="btn btn-success"/>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </section>
                                </div> 
                                <div class="col-md-8">
                                    <div class="panel-body" style="height: 200px;">
                                        <div id="map" style="width: 100%;height: 100%;"></div>
                                    </div>
                                    <div class="panel panel-default" style = "margin-top: 20px;border-radius: 0px;box-shadow: 20px;"> 
                                        <div class="panel-heading" style="background-color: transparent;">
                                            <h2 class="panel-title" style="font-size: 20px;">Epidemic Post</h2>
                                        </div>
                                        <div class="" id="mypost">
                                            <%if (postCountUser != 0) {%>
                                            <c:forEach var="post" items="${reqPosts.rows}">
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
                                                <p style="margin-left: 50px;margin-top: 40px;">You hasn't posted any Epidemic Reports...</p>
                                            </section>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <!-- /.row -->
                </div>
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
            <!--javascript files-->
            <script type="text/javascript" src="../assets/js/jquery.js"></script>
            <script type="text/javascript" src="../assets/js/bootstrap.min.js"></script>
            <script type="text/javascript" src="../assets/js/custom.js"></script>
            <script type="text/javascript" src="../assets/js/paginate.js"></script>

    </body>
</html>
