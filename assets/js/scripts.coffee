
$ ->
  # Only show certain # of posts on home; 
  # Hide the rest until needed.
  if $('.card-post').length > 0
    postsToShow = 2
    $posts =  $('.card-post')
    $hiddenPostsContainer = $('.hidden-posts')

    $posts.each (index, element) ->
      if index >= postsToShow
        $(element).appendTo($hiddenPostsContainer)

  $(document).on 'click', '.show-more-posts', (e) ->
    postsToReveal = 3
    $hiddenPostsContainer = $('.hidden-posts')
    $visiblePostsContainer = $('.visible-posts')

    $hiddenPostsContainer.find('.card-post').each (index, element) ->
      if index < postsToReveal
        $(element).appendTo($visiblePostsContainer)
        $('.show-more-posts').hide() if $hiddenPostsContainer.find('.card-post').length == 0
    e.preventDefault()

  $(document).on 'click', "a.scrollable-anchor", (e) ->
    if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
      target = $(@hash)
      target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
      if target.length
        $("html,body").animate
          scrollTop: target.offset().top
        , 800, "materialEase"
        false

  $(document).on 'click', '.card-post', (e) ->
    link = $(@).find("a").first().attr('href')
    window.location = link  



$.easing.jswing = $.easing.swing
$.extend $.easing,
  def: "easeOutQuad"
  materialEase: (x, t, b, c, d) ->
    return c / 2 * t * t + b  if (t /= d / 2) < 1
    -c / 2 * ((--t) * (t - 2) - 1) + b  
