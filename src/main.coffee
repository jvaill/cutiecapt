url = require('url')
fs = require('fs')
childProcess = require('child_process')

DEFAULT_OPTIONS =
  java: true
  plugins: true
  privateBrowsing: false
  jsCanOpenWindows: false
  jsCanAccessClipboard: false

SUPPORTED_EXTENSIONS = [
  'svg', 'ps', 'pdf', 'itext', 'html', 'rtree', 'png',
  'jpeg', 'mng', 'tiff', 'gif', 'bmp', 'ppm', 'xbm', 'xpm'
]

# transforms keys (e.g. jsCanOpenWindows) into the format
# CutyCapt expects on the command line (e.g. --js-can-open-windows)
transformArguments = (options = {}) ->
  # merge default options
  for key, value of DEFAULT_OPTIONS
    options[key] = value unless key of options
  
  # transform
  for key, value of options
    # key (ex: 'jsCanOpenWindows' becomes '--js-can-open-windows')
    cmdKey = '--' + key.replace(/[A-Z]/g, (char) -> "-#{char.toLowerCase()}")
    # value (true becomes 'on' and false becomes 'off')
    cmdValue =
      if value is true then 'on'
      else if value is false then 'off'
      else value.toString()
    
    delete options[key]
    options[cmdKey] = cmdValue
  
  options

flattenArguments = (args) ->
  flattened = []
  for key, value of args
    flattened.push "#{key}=#{value}"
  flattened

spawnCutyCapt = (path, site, out, options = {}, cb) ->
  throw new Error('path must be set') unless path
  throw new Error('site must be set') unless site
  throw new Error('out must be set') unless out
  
  if arguments.length == 4 and typeof options is 'function'
    cb = options
    options = {}
  
  [options.url, options.out] = [site, out]
  options = transformArguments(options)
  options = flattenArguments(options)
  
  cutyCapt = childProcess.spawn(path, options)
  cutyCapt.on 'exit', (code) ->
    error = new Error("CutyCapt exited with return value #{code}") if code
    cb?(error || false)

exports.path = 'cutycapt'
exports.options = {}
exports.capture = (site, out, cb) ->
  throw new Error('site must be set') unless site
  throw new Error('out must be set') unless out

  site = "http://#{site}" unless url.parse(site).protocol

  # ensure out format is supported by cutycapt
  extension = out.substring(out.lastIndexOf('.') + 1 || out.length)
  unless extension in SUPPORTED_EXTENSIONS
    throw new Error("out must have one of the following extentions: #{SUPPORTED_EXTENSIONS.join(', ')}")

  spawnCutyCapt exports.path, site, out, exports.options, cb
