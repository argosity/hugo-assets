##= require './scroll-link'
##= require './contact-form'
##= require_self

window.Argosity ||= {}


class window.Argosity.Jekyll

    constructor: (options = {}) ->
        {contact} = options

        document.addEventListener 'DOMContentLoaded', =>
            if contact
                @form = new Argosity.ContactForm(contact)
