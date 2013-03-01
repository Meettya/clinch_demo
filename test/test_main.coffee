###
Test suite for node AND browser in one file
###

{printer} = require "../src/main"

describe 'Printer:', ->

  it 'should use format string', ->

    res = printer 'Mr. %s have acount #%010s with $%.2f', 'Jonh Smith' , 4477, 788.22798798
    console.log res
    res.should.to.be.equal 'Mr. Jonh Smith have acount #0000004477 with $788.23'