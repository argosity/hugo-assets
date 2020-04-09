window.Argosity ||= {}

FAILURE_MSG = '''
<p>
    The message failed to send.
</p><p>
    Please contact us via phone or email directly
</p>
'''

SUCCESS_MSG = '''
<p>
    Message was delivered successfully
</p>
'''

class window.Argosity.ContactForm

    constructor: (options = {}) ->
        {container, link, url} = options
        @url = url or 'https://contact.argosity.com/message.json'
        @containerSelector = container
        @container = document.querySelector(container)
        @bindElements() if @container
        @options = options
        if link
            new Argosity.ScrollLink(
                link, @containerSelector
            )

    bindElements: ->
        @form = @container.querySelector("form")
        @form.addEventListener 'submit', (ev) => @onSubmit(ev)
        @msgStatus = document.querySelector("#{@containerSelector} .message-status")
        @msgStatus.style.display = 'none'

    showFail: (msg) ->
        @msgStatus.classList?.add('alert-danger')
        @msgStatus.innerHTML = msg || FAILURE_MSG

    onSubmitComplete: (xhr) ->
        @container.classList.remove('sending')
        if (xhr.status >= 200 && xhr.status < 300 || xhr.status == 304)
            msg = JSON.parse(xhr.responseText)
            if msg.success
                @msgStatus.classList?.add('alert-success')
                @msgStatus.innerHTML = @options.successMessage or SUCCESS_MSG
            else
                @showFail(msg.message)
        else
            @showFail()
        @msgStatus.style.display = 'block'

    onSubmit: (ev) ->
        ev.preventDefault()
        @container.classList.add('sending')
        data = {}
        form = ev.target
        for el in form.elements
            data[el.name] = el.value

        xhr = new XMLHttpRequest
        xhr.open('POST', @url)
        xhr.onreadystatechange = =>
            @onSubmitComplete(xhr) if xhr.readyState is 4
        xhr.send(JSON.stringify(data))
