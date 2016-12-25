$(document).on('turbolinks:load',function() {
  $('.more-comments').click( function() {
    $(this).on('ajax:success', function(event, data, status, xhr) {
      var postId = $(this).data("post-id");
      $("#comments_" + postId).html(data);
      $("#comments-paginator-" + postId).html("<a id='morecomments' data-post-id=" + postId + "data-type='html' dataremote='true' href='/posts/" + postId + "/comments>show more comments</a>");
    });
  });
});
