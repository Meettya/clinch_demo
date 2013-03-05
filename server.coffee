###
This is developer server
###

stylus      = require 'stylus'
express     = require 'express'
path        = require 'path'
fs          = require 'fs'
util        = require 'util'
livereload  = require 'livereload2'
Clinch      = require 'clinch'

{get_pack_config} = require './pack_configurator'

packer = new Clinch()

###
This is error handlers
###

logErrors = (err, req, res, next) ->
  console.error err.stack
  next err

clientErrorHandler = (err, req, res, next) ->
  if req.xhr
    res.send 500, error: err
  else
    next err

errorHandler = (err, req, res, next) ->
  res.status 500
  res.render 'error',  error: err 

###
This function create developer server to work with project or docs
###
dev_server = (bundle_name, root_path, done) ->

  port = process.env.PORT or 3000

  app = express()
  app.locals.pretty = true

  app.configure ->
    app.set 'views', path.join root_path, 'develop_suite/views'
    app.set 'view engine', 'jade'

    # its for stylus pre-compiller
    app.use stylus.middleware 
      src     : path.join root_path, 'develop_suite/public'
      force   : true

    app.use express.favicon()

    app.use express.static path.join root_path, 'develop_suite/public'
    
    app.use logErrors
    app.use clientErrorHandler
    app.use errorHandler

  # static page
  app.get '/', (req, res) -> res.redirect 301, '/index.html'

  # this is our jade files
  app.get '/:html_name', (req,res) ->
    [filename, ext] = req.param('html_name').split '.'
    res.render filename

  # our widgets
  app.get "/js/:js_name", (req, res, next) ->
    [filename, ext] = req.param('js_name').split '.'

    pack_config = get_pack_config filename
    
    packer.buldPackage bundle_name, pack_config, (err, data) ->
      if err
        next err
      else
        res.type 'application/json'
        res.send data

  # live reload suport
  livereload_server = livereload.createServer exts: ['less', 'jade']
  livereload_server.watch path.join root_path, 'develop_suite'

  console.log "Starting server on port: #{port}"
  app.listen(port).on('close', done)

module.exports = {
  dev_server
}

