###
This is common package config
used in server and in build comand
###

path = require 'path'
root_path = __dirname

get_pack_config = (filename) ->

  switch filename
    when 'printer'
      bundle : 
        main : path.join root_path, "src", filename
    when 'formatter'
      bundle : 
        main : path.join root_path, "src", filename
      replacement :
        util : path.join root_path, "web_modules", "util_shim"
    when 'greater'
      bundle : 
        main : path.join root_path, "src", filename
      replacement :
        fs : path.join root_path, "web_modules", 'noops'
        jade : path.join root_path, "web_modules", 'noops'
    when 'hb_greater'
      bundle : 
        main : path.join root_path, "src", filename

    else
      throw Error "dont know |#{filename}| settings"

module.exports = {
  get_pack_config
}