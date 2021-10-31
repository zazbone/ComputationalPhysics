using LinearAlgebra
using OpenCL

const sum_kernel = "
   __kernel void sum(__global float *a,
                     __global const float *b)
    {
      int gid = get_global_id(0);
      a[gid] = a[gid] + b[gid];
    }
"
a = zeros(Float32, 50_000)
b = ones(Float32, 50_000)

device, ctx, queue = cl.create_compute_context()

a_buff = cl.Buffer(Float32, ctx, (:rw, :copy), hostbuf=a)
b_buff = cl.Buffer(Float32, ctx, (:r, :copy), hostbuf=b)

p = cl.Program(ctx, source=sum_kernel) |> cl.build!
k = cl.Kernel(p, "sum")

queue(k, size(a), nothing, a_buff, b_buff)

r = cl.read(queue, a_buff)

if isapprox(r, fill(Float32(1), 50000))
    @info "Success!"
else
    @error "Norm should be 0.0f"
end