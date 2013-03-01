###
This is command library

to wipe out Gruntfile from realization 
###

path          = require 'path'
fs            = require 'fs-extra'
{spawn, exec} = require 'child_process'

{ncp}   = require 'ncp'
ncp.limit = 16

Clinch      = require 'clinch'
packer = new Clinch()

_ = require 'lodash'

###
Just proc extender
###
proc_extender = (proc, cb) =>
  proc.stderr.on 'data', (buffer) -> console.log "#{buffer}"
  proc.on        'exit', (status) ->
    process.exit(1) if status != 0
    cb() if typeof cb is 'function' 
  null

# Run jade compiler
run_jade = (args, cb) =>
  proc_extender spawn('node', ['./node_modules/.bin/jade'].concat(args)), cb

###
Generate array of files from directory, selected on filter as RegExp
###
make_files_list = (in_dir, filter_re) ->
  for file in fs.readdirSync in_dir when file.match filter_re
    path.join in_dir, file 

get_pack_config = (root_path, filename) ->

  switch filename
    when 'printer'
      bundle : 
        main : path.join root_path, "src", filename
    when 'formatter'
      bundle : 
        main : path.join root_path, "src", filename
      replacement :
        util : path.join root_path, "web_modules", "util_shim"

    else
      throw Error "dont know #{filename} settings"

compile_jade = (source_dir, result_dir, cb) ->
  files = make_files_list source_dir, /\.jade$/
  run_jade ['--pretty', '--no-debug', '--out', result_dir].concat(files), ->
    console.log ' -> build test html for browser done'
    cb() if typeof cb is 'function'

copy = (source_dir, result_dir, cb) ->
  ncp source_dir, result_dir, (err) ->
    throw err if err?
    console.log 'copy done!'
    cb() if typeof cb is 'function'

compile_src = (bundle_name, root_path, result_dir, cb) ->

  source_dir = path.join root_path, 'src'
  files = make_files_list source_dir, /\.coffee$/

  all_done = _.after files.length, cb

  for file in files
    do (file) ->
      filename = path.basename file, '.coffee'

      pack_config = get_pack_config root_path, filename

      packer.buldPackage bundle_name, pack_config, (err, data) ->
        throw err if err?
        fs.outputFile "#{path.join result_dir, filename}.js", data, encoding='utf8', (err) ->
          throw err if err?
          console.log "Compiled #{filename}.js"
          all_done


module.exports = {
  compile_jade,
  copy,
  compile_src
}
