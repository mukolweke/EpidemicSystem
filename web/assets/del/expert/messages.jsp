<%-- 
    Document   : messages
    Created on : Apr 14, 2017, 9:58:40 PM
    Author     : Michael Mukolwe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &CenterDot; MESSAGES DASH</title>
        <!--css links-->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body style="background-color: #f9f9f9;font-family:'Oxygen-Regular';">
        <%@page import="sys.classes.*,sys.servlets.*" %>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("../Login.jsp");
            }
        %>
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
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <div class="dropdown navbar-right">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                Farmer Action
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu " role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation" class="text-center"><p>Signed in as <bold>username</bold></p></li>
                                <li role="presentation" class="divider"></li>   
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="ExpertDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </header>
        <div class="container" style="">
            <div class="row" >
                <div class="col-md-2 clearfix"></div>
                <div class="col-md-8">
                    <div class="panel" style="margin-top: 50px;background-color: #f9f9f9;">
                        <div class="panel-heading" style="background-color: transparent;">
                            <h2 class="panel-title" style="font-size: 20px;">Messages Unread :</h2>
                        </div>
                        <div class="panel-body" style="margin-left: 5px;">
                            <div class="row">
                                <div class="media">
                                    <a class="pull-left" href="#">
                                        <img class="media-object well well-sm" src="..." alt="epidemic photo" style="width: 80px;height: 100px;margin-right: 20px;">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">New Blog Post Name</h4>
                                        <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel
                                            metus scelerisque ante sollicitudin commodo. Cras purus odio, 
                                            vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum
                                            nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus. 
                                            <a href="#">Read </a></p>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="media">
                                    <a class="pull-left" href="#">
                                        <img class="media-object well well-sm" src="..." alt="epidemic photo" style="width: 80px;height: 100px;margin-right: 20px;">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">New Reply Name</h4>
                                        <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel
                                            metus scelerisque ante sollicitudin commodo. Cras purus odio, 
                                            vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum
                                            nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus. 
                                            <a href="#">Read</a></p>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="media">
                                    <a class="pull-left" href="#">
                                        <img class="media-object well well-sm" src="..." alt="epidemic photo" style="width: 80px;height: 100px;margin-right: 20px;">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">Message From: Expert/Farmer Name</h4>
                                        <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel
                                            metus scelerisque ante sollicitudin commodo. Cras purus odio, 
                                            vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum
                                            nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus. 
                                            <a href="#">Read</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 clearfix"></div>
            </div>
        </div>


        <!-- Footer -->
        <footer class="navbar-fixed-bottom">
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>

        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript">
            $(function () {
                $('#myTab a:last').tab('show')
            });
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
        </script>
        <script type="text/javascript" src="../../assets/js/jquery.js"></script>
        <script type="text/javascript" src="../../assets/js/bootstrap.js"></script>
    </body>
</html>