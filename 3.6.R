install.packages("fGarch")
library(xts)        # 处理时间序列对象
library(fGarch)     # 拟合GARCH族模型

# 读取数据
data_raw <- read.table("data/m-mrk4608.txt", header = TRUE)

# 计算收益率（对数形式）
ret_mrk <- log(1 + data_raw[, 2])

# 构造日期（原数据中日期格式形如 YYYYMMDD，需要转成标准日期格式）
date_seq <- as.Date(paste0(
  substr(data_raw[, 1], 1, 4), "-",      # 年份
  substr(data_raw[, 1], 5, 6), "-",      # 月份
  substr(data_raw[, 1], 7, 8)            # 日期
))

# 转为 xts 对象并绘制收益率序列
ts_mrk <- xts(ret_mrk, order.by = date_seq)
plot(ts_mrk, type = "l", col = "blue",
     main = "Market Return Series", 
     xlab = "Date", ylab = "Return")

# Ljung-Box 检验序列是否有自相关
Box.test(ret_mrk, lag = 12, type = "Ljung-Box")

# 同时绘制 ACF 和 PACF 图像，观察序列相关性
par(mfrow = c(2, 1))
acf(ret_mrk, main = "ACF of Market Return")
pacf(ret_mrk, main = "PACF of Market Return")

# 拟合 ARIMA(0,0,1) 模型（即 MA(1)）
model_arima <- arima(ret_mrk, order = c(0, 0, 1))
model_arima

# 对残差进行 Ljung-Box 检验（检验序列是否为白噪声）
Box.test(model_arima$residuals, lag = 10, type = "Ljung-Box")
# 检验残差平方的自相关性（用于发现异方差）
Box.test(model_arima$residuals^2, lag = 12, type = "Ljung-Box")

# 绘制残差平方的 PACF 图，观察是否存在 ARCH 效应
par(mfrow = c(1, 1))
pacf(model_arima$residuals^2, main = "PACF of Squared Residuals")

# 在 MA(1) 基础上，拟合 GARCH(3,0) 模型
model_garch <- garchFit(
  formula = ~ arma(0, 1) + garch(3, 0),
  data = ret_mrk,
  trace = FALSE
)

# 输出模型结果
summary(model_garch)
