#!
# * Bez @VERSION
# * http://github.com/rdallasgray/bez
# * 
# * A plugin to convert CSS3 cubic-bezier co-ordinates to jQuery-compatible easing functions
# * 
# * With thanks to Nikolay Nemshilov for clarification on the cubic-bezier maths
# * See http://st-on-it.blogspot.com/2011/05/calculating-cubic-bezier-function.html
# * 
# * Copyright @YEAR Robert Dallas Gray. All rights reserved.
# * Provided under the FreeBSD license: https://github.com/rdallasgray/bez/blob/master/LICENSE.txt
#
jQuery.extend bez: (coOrdArray) ->
  encodedFuncName = "bez_" + jQuery.makeArray(arguments).join("_").replace(/\./g, "p")
  if typeof jQuery.easing[encodedFuncName] isnt "function"
    polyBez = (p1, p2) ->
      A = [
        null
        null
      ]
      B = [
        null
        null
      ]
      C = [
        null
        null
      ]
      bezCoOrd = (t, ax) ->
        C[ax] = 3 * p1[ax]
        B[ax] = 3 * (p2[ax] - p1[ax]) - C[ax]
        A[ax] = 1 - C[ax] - B[ax]

        t * (C[ax] + t * (B[ax] + t * A[ax]))

      xDeriv = (t) ->
        C[0] + t * (2 * B[0] + 3 * A[0] * t)

      xForT = (t) ->
        x = t
        i = 0
        z = undefined
        while ++i < 14
          z = bezCoOrd(x, 0) - t
          break  if Math.abs(z) < 1e-3
          x -= z / xDeriv(x)
        x

      (t) ->
        bezCoOrd xForT(t), 1

    jQuery.easing[encodedFuncName] = (x, t, b, c, d) ->
      c * polyBez([
        coOrdArray[0]
        coOrdArray[1]
      ], [
        coOrdArray[2]
        coOrdArray[3]
      ])(t / d) + b
  encodedFuncName
