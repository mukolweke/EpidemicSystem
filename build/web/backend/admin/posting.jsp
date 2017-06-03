<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Dashboard</title>
        <!--css links-->
        <link href="../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="../../assets/css/main.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../../assets/img/favicon.png" type="image/x-icon">
    </head>
    <body>
        <header>
            <div class="navbar navbar-default navbar-fixed-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Farmers Epidemic System</a>
                    </div>

                </div>
            </div>
            <div class="nav-two">
                <div class="container">
                    <ul class="nav nav-tabs" role="tablist" id="myTab">
                        <!--<ul class="list-unstyled list-inline center-block" id="myTab">-->
                        <li class="active">
                            <a href="#main-page" role="tab" data-toggle="tab">
                                Admin Dashboard
                            </a>
                        </li>
                        <!--<li class="list-sep"></li>-->                        
                        <li>
                            <a href="#expert-page" role="tab" data-toggle="tab">
                                Manage Experts
                            </a>
                        </li>
                        <!--<li class="list-sep"></li>-->                        
                        <li>
                            <a href="#farmer-page" role="tab" data-toggle="tab">
                                Manage Farmers
                            </a>
                        </li> 
                        <!--<li class="list-sep"></li>-->                        
                        <li>
                            <a href="#notification" role="tab" data-toggle="tab">
                                Notifications
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </header>
        <div class="tab-content hidden">
            <div class="tab-pane fade in active" id="main-page">
                <div class="container">
                    <%@include  file="backend/main-page.jsp" %>
                </div><!-- /.container -->
            </div>
            <div id="expert-page" class="tab-pane fade">
                <div class="container">
                    <%@include  file="backend/expert-page.jsp" %>
                </div><!-- /.container -->
            </div>
            <div id="farmer-page" class="tab-pane fade">
                <div class="container">
                    <%@include  file="backend/farmer-page.jsp" %>
                </div><!-- /.container -->
            </div>
            <div id="notification" class="tab-pane fade">
                <div class="container">
                    <h3>NotificATION</h3>
                </div><!-- /.container -->
            </div>
        </div>
        <div class="footer">


        </div><!-- /.footer -->

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript">
            $(function () {
                $('#myTab a:last').tab('show')
            })
        </script>
        <script src="addons/jquery.min.js" type="text/javascript"></script>
        <script src="addons/bootstrap.min.js" type="text/javascript"></script>

    </body>
</html>

