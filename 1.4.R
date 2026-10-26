require(fBasics)

da = read.table("data/d-3stocks9908.txt", header = T)
laxp = log(1 + da[, 2])
# (a)
# \frac{\hat{S}(r)}{\sqrt{6/T}}
t1 = skewness(laxp) / sqrt(6 / length(laxp))
cat("t1 =", t1, "\n")
p1 = pnorm(t1) * 2
cat("p1 =", p1, "\n")
# (b)
# \frac{\hat{K}(r) - 3}{\sqrt{24/T}}
t2 = kurtosis(laxp) / sqrt(24 / length(laxp))
cat("t2 =", t2, "\n")
p2 = (1 - pnorm(t2)) * 2
cat("p2 =", p2, "\n")