$(function(){
  $('.tab').on('click',function(e){
    $('.tab_active').removeClass('tab_active');
    $(this).addClass('tab_active');
    $('.box_show').removeClass('box_show');
    const index = $(this).index();
    $('.tabbox').eq(index).addClass('box_show');
  });
});