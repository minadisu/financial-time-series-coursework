install.packages("zoo")
library(xts)       # 时间序列扩展
library(fGarch)    # GARCH 模型估计

# 读取数据
data_raw <- read.table("data/d-gmsp9908.txt", header = TRUE)

# 提取价格序列（第3列）
sp_series <- data_raw[, 3]

# 处理日期（原始格式是 YYYYMMDD）
date_seq <- as.Date(paste0(
  substr(data_raw[, 1], 1, 4), "-",   # 年
  substr(data_raw[, 1], 5, 6), "-",   # 月
  substr(data_raw[, 1], 7, 8)         # 日
))

# 转换为 xts 对象并绘制
ts_sp <- xts(sp_series, order.by = date_seq)
plot(ts_sp, type = "l", col = "darkred",
     main = "S&P Index Time Series", 
     xlab = "Date", ylab = "Index Value")

# Ljung-Box 检验（检验序列自相关性）
Box.test(sp_series, lag = 10, type = "Ljung-Box")

# ACF 和 PACF 检查序列自相关
par(mfrow = c(2, 1))
acf(sp_series, main = "ACF of SP Series")
pacf(sp_series, main = "PACF of SP Series")

# 拟合 ARIMA(2,0,0) 模型，即 AR(2)
model_arima <- arima(sp_series, order = c(2, 0, 0))
model_arima

# 检查残差平方的相关性（ARCH 效应）
Box.test(model_arima$residuals^2, lag = 10, type = "Ljung-Box")

# 在 AR(2) 基础上，拟合 GARCH(1,1) 模型
model_garch <- garchFit(
  formula = ~ arma(2, 0) + garch(1, 1),
  data = sp_series,
  trace = FALSE
)
summary(model_garch)

# 预测未来4期
predict(model_garch, n.ahead = 4)