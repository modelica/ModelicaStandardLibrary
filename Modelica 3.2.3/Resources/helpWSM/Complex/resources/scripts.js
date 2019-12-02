$(document).ready(function() {
    $('section > h1').click(function() {
        $(this).parent().toggleClass('closed');
    })
});