install.packages("rugarch")
library(xts)       # 时间序列数据处理
library(rugarch)   # 高级 GARCH 模型估计（比 fGarch 功能更丰富）

# 读取原始数据
data_raw <- read.table("data/d-gmsp9908.txt", header = TRUE)

# 提取第二列数据（假设为 GM 指数）
gm_series <- data_raw[, 2]

# 构建日期（原始是 YYYYMMDD 格式，需转化为标准日期）
date_seq <- as.Date(paste0(
  substr(data_raw[, 1], 1, 4), "-",   # 年份
  substr(data_raw[, 1], 5, 6), "-",   # 月份
  substr(data_raw[, 1], 7, 8)         # 日期
))

# 转为 xts 对象并绘制序列
ts_gm <- xts(gm_series, order.by = date_seq)
plot(ts_gm, type = "l", col = "blue",
     main = "GM Time Series",
     xlab = "Date", ylab = "GM Index")

# ========= 模型一：标准 GARCH(1,1) =========
spec_garch <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0), archm = TRUE)  # archm=TRUE 表示均值中含 ARCH 项
)
model_garch <- ugarchfit(spec = spec_garch, data = gm_series)
show(model_garch)

# ========= 模型二：指数 GARCH(1,1) =========
spec_egarch <- ugarchspec(
  variance.model = list(model = "eGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0))
)
model_egarch <- ugarchfit(spec = spec_egarch, data = gm_series)
show(model_egarch)