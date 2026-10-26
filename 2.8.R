require(xts)
# 读数据
da <- read.table("data/d-ibm3dxwkdays8008.txt",header = TRUE)

# 构造时间序列并画图
sp <- da$sp * 100
plot(
  xts(sp, order.by = as.Date(paste(da$year, da$mom, da$day, sep = '-'))),
  type = 'l',main = '', xlab = 'date', ylab = 'sp'
)

# 回归日历效应（避免创建 T / F 全局变量，直接用 data=da）
m1 <- lm(sp ~ M + T + W + R + F - 1, data = da)   # -1 等价 +0 去掉截距
summary(m1)

# 残差检验
Box.test(m1$residuals, lag = 12, type = 'Ljung')
par(mfrow = c(2, 1))
acf(m1$residuals)
pacf(m1$residuals)

# ---- ARIMAX 模型 ----
# 确保 xreg 是矩阵，并且 include.mean 用 FALSE
m2 <- arima(
  sp,
  order = c(2, 0, 2),
  xreg = as.matrix(da[, 8:12]),
  include.mean = FALSE
)
print(m2)

# 带固定参数的 ARIMAX
m2 <- arima(
  sp,
  order = c(2, 0, 2),
  xreg = as.matrix(da[, c(9, 10, 12)]),
  include.mean = FALSE,
  fixed = c(0, NA, 0, NA, NA, NA, NA),   # 固定部分参数
  transform.pars = FALSE                  # 关闭参数变换，避免警告
)
print(m2)

# 残差检验
Box.test(m2$residuals, lag = 10, type = 'Ljung')