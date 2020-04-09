window.Argosity ||= {}

DEFAULT_DURATION = 750 # milliseconds

EASE_IN_OUT = (t) ->
    if t < .5 then 4 * t * t * t else (t - 1) * (2 * t - 2) * (2 * t - 2) + 1

POSITION = (start, end, elapsed, duration) ->
    if (elapsed > duration)
        end
    else
        start + (end - start) * EASE_IN_OUT(elapsed / duration)


class window.Argosity.ScrollLink

    constructor: (@link, @destination, @options = {}) ->
        unless @destination instanceof Element
            @destination = document.querySelector(@destination)
        unless @link instanceof Element
            @link = document.querySelector(@link)
        if @link and @destination
            @link.addEventListener 'click', => @scrollToElement()
        else
            console?.warn "failed to setup link", @link, @destination

    scrollToElement: ->
        @constructor.scroll(@destination, @options.duration or DEFAULT_DURATION)

    @scroll: (destination, duration = DEFAULT_DURATION) ->
        unless destination instanceof Element
            destination = document.querySelector(destination)

        unless destination
            console?.warn "failed to scroll to", destination
            return false

        startPos  = window.pageYOffset

        endPos    =
            destination.getBoundingClientRect().top -
                document.body.getBoundingClientRect().top

        startTime = Date.now()

        step = ->
            elapsed = Date.now() - startTime
            window.scroll(0, POSITION(startPos, endPos, elapsed, duration) )
            window.requestAnimationFrame(step) if elapsed < duration
        step()
