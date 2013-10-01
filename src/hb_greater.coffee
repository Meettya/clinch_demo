###
This is simple test case for Handlebars-powered template engine
must work in browser only
###

###
This function render results with Handlebars template and given data
###
greater = (data) ->

  template_fn = require './tmpl/hb_template'
  # add it to Handlebars mmm... stack?
  template = Handlebars.template template_fn
  # profit!
  res = template data

###
This is from hb example
###
example1 = (data) ->
  template_fn = require './tmpl/hb_example1'
  template = Handlebars.template template_fn
  res = template data

###
This is from hb example
###
example2 = (data) ->

  Handlebars.registerHelper 'link_to', (context) ->
    "<a href='#{context.url}'>#{context.body}</a>"

  template_fn = require './tmpl/hb_example2'
  template = Handlebars.template template_fn
  res = template data

###
This is from hb example
###
example3 = (data) ->

  Handlebars.registerHelper 'link', (options) ->
    "<a href='/people/#{@id}'>#{options.fn @}</a>"

  template_fn = require './tmpl/hb_example3'
  template = Handlebars.template template_fn
  res = template data

###
This is from hb example
###
example4 = (data) ->

  Handlebars.registerHelper 'agree_button', ->
    new Handlebars.SafeString "<button>I agree. I #{@emotion} #{@name}</button>"

  template_fn = require './tmpl/hb_example4'
  template = Handlebars.template template_fn
  res = template data

module.exports = {
  greater, example1, example2, example3, example4
}