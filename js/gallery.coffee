##= require '../../vendor/photoswipe'
##= require '../../vendor/photoswipe-ui-default'


window.Argosity ||= {}

class window.Argosity.Gallery

    constructor: (selector = '.gallery > a', @options = {}) ->
        @slides = []
        for el, i in document.querySelectorAll(selector)
            @addSlide(el, i)

    onClick: (ev, el, index) ->
        ev.preventDefault()
        options = { index }
        for k, v of @options
            options[k] = v
        gallery = new PhotoSwipe( document.querySelector('.pswp'),
            PhotoSwipeUI_Default, @slides, options
        )
        gallery.init()

    addSlide: (el, i) ->
        el.addEventListener 'click', (ev) => @onClick(ev, el, i)
        @slides.push({
            msrc: el.querySelector('img').src
            src: el.getAttribute('href')
            title: el.querySelector('figure').textContent
            h: el.getAttribute('data-height')
            w: el.getAttribute('data-width')
        })
