###
This is Grunt file for project
###
path    = require 'path'

{dev_server}  = require './server'
commands      = require './commands'

root_path = __dirname

browser_source_dir = path.join root_path, 'develop_suite'
browser_result_dir = path.join root_path, 'browser'

module.exports = (grunt) ->

  grunt.registerTask 'browser', ['jade', 'browser_copy', 'compile_src']

  grunt.registerTask 'compile_src', 'Compile all files from src for browser.', ->
    done = @async()
    dest_dir  = path.join browser_result_dir, 'js'
    commands.compile_src 'clinch_demo', root_path, dest_dir, done

  grunt.registerTask 'browser_copy', 'Copy all staff for browser.', ->
    done = @async()
    source_dir = path.join browser_source_dir, 'public'
    commands.copy source_dir, browser_result_dir, done


  grunt.registerTask 'jade', 'Compile jade to html.', ->
    done = @async()
    source_dir = path.join browser_source_dir, 'views'
    commands.compile_jade source_dir, browser_result_dir, done


  grunt.registerTask 'gh-pages', 'Update gh-pages branch with static docs.', ->
    done = @async()
    # for online gh-pages docs
    gh_pages_branch = 'refs/heads/gh-pages'
    orgin_doc_dir   = 'browser'
    commands.update_gh_pages orgin_doc_dir, gh_pages_branch, done

  grunt.registerTask 'server', 'Start a develop server.', ->
    done = @async()
    dev_server 'clinch_demo', root_path, done

 