###
This simple demo how clinch may be used 
for gateher nodejs-like application for browser
###

{vsprintf} = require 'sprintf-js'

printer = (format, args...) ->

  vsprintf format, args

module.exports = {
  printer
}