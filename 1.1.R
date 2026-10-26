library(fBasics)
da = read.table("data/d-3stocks9908.txt", header = T)
rtn = da[, 2:4]
# (a)
apply(rtn * 100, 2, basicStats)
# (b)
lrtn = log(1 + rtn)
lrtn
# (c)
apply(lrtn * 100, 2, basicStats)
# (d)
# \frac{\sqrt{T}\hat{\mu}_x}{\hat{\sigma}_x}
apply(lrtn, 2, t.test)
