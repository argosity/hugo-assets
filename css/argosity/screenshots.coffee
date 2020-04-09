SLIDES = []

onClick = (ev, el, index) ->
    ev.preventDefault()


    options = { index }


    gallery = new PhotoSwipe( document.querySelector('.pswp'),
        PhotoSwipeUI_Default,
        SLIDES,
        options
    )

    gallery.init()

addSlide = (el, i) ->
    el.addEventListener 'click', (ev) -> onClick(ev, el, i)
    [h, w] = el.getAttribute('data-size').split('x')
    SLIDES.push({
        msrc: el.querySelector('img').src
        src: el.getAttribute('data-med')
        h: h
        w: w
        title: 'Image Caption'
    })

document.addEventListener "DOMContentLoaded", ->

    for el, i in document.querySelectorAll('.screenshots > a')
        addSlide(el, i)
