# cutiecapt - easy webpage screenshots for node
### (CutyCapt bindings)

## Installation
Build the library using ```cake build``` and link it locally with ```npm link```

## Exports
The path to CutyCapt

```exports.path = 'CutyCapt'```

Additional options to pass (camel cased, e.g. jsCanOpenWindows)

```exports.options = {}```

Capture, cb is passed false on success or otherwise an error object

```exports.capture = function (site, out, cb)```

## Usage
Require the library

```cutiecapt = require('cutiecapt');```

Set your path to CutyCapt (defaults to ```CutyCapt```)

```cutiecapt.path = './CutyCapt';```

Capture a webpage

```cutiecapt.capture('google.ca', 'google.png');```

## CutyCapt
http://cutycapt.sourceforge.net/