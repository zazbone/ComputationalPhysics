### A Pluto.jl notebook ###
# v0.17.0

using Markdown
using InteractiveUtils

# ╔═╡ 39da52d0-3e5b-4dad-9de9-6a8b0337f124
begin
	# Run once if dependencies not installed
	using Pkg
	Pkg.add("Plots")
end

# ╔═╡ 4345a821-21fa-4a84-91a9-c3c539db2725
begin
	using Plots
end

# ╔═╡ 88843947-6008-41cc-b204-3f822e542ae3
md"""
# Chapter 1
## Section 2
"""

# ╔═╡ 98cdb6dc-3a40-11ec-1eb2-f7e085a3b6e6
function trapezoid(f, n::Integer, a::T, b::T)::T where T <: Real
	dx = (b - a) / n
	if a < b
		a, b = a + dx, b - dx
		sign = 1.
	else
		a, b = b + dx, a - dx
		sign = -1
	end
	integral = 0
	h = 2. * dx
	for x in a:h:b
		integral += 0.5 * dx * (f(x + dx) + 2 * f(x) + f(x - dx))
	end
	integral
end

# ╔═╡ e62b3b53-60c8-4450-978c-7558398fa085
trapezoid(sin, 256, 0., float(pi))

# ╔═╡ 7aa7729a-9c6c-457b-a271-8cd0775a65bf
function simpson(f, n::Integer, a::T, b::T)::T where T <: Real
	dx = (b - a) / n
	if a < b
		a, b = a + dx, b - dx
		sign = 1.
	else
		a, b = b + dx, a - dx
		sign = -1
	end
	integral = 0
	h = 2. * dx
	for x in a:h:b
		integral +=  (dx / 3) * (f(x + dx) + 4 * f(x) + f(x - dx))
	end
	integral
end

# ╔═╡ c1449e54-2bfa-4fce-a7b4-227451327b48
function bode(f, n::Integer, a::T, b::T)::T where T <: Real
	dx = (b - a) / n
	h = 4. * dx
	if a < b
		a, b = a + h / 2., b - h / 2.
		sign = 1.
	else
		a, b = b + h / 2., a - h / 2.
		sign = -1
	end
	integral = 0
	for x in a:h:b
		integral +=  (2 * dx / 45) * (
			7 * f(x + 2. * dx) + 32. * f(x + dx)
			+  12. * f(x) +
			7 * f(x - 2. * dx) + 32. * f(x - dx))
	end
	integral
end

# ╔═╡ 1dea0b53-fc17-43f3-b1df-495fff0529e9
begin
	x = collect(2:8) # Weird result betwin 7 ~ 14
	func = [trapezoid, simpson, bode]
	y = Array{Float64}(undef, (length(func), length(x)))
	for (k, f) in enumerate(func)
		for i in 1:length(x)
			y[k, i] = abs(2. - f(sin, 1 << x[i], 0., float(pi)))
		end
	end
	plot(x, y', label=["trap" "simp" "bode"])
end

# ╔═╡ Cell order:
# ╟─88843947-6008-41cc-b204-3f822e542ae3
# ╠═39da52d0-3e5b-4dad-9de9-6a8b0337f124
# ╠═4345a821-21fa-4a84-91a9-c3c539db2725
# ╠═98cdb6dc-3a40-11ec-1eb2-f7e085a3b6e6
# ╠═e62b3b53-60c8-4450-978c-7558398fa085
# ╠═7aa7729a-9c6c-457b-a271-8cd0775a65bf
# ╠═c1449e54-2bfa-4fce-a7b4-227451327b48
# ╠═1dea0b53-fc17-43f3-b1df-495fff0529e9
