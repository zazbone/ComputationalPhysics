### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 987c5c4d-3257-41cf-b8a9-7b3e814ba61b
begin
	using Pkg
	Pkg.add("Plots")
	using Plots
end

# ╔═╡ 9215d698-38ed-11ec-1e52-45e96b1bc12e
md"""
# Chapter 1
## Section 1

Taylor series in the neighborhood of x = a

$$f(x) = \sum_{n=0}^{\infty}\frac{f^{(n)}(a)}{n!}(x-a)^n$$

Near a = 0 and for x = $\pm$h we can write at the third order

$$f(h) = f_0 + hf' + \frac{h^2}{2}f''$$
$$f(-h) = f_0 - hf' + \frac{h^2}{2}f''$$

If we sub

$$f(h) - f(-h) = 2hf'$$
$$\Rightarrow f' = \frac{f(h) - f(-h)}{2h}$$

Centered difference
"""

# ╔═╡ c7732e76-19b9-4aa6-a61e-5b142dae1d3e
function funcdiff(f, x::T, dx::T)::T where T <: Number
	(f(x + dx) - f(x - dx)) / (2 * dx)
end

# ╔═╡ 5137159c-90a8-49a5-9aa3-5356f3137662
begin
	x = collect(0:0.01:7)
	y = funcdiff.(sin, x, 0.01) 
	plot(x, y)
end

# ╔═╡ 72affc38-4df9-48af-98b7-0b1b92d9d980
function arraydiff(x::Vector{T}, dx::T)::Vector{T} where T <: Number
	(x[2:end] - x[1:end-1]) / (2 * dx)
end

# ╔═╡ 42d3c309-bb3a-479b-91fd-3d26adda0555
begin
	u = collect(0:0.01:7)
	v = arraydiff(sin.(x), 0.01) 
	plot(u[2:end], v)
end

# ╔═╡ cb996ce0-a6f1-4176-b226-b1e4b322fabb
md"""
We can apply this method to other orders of derivations and order of the Taylor series.

Increasing the order of the series will increase the accuracy but it will also increase the calculation time.

The value of h also influences the precision

Exercice: For the same function and interval, evaluate the mean error with the analytic derivation.
"""

# ╔═╡ 7b6412e5-2f4f-409a-b959-6c9c4eb29a9e
begin
	allh = collect(0.01:0.01:1)
	alleps = Float64[]
	for h in allh
		x = 0:h:7
		cosine = cos.(x)
		sinus = funcdiff.(sin, x, h)
		eps = sum(sqrt.(cosine.^2 + sinus.^2)) / length(x)
		append!(alleps, eps)
	end
	plot(allh, alleps)
end

# ╔═╡ Cell order:
# ╠═987c5c4d-3257-41cf-b8a9-7b3e814ba61b
# ╟─9215d698-38ed-11ec-1e52-45e96b1bc12e
# ╠═c7732e76-19b9-4aa6-a61e-5b142dae1d3e
# ╠═5137159c-90a8-49a5-9aa3-5356f3137662
# ╠═72affc38-4df9-48af-98b7-0b1b92d9d980
# ╠═42d3c309-bb3a-479b-91fd-3d26adda0555
# ╟─cb996ce0-a6f1-4176-b226-b1e4b322fabb
# ╠═7b6412e5-2f4f-409a-b959-6c9c4eb29a9e
