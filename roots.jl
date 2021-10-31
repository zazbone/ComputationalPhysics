### A Pluto.jl notebook ###
# v0.17.0

using Markdown
using InteractiveUtils

# ╔═╡ 0a57947c-3a56-11ec-1341-534834850daf
md"""
# Chapter 1
## Section 3
"""

# ╔═╡ 8fcfe29e-049c-4df3-9d4b-325d3f4e171e
function newton(f, fp, x0, tol)
	x = x0
	while abs(f(x)) > tol
		x = x - f(x) / fp(x)
	end
	x
end

# ╔═╡ 74555744-e6a7-47bd-96b9-7e8909664f42
newton(x -> x^2 - 5., x -> 2. * x, 1., 10e-6)

# ╔═╡ 40d3098f-4b1b-4ca1-be89-5eb9a18ef3a8
function secant(f, x0, x1, tol)
	x = x0
	xx = x1
	while abs(f(xx)) > tol
		tmp = xx
		xx = xx - f(xx) * (xx - x) / (f(xx) - f(x))
		x = xx
	end
	xx
end

# ╔═╡ 7d023bfd-53fb-46a1-84dc-1c34519387dc
secant(x -> x^2 - 5., 2, 2.3, 10e-6)
# Well ... I'm definitly not got at finding roots

# ╔═╡ Cell order:
# ╟─0a57947c-3a56-11ec-1341-534834850daf
# ╠═8fcfe29e-049c-4df3-9d4b-325d3f4e171e
# ╠═74555744-e6a7-47bd-96b9-7e8909664f42
# ╠═40d3098f-4b1b-4ca1-be89-5eb9a18ef3a8
# ╠═7d023bfd-53fb-46a1-84dc-1c34519387dc
