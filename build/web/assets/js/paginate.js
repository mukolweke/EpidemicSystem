/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


(function ($) {

    $.fn.customPaginate = function (options)
    {
        var paginationContainer = this;
        var itemsToPaginate;

        var defaults = {
            itemsPerPage : 3
        };

        var settings = {};

        $.extend(settings, defaults, options);

        var itemsPerPage = settings.itemsPerPage;

        itemsToPaginate = $(settings.itemsToPaginate);
        var numOfLinks = Math.ceil((itemsToPaginate.length / itemsPerPage));

        $("<ul></ul>").prependTo(paginationContainer);

        for (var index = 0; index < numOfLinks; index++) {
            paginationContainer.find("ul").append("<li>" + (index + 1) + "</li>");
        }
// hide all except the default value
        itemsToPaginate.filter(":gt(" + (itemsPerPage - 1) + ")").hide();
        
        paginationContainer.find("ul li").on('click',function(){
            var linkNum = $(this).text();
            
            var itemsToHide = itemsToPaginate.filter(":lt("+((linkNum - 1) * itemsPerPage)+")");
            $.merge(itemsToHide,itemsToPaginate.filter(":gt("+((linkNum * itemsPerPage))+")"));
            itemsToHide.hide();
            
            var itemsToShow = itemsToPaginate.not(itemsToHide);
            itemsToShow.show();
            
        });
    };
}(jQuery));