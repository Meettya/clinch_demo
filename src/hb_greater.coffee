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

module.exports = {
  greater
}