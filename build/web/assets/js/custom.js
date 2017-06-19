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

function checkLength() {
    //password length
    if ((document.getElementById('user-password').value).length < 6) {
        document.getElementById('help2').innerHTML = "Short Password Character";
    } else {
        document.getElementById('help2').innerHTML = "";
    }
}
function checkMatch(inputPass) {
    // pass dont match error
    if (inputPass.value !== document.getElementById('user-password').value) {
        document.getElementById('help2').innerHTML = "Password Don't Match";
    } else {
        //valid match
        document.getElementById('help2').innerHTML = "";
    }
}

function initAutocomplete() {
    var autocomplete = new google.maps.places.Autocomplete(document.getElementById('user-search'));
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        var place = autocomplete.getPlace();
        document.getElementById("lat").value = place.geometry.location.lat();
        document.getElementById("lng").value = place.geometry.location.lng();
    });
}
;
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                    .attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}
