"""Day 18 short version"""

data = readlines("input/18")

# For more information see this discussion about operation precedence
# https://discourse.julialang.org/t/on-adjoints-and-custom-postfix-and-infix-operators/12863/35

⦾(a,b) = +(a,b) # change + to Unicode symbol with same precedence (11) as *
⟱(a,b) = +(a,b) # change + to Unicode symbol with more precedence (15) than * (same as ^)

# sum all evaluated lines with customized precedence
CustomizedPrecedence(symbol) = sum([eval(Meta.parse(replace(line, r"\+" => symbol))) for line in data])
CustomizedPrecedence.(["⦾", "⟱"])