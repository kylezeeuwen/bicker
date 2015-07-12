'use strict'

unless process.argv.length == 3
  console.log process.argv
  console.log 'Usage coffee examples/server.coffee <TARGET>'
  process.exit 1

target = process.argv[2]

express = require 'express'
app = express()
app.use '/dist', express.static 'dist'
app.use '/bower', express.static 'bower_components'
app.use '/', express.static "examples/#{target}"

#@TODO this must be configurable per app
#add index to list
for route in ['/pageLayout1', '/pageLayout2']
  app.get route, (req, res) ->
    res.sendfile 'examples/simple/index.html'

port = process.env.PORT or 9000
server = app.listen port, ->
  console.log "Express server listening on port #{port}"
  return