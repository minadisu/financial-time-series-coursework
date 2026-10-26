da = read.table("data/m-ew6299.txt", header = F)
lrtn = da[, 1]
plot(lrtn, type = 'l', ylab = 'lrtn')
t.test(lrtn)
par(mfrow = c(2, 1))
acf(lrtn)
pacf(lrtn)
m1 = arima(lrtn, order = c(1, 0, 0))
m1
Box.test(m1$residuals, lag = 12, type = 'Ljung')
m2 = arima(lrtn, order = c(0, 0, 1))
m2
Box.test(m2$residuals, lag = 12, type = 'Ljung')
predict(m1, 2)
predict(m2, 2)
