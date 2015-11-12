//Permet d'attribuer la même taille aux deux blocs du footer
$( document ).ready(function() {

  
    var carouselId = $('#carouselContener').children()[0].getAttribute('id');
  if ($(window).width() < 991){
  	$('#actu').height(parseInt($('#'+carouselId).height())+parseInt($('#'+carouselId).css('padding-bottom'))+14);
  }
  $("#"+carouselId).on('slid.bs.carousel', function () {
    if ($(window).width() < 991)
      $('#actu').height(parseInt($('#'+carouselId).height())+parseInt($('#'+carouselId).css('padding-bottom')));

});
  $(window).resize(function(){
    $('#actu').height(parseInt($('#'+carouselId).height())+parseInt($('#'+carouselId).css('padding-bottom')));
  });
});