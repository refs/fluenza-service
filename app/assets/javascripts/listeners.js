$(document).ready(function() {
  $(".select-2-el").select2({multiple: true})
});

setListeners = function() {
  $(".users_path_redirect").click(function() {
    window.location = "/users"
  });

  $(".accounts_path_redirect").click(function() {
    window.location = "/accounts"
  });

  $(".influencers_path_redirect").click(function() {
    window.location = "/influencers"
  });

  $(".categories_path_redirect").click(function() {
    window.location = "/youtube_categories"
  });

  $(".admin_path_redirect").click(function() {
    window.location = "/admin"
  });

  $(".profile_path_redirect").click(function() {
    window.location = "/profile"
  });
}
