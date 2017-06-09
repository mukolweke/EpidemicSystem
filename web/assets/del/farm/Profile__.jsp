<%-- 
    Document   : profile
    Created on : Apr 14, 2017, 5:12:18 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="sys.classes.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
    <body style="background-color: #f9f9f9;font-family:'Oxygen-Regular';" onload="notify();">

        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }

            DB_class db = new DB_class();

            Login_class user_ = (Login_class) session.getAttribute("user");
            if (user_ == null) {
                user_ = new Login_class();
            }
            String user_email = user_.getUserEmail();
//            int countNotification = db.countNotifications(user_email);
            int accStatus = db.getAccountStatus(user_email, db.getAuthKey(user_email));
            int user_id = Integer.parseInt(request.getParameter("prf_id"));

        %>
        <sql:setDataSource var='bgGet' driver='<%= db.jstlDriver()%>' url='<%= db.jstlUrl()%>' user='<%= db.jstlUser()%>'  password='<%= db.jstlPassword()%>'/>

        <header>
            <!--navbar one-->
            <nav class="navbar navbar-primary navbar-fixed-top" role="navigation">
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
                            </ul>
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                <%= user_.getUserEmail()%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="FarmerDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp?prf_id=<%=db.getUserId(user_email)%>"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </header>
        <%
            int u_id = db.getUserId(user_email);
            //get map coordinates
            double lat = db.getLat(user_email, "farmer");
            double lng = db.getLng(user_email, "farmer");
            String addr = db.getAddr(user_email, "farmer");

            if (u_id == user_id) {
                String email = user_email;
                int postCountUser = db.countPostUser(user_email);
        %>

        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= db.user_Details(email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqPosts">
            <%= db.user_Posts(email)%>
        </sql:query>
        <div class="container" style="">
            <div class="row" >
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
                                    <p><span class="glyphicon glyphicon-map-marker"></span> : Location</p>
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
                    <div class="alert alert-warning mdl-shadow--2dp" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>
                    <div class="panel-body" style="height: 200px;">
                        <div id="map" style="width: 100%;height: 100%;"></div>
                    </div>
                    <div class="panel panel-default" style = "margin-top: 20px;border-radius: 0px;box-shadow: 20px;"> 
                        <ul  id="myTab" class="nav nav-tabs" role="tablist">
                            <li class="active"><a href="#mypost" role="tab" data-toggle="tab">My Post</a></li>
                        </ul>
                    </div>
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="mypost">

                            <%if (postCountUser != 0) {%>
                            <c:forEach var="post" items="${reqPosts.rows}">
                                <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--4dp item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">

                                    <div class="mdl-card mdl-cell mdl-cell--12-col-desktop mdl-cell--9-col-tablet mdl-cell--4-col-phone">
                                        <div class="mdl-card__supporting-text">
                                            <h3><a href="ViewPost.jsp?post_id=${post.post_id}" style="color: #000;">${post.post_title} </a><span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>

                                            <p><c:out value="${post.post_desc}"/> </p>
                                        </div>
                                    </div>
                                </section>
                            </c:forEach>
                            <hr>
                            <%} else {%>
                            <section class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                <p style="margin-left: 50px;margin-top: 40px;">You haven't posted any Epidemic Reports...</p>
                            </section>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%} else {
            String email = db.getUserEmail(user_id);
            int email_frm = db.getUserId(user_email);
            int email_to = user_id;
            int postCountUser = db.countPostUser(email);
            String msg = request.getParameter("msg-content");
            if (msg != null) {
                db.postMsg(email_frm, email_to, msg);
            }
            //get map coordinates
            double lat_ = db.getLat(email, "farmer");
            double lng_ = db.getLng(email, "farmer");
            String addr_ = db.getAddr(email, "farmer");
        %>
        <sql:query dataSource="${bgGet}" var="reqUsers">
            <%= db.user_Details(email)%>
        </sql:query>

        <sql:query dataSource="${bgGet}" var="reqPosts">
            <%= db.user_Posts(email)%>
        </sql:query>
        <div class="container" style="">
            <div class="row" >
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
                                    <p><span class="glyphicon glyphicon-map-marker"></span> : Location</p>
                                    <hr>
                                    <p><span class="glyphicon glyphicon-phone"></span> : ${user.phone}</p>
                                    <p><span class="glyphicon glyphicon-envelope"></span> :${user.email}</p>
                                    <div class="form-group">
                                        <a class="btn btn-success" style="border-radius: 0px; height: 30px;width: 100%;" data-toggle="collapse" data-parent="#accordion" href="#collapseMsg">SEND MESSAGE</a>
                                    </div> 
                                    <div id="collapseMsg" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <form action="profile.jsp?prf_id=<%=user_id%>" method="post">
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
                    <!--check if account is confirmed to view message or not-->
                    <input type="number" class="hidden" value="<%=accStatus%>" id='acc'/>
                    <!--confirmation message-->
                    <div class="alert alert-warning" id="alert_status" >A confirmation email was sent to <strong><%=user_.getUserEmail()%></strong>. Please verify your account!</div>
                    <div class="panel-body" style="height: 200px;">
                        <div id="map" style="width: 100%;height: 100%;"></div>
                    </div>
                    <div class="panel panel-default" style = "margin-top: 20px;border-radius: 0px;box-shadow: 20px;"> 
                        <ul  id="myTab" class="nav nav-tabs" role="tablist">
                            <li class="active"><a href="#mypost" role="tab" data-toggle="tab">My Post</a></li>
                            <li><a href="#mymap" role="tab" data-toggle="tab">Location</a></li>
                        </ul>
                    </div>
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="mypost">

                            <%if (postCountUser != 0) {%>
                            <c:forEach var="post" items="${reqPosts.rows}">
                                <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--4dp item" style="border-top: 1px solid rgba(0, 0, 0, 0.1);">

                                    <div class="mdl-card mdl-cell mdl-cell--12-col-desktop mdl-cell--9-col-tablet mdl-cell--4-col-phone">
                                        <div class="mdl-card__supporting-text">
                                            <h3><a href="ViewPost.jsp?post_id=${post.post_id}" style="color: #000;">${post.post_title} </a><span class="h3_span glyphicon glyphicon-calendar"> <c:out value="${post.post_timestamp}"/></span></h3>

                                            <p><c:out value="${post.post_desc}"/> </p>
                                        </div>
                                    </div>
                                </section>
                            </c:forEach>
                            <hr>
                            <%} else {%>
                            <section class="section--center alert alert-info mdl-grid mdl-grid--no-spacing mdl-shadow--2dp" style="border-top: 1px solid rgba(0, 0, 0, 0.1);height: 100px;">
                                <p style="margin-left: 50px;margin-top: 40px;">You haven't posted any Epidemic Reports...</p>
                            </section>
                            <%}%>
                        </div>
                        <div class="tab-pane fade" id="mymap">
                            <div>
                                <div class="embed-responsive embed-responsive-16by9">

                                </div>
                            </div>         
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
        <!-- Footer -->
        <footer class="navbar-fixed-bottom" style="margin-top: 50px;">
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

        function maxLength(el) {
            if (!('maxLength' in el)) {
                var max = el.attributes.maxLength.value;
                el.onkeypress = function () {
                    if (this.value.length >= max)
                        return false;
                };
            }
        }
        maxLength(document.getElementById("blog-content"));
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
        <script type = "text/javascript" src = "../../assets/js/jquery.js" ></script>
        <script type = "text/javascript" src = "../../assets/js/bootstrap.js" ></script>
    </body>
</html>