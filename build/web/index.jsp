<%-- 
    Document   : index
    Created on : Apr 6, 2017, 2:52:14 PM
    Author     : Michael Mukolwe
--%>

<%@page import="sys.classes.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FEWS &centerdot; Index Page</title>

        <!--css links-->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="assets/img/favicon.png" type="image/x-icon">

        <!--javascript mapwork-->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAdFsAprSk3Bpi5i59sD3KtMEs_Jp_V4z4&libraries=places&callback=initAutocomplete" async defer></script>

    </head>
    <body>
        <%
            DB_class DB = new DB_class();
            Login_class user = (Login_class) session.getAttribute("user");
            if (user == null) {
                user = new Login_class();
            }
        %>
        <sql:setDataSource var='bgGet' driver='<%= DB.jstlDriver()%>' url='<%= DB.jstlUrl()%>' user='<%= DB.jstlUser()%>'  password='<%= DB.jstlPassword()%>'/>

        <sql:query dataSource="${bgGet}" var="reqCoordsF">
            <%= DB.coordsF()%>
        </sql:query>
        
        <sql:query dataSource="${bgGet}" var="reqCoordsE">
            <%= DB.coordsE()%>
        </sql:query>
        <script type="text/javascript">
//            farmer location details
            function initAutocomplete() {
                var locationFarmer = [
            <c:forEach items="${reqCoordsF.rows}" var="coordsF" varStatus="status">
                    ['${coordsF.addr}',${coordsF.lat},${coordsF.lng}]
                <c:if test="${!status.last}">
                    ,
                </c:if>
            </c:forEach>
                ];
//                expert location details
                var locationExpert = [
            <c:forEach items="${reqCoordsE.rows}" var="coordsE" varStatus="status">
                    ['${coordsE.addr}',${coordsE.lat},${coordsE.lng}]
                <c:if test="${!status.last}">
                    ,
                </c:if>
            </c:forEach>
                ];
                
                var map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: -0.3031, lng: 36.08},
                    zoom: 6,
                    mapTypeId: 'satellite'
                });

                var contentString = "Hi You!!!";
                var infowindow = new google.maps.InfoWindow({
                    content: contentString
                });
                var i;
                //farmer
                for (i = 0; i < locationFarmer.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(locationFarmer[i][1], locationFarmer[i][2]),
                        label: "F",
                        draggable: true,
                        map: map
                    });
                    google.maps.event.addListener(marker, 'click', (function (marker, i) {
                        return function () {
                            infowindow.setContent(locationFarmer[i][0] + ", Farmer");
                            infowindow.open(map, marker);
                        };
                    })(marker, i));
                }
                //expert
                for (i = 0; i < locationExpert.length; i++) {
                    marker2 = new google.maps.Marker({
                        position: new google.maps.LatLng(locationExpert[i][1], locationExpert[i][2]),
                        label: "E",
                        draggable: true,
                        map: map
                    });
                    google.maps.event.addListener(marker2, 'click', (function (marker, i) {
                        return function () {
                            infowindow.setContent(locationExpert[i][0] + ", Expert");
                            infowindow.open(map, marker);
                        };
                    })(marker2, i));
                }
                marker.addListener('click', function () {
                    infowindow.open(map, marker);
                });
                marker2.addListener('click', function () {
                    infowindow.open(map, marker2);
                });
            }
        </script>

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
                    <a class="navbar-brand" href="index.jsp"><span style="color:#5cb85c;">FEWS</span> LOGO</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a class="page-scroll" href="backend/Search.jsp">SEARCH EPIDEMICS</a>
                        </li>
                        <li class="hidden">
                            <a href="#page-top"></a>
                        </li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <%
                            if (request.getSession().getAttribute("user") == null) {
                        %>

                        <ul class="nav navbar-nav ">
                            <li><a href="backend/SignUp.jsp"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px;"></span>FARMER SIGN UP</a></li>
                            <li><a href="backend/Login.jsp"><span class="glyphicon glyphicon-log-in" style="margin-right: 5px;"></span> LOGIN</a></li>
                        </ul>
                        <%
                        } else {
                            if (DB.getAuthKey(user.getUserEmail().toString()) == 1) {
                        %>

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
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/admin/AdminDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/admin/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/admin/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/admin/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                        } else if (DB.getAuthKey(user.getUserEmail().toString()) == 2) {
                        %>
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
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/expert/ExpertDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/expert/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/expert/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/expert/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                        } else if (DB.getAuthKey(user.getUserEmail().toString()) == 3) {
                        %>
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
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/farmer/FarmerDash.jsp"><span class="glyphicon glyphicon-dashboard" style="margin-right: 20px;"></span>DASHBOARD</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/farmer/profile.jsp"><span class="glyphicon glyphicon-user" style="margin-right:  20px;"></span>PROFILE</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/farmer/messages.jsp"><span class="glyphicon glyphicon-envelope" style="margin-right: 20px;"></span>MESSAGES</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="backend/farmer/Logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 20px;"></span> LOGOUT</a></li>
                            </ul>
                        </div>
                        <%
                                }
                            }
                        %>
                    </ul>

                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <div class="main-section">
            <!-- Swiper -->
            <div class="swiper-container" style="min-height: 450px;color: black;">
                <div class="swiper-wrapper" style="">
                    <div class="swiper-slide" style="background: url('assets/img/jumbo/farmers-jumbotron.jpg');background-repeat: no-repeat;min-height: 450px;">
                        <div class="title">Welcome Farmer</div>
                        <div class="text" >
                            <p>Farmers get to connect with other farmers in same area at once with 
                                a broadcast warning on signs of disease or epidemic affecting their crops.Get advice from experts or
                                other farmers on what to do...</p>
                        </div>
                    </div>
                    <div class="swiper-slide" style="background: url('assets/img/jumbo/farmerexpert-Jumbotron.jpg');background-repeat: no-repeat;min-height: 450px;" >
                        <div class="title" >Welcome Expert</div>
                        <div class="text">
                            <p>Experts of Organization are able to reach Organization farmers at large once and 
                                help them by giving them advice on what to do in certain situation that arise;also write
                                about past epidemics that may arise and tell farmers on ways to help them...</p>
                        </div>
                    </div>
                    <div class="swiper-slide" style="background: url('assets/img/jumbo/mobileNotification-jumbotron.jpg');background-repeat: no-repeat;min-height: 450px;">
                        <div class="title" >Get SMS Notification</div>
                        <div class="text" >
                            <p>The farmers and experts will get epidemic alerts in form of messages telling
                                them of reports made in their area about certain epidemics they need to watch out for.
                                Also get alerts if their posted epidemic has been replied to by any expert or farmer...</p>
                        </div>
                    </div>
                    <div class="swiper-slide" style="background: url('assets/img/jumbo/maplocation-jumbotron.jpg');background-repeat: no-repeat;min-height: 450px;">
                        <div class="title" style="">Mapping User Location</div>
                        <div class="text" >
                            <p>The web-system shall be able to get user location information
                                (with consent) and map it to our database for reference. Helps the 
                                system to know areas affected so as to help experts determine the 
                                epidemic spread pattern, origin etc....</p>
                        </div>
                    </div>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <!-- Add Navigation -->
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>

            <!--end jumbotron-->

            <!--service-->
            <div class="services" id=services" style="margin-top: 30px;">
                <div class="service-top">
                    <h3>Current Users</h3>
                </div>
                <div style="margin-top:20px;width: 100%;height: 400px;">
                    <div id="map" style="height: 100%;width: 100%;"></div>
                </div>
                <div class="container">
                    <div class="services-grid">
                        <div class="row"></div>
                    </div>
                    <div class="service-top">
                        <h3>How It Works</h3>
                    </div>
                    <div class="services-grid">
                        <div class="row">
                            <div class="col-md-5 service-top1" >
                                <div  class="ser-top-right ser-top">
                                    <h4>Farmers</h4>
                                    <h5 style="">Create an account</h5>
                                    <p class="help-block">
                                        Farmers will be able to create an account
                                        ,then login to access system resources.
                                    </p>
                                    <h5 style="">Report an epidemic</h5>
                                    <p class="help-block">
                                        Farmers make a report of epidemic they are
                                        affected with; giving full description so that they may be helped.
                                    </p>
                                    <h5 style="">Get a sms Notification</h5>
                                    <p>
                                        Farmers will get direct SMS notification of new Epidemic reports or Solutions to those they posted. 
                                    </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                            <div class="col-md-1 service-top1" style="margin-top: 50px;">	
                                <img src="assets/img/steps-124c13915525542046e583ab8f0dd1bc.png" alt="" style="margin-left:20px;"/>
                            </div>
                            <div class="col-md-6 service-top1" style="padding-left: 20px;">
                                <div  class="ser-top-left ser-top">
                                    <h4>Farming Experts</h4>
                                    <h5 style="">Obtain an account</h5>
                                    <p class="help-block">
                                        Experts will get an account from Admin; be able to access their
                                        account with the credential they are given.
                                    </p>
                                    <h5 style="">Reply to an epidemic</h5>
                                    <p class="help-block">
                                        Experts will receive notification of epidemics / problems
                                        the farmers have posted and reply to them.
                                    </p>
                                    <h5 style="">Write Epidemic Blog Post</h5>
                                    <p>
                                        Experts shall be able to write about Epidemics they have encountered and solutions
                                        the farmers may want to use to protect their produce.
                                    </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <footer>
            <div class="container text-center">
                <p><a href="#">Copyright &copy; kukuSoft.co.ke 2017</a></p>
                <p>Terms of Services Applied</p>
            </div>
        </footer>    
        <script type="text/javascript" src="assets/js/jquery.js"></script>
        <script type="text/javascript" src="assets/js/swiper.jquery.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.js"></script>
        <!-- Initialize Swiper -->


        <script>
            var swiper = new Swiper('.swiper-container', {
                pagination: '.swiper-pagination',
                paginationClickable: true,
                nextButton: '.swiper-button-next',
                prevButton: '.swiper-button-prev',
                loop: true,
                grabCursor: true,
                autoplay: 5000,
                autoplayDisableOnInteraction: false

            });

        </script>
    </body>
</html>
