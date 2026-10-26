install.packages("xts")
install.packages("rugarch")
library(xts)
library(rugarch)

# === Step 1. 导入数据并计算收益率 ===
data_jnj <- read.table("data/d-jnj9808.txt", header = TRUE)
ret_jnj <- 100 * log(1 + data_jnj[, 2])   # 日收益率（百分比表示）

# === Step 2. 日期格式化 ===
date_series <- as.Date(
  paste0(substr(data_jnj[, 1], 1, 4), "-", 
         substr(data_jnj[, 1], 5, 6), "-", 
         substr(data_jnj[, 1], 7, 8))
)

# === Step 3. 绘制收益率时序图 ===
plot(xts(ret_jnj, order.by = date_series), 
     type = "l", col = "steelblue",
     main = "JNJ Daily Log Returns", 
     xlab = "Date", ylab = "Return (%)")

# === Step 4. 拟合 GJR-GARCH(1,1) 模型 ===
spec_gjr <- ugarchspec(
  variance.model = list(model = "gjrGARCH", garchOrder = c(1, 1)),
  mean.model = list(armaOrder = c(0, 0))
)
fit_gjr <- ugarchfit(spec_gjr, data = ret_jnj)
show(fit_gjr)

# === Step 5. 拟合 TGARCH(1,1) 模型 ===
spec_tgarch <- ugarchspec(
  variance.model = list(model = "fGARCH", submodel = "TGARCH", garchOrder = c(1, 1)),
  mean.model = list(armaOrder = c(0, 0))
)
fit_tgarch <- ugarchfit(spec_tgarch, data = ret_jnj)
show(fit_tgarch)