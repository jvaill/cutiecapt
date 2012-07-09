# cutiecapt - easy webpage screenshots

## Installation
Build the library using ```cake build``` and link it locally with ```npm link```

## Exports
The path to CutyCapt

```exports.path = 'cutycapt'```

Additional options to pass (in camel case)

```exports.options = {}```

Capture, cb is passed false on success or otherwise an error object

```exports.capture = function (site, out, cb)```

## Usage
Require the library

```cutiecapt = require('cutiecapt');```

Set your path to CutyCapt (defaults to ```cutycapt```)

```cutiecapt.path = './cutycapt';```

Capture a webpage

```cutiecapt.capture('google.ca', 'google.png');```
