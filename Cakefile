{spawn} = require 'child_process'

build = ->
  coffee = spawn('coffee', ['-c', '-o', 'lib', 'src'])
  coffee.stderr.pipe process.stderr, end: false
  coffee.stdout.pipe process.stdout, end: false

task 'build', 'Build lib/ from src/', ->
  build()
