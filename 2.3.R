da = read.table("data/m-unrate.txt", header = T)
rate = da[, 4]
plot(ts(rate, start = c(1948, 1), frequency = 12), type = 'o', xlab = 'year', ylab = 'rate')
# decay slowly
acf(rate)
par(mfrow = c(2, 1))
acf(diff(rate))
pacf(diff(rate))
acf(diff(rate, 12))
pacf(diff(rate, 12))
cat("order =", ar(rate, method = 'mle')$order, "\n")
m1 = arima(rate, order = c(11, 0, 0))
m1
m1 = arima(rate, order = c(11, 0, 0), fixed = c(NA, NA, 0, 0, 0, NA, 0, 0, 0, NA, NA, NA))
m1
# FIXME
m2 = arima(rate, order = c(2, 1, 1), seasonal = list(order = c(1, 0, 1), period = 12))
m2
tsdiag(m1, gof = 36)
tsdiag(m2, gof = 36)
predict(m1, 4)
predict(m2, 4)
