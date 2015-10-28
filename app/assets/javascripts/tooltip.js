$( document ).ready(function() {
  $('.like, .trash, .star, .comment').poshytip({
    className: 'tip-darkgray',
    showTimeout: 1,
    alignTo: 'target',
    alignX: 'center',
    offsetY: 5,
    offsetX: -7,
    allowTipHover: false,
    fade: false,
    slide: false
  });
});