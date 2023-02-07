import jquery from "jquery"
window.$ = jquery
$(function(){
  $('.tab').on('click',function(e){
    $('.tab-active').removeClass('tab-active');
    $(this).addClass('tab-active');
    $('.box-show').removeClass('box-show');
    const index = $(this).index();
    $('.tabbox').eq(index).addClass('box-show');
  });
});