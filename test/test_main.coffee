###
Test suite for node AND browser in one file
###

{printer}   = require "../src/printer"
{formatter} = require '../src/formatter'

describe 'Printer:', ->

  it 'should use format string', ->

    res = printer 'Mr. %s have acount #%010s with $%.2f', 'Jonh Smith' , 4477, 788.22798798
    console.log res
    res.should.to.be.equal 'Mr. Jonh Smith have acount #0000004477 with $788.23'

describe 'Formatter:', ->

  it 'should use format string', ->

    res = formatter 'Mr. %s have acount #%d with $%d', 'Jonh Smith' , 4477, 788.22798798
    console.log res
    res.should.to.be.equal 'Mr. Jonh Smith have acount #4477 with $788.22798798'