# File:           pasta.js
# Version:        0.1
# Purpose:        Utility for doing math to arbitrary-sized positive integers
# Author:         Austin Ewens (aewens)
# Copyright:      (C) Austin Ewens 2015
define [], () ->
    class Pasta
        constructor: (value) ->
            return "Not a string" unless typeof value is "string"
            @value = value
            @
        int: (value) ->
            return if value is undefined then parseInt(@value, 10) else parseInt(value, 10)
        check: (foreign) ->
            foreign = new Pasta(foreign) unless foreign instanceof Pasta
            return null if foreign.value is undefined
            return foreign
        rev: (value) ->
            return if value is undefined then @value.split("").reverse().join("") else value.split("").reverse().join("")
        pad: (a, b) ->
            return @pad(a, "0" + b) if a.length > b.length
            return @pad("0" + a, b) if a.length < b.length
            return [a, b] if a.length is b.length
        unpad: (c) ->
            if c is undefined
                if @value[0] is "0" then return @unpad(@value.substr(1))
                else return @value
            else
                if c[0] is "0" then return @unpad(c.substr(1))
                else return c
        zeros: (a, zs) ->
            if zs is 0 then return a else @zeros(a.concat("0"), zs - 1)
        add: (foreign) ->
            other = @check(foreign)
            return "Invalid input: #{foreign}" if other is null
            a = @value
            b = other.value
            pab = @pad(a, b)
            aa = @rev(pab[0])
            bb = @rev(pab[1])
            len = (aa.length + bb.length) / 2
            res = ""
            c = 0
            for i in [0...len]
                ia = @int(aa[i])
                ib = @int(bb[i])
                ab = "" + (ia + ib + c)
                if ab.length > 1
                    c = @int(ab[0])
                    ab = ab[1]
                else
                    c = 0
                res = res.concat(ab)
            res = res.concat(c)
            res = @rev(res)
            @value = res
            @
        sub: (foreign) ->
            other = @check(foreign)
            return "Invalid input: #{foreign}" if other is null
            a = @value
            b = other.value
            pab = @pad(a, b)
            aa = @rev(pab[0])
            bb = @rev(pab[1])
            len = (aa.length + bb.length) / 2
            res = ""
            c = 0
            for i in [0...len]
                ia = @int(aa[i])
                ib = @int(bb[i])
                cc = false
                if (ia - c) < ib
                    ia = ia + 10
                    cc = true
                ab = "" + ((ia - c) - ib)
                c = if cc then 1 else 0
                res = res.concat(ab)
            res = res.concat(c)
            res = @rev(res)
            @value = res
            @
        mul: (foreign) ->
            other = @check(foreign)
            return "Invalid input: #{foreign}" if other is null
            a = @value
            b = other.value
            pab = @pad(a, b)
            aa = @rev(pab[0])
            bb = @rev(pab[1])
            len = (aa.length + bb.length) / 2
            res = new Pasta("0")
            cc = []
            for i in [0...len]
                ib = @int(bb[i])
                continue if ib is 0
                for j in [0...len]
                    ia = @int(aa[j])
                    continue if ia is 0
                    ab = @zeros(""+(ia * ib), j)
                    cc.push(@zeros(ab, i))
            res.add(cc[c]) for c in [0...cc.length]
            @value = res.value
            @
        _exp: (a, b, xs) ->
            if b.unpad() is "" then return xs
            else
                bb = b.sub("1")
                xs.push(a)
                @_exp(a, bb, xs)
        exp: (foreign) ->
            other = @check(foreign)
            return "Invalid input: #{foreign}" if other is null
            a = @value
            b = other
            res = new Pasta("1")
            xs = @_exp(a, b, [])
            res.mul(xs[x]) for x in [0...xs.length]
            @value = res.value
            @
    return Pasta
