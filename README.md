# Unescape Stream

Remove instances of repeated escapes '\' in an arbituarily large file

## Usage
```coffee
UnescapeStream = require "unescape-stream"
ues = new UnescapeStream()

data = ""
fs.createReadStream(__dirname + "/fixtures/escaped_string_long")
  .pipe @ues

@ues.on "data", (chunk)->
  data += chunk

@ues.on "end", ()->
  console.log data
  
```

Sample input
```coffee
input = "This is the first line\\\\\nThis is the second line"
```

Sample output
```coffee
output = "This is the first line\nThis is the second line"
```

## Installation
```console
npm install unescape-stream
```