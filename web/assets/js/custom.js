/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

(function ($) {
    $(document).ready(function () {
        $(".paginate").customPaginate({
            itemsToPaginate: ".item"
        });
        $(".paginate2").customPaginate({
            itemsToPaginate: ".item2"
        });
    });
}(jQuery));
