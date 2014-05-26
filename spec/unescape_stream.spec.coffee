fs              = require 'fs'
UnescapeStream  = require '../unescape_stream'

describe "UnescapeStream", ->
  beforeEach ->
    @ues = new UnescapeStream()

  it "should remove double escapes in string", (done)->
    data = ""
    fs.createReadStream(__dirname + "/fixtures/escaped_string_short")
      .pipe @ues

    @ues.on "data", (chunk)->
      data += chunk

    @ues.on "end", ()->
      expect(data).toEqual ".\\nColour"
      done()


  it "should remove double unescapes in stream to return valid json string", (done)->
    data = ""
    fs.createReadStream(__dirname + "/fixtures/escaped_json_string")
      .pipe @ues

    @ues.on "data", (chunk)->
      data += chunk

    @ues.on "end", ()->
      json_obj = ""
      expect(()=>
        json_obj = JSON.parse data
      ).not.toThrow()      
      expect(json_obj[0].title).toEqual  "Skinny Sniper Belt in Green(4416157GRNF)"
      done()

  it "should remove repeated unescapes in stream across chunks", (done)->
    data = ""
    fs.createReadStream(__dirname + "/fixtures/escaped_string_long")
      .pipe @ues

    @ues.on "data", (chunk)->
      data += chunk

    @ues.on "end", ()->
      sample =  ".\\nColour"
      expect(data).toEqual sample
      done()