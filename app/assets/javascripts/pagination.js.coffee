jQuery ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_movies_url = $('.pagination .next_page a').attr('href')
      if more_movies_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
          $.getScript more_movies_url
      return
    return

  if $('#with-button').size() > 0
      $('.pagination').hide()
      loading_movies = false

      $('#load_more_movies').show().click ->
        unless loading_movies
          loading_movies = true
          more_movies_url = $('.pagination .next_page a').attr('href')
          $this = $(this)
          $this.html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />').addClass('disabled')
          $.getScript more_movies_url, ->
            $this.text('More movies').removeClass('disabled') if $this
            loading_movies = false
        return
