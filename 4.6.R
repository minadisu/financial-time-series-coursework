install.packages("TSA")
library(TSA)
# === Step 1. 导入1年期与3年期国债利率数据 ===
bond_1yr <- read.table("data/w-gs1yr.txt", header = TRUE)
bond_3yr <- read.table("data/w-gs3yr.txt", header = TRUE)

# === Step 2. 构造利差与利差变化率 ===
spread_level <- bond_3yr$rate - bond_1yr$rate            # 利差序列
spread_diff  <- diff(bond_3yr$rate) - diff(bond_1yr$rate) # 一阶差分后的利差

# === Step 3. 用极大似然估计法选择AR阶数 ===
order_level <- ar(spread_level, method = "mle")$order
order_diff  <- ar(spread_diff,  method = "mle")$order
cat("AR阶数（原序列） =", order_level, "\n")
cat("AR阶数（差分序列） =", order_diff, "\n")

# === Step 4. 进行非线性检验（Tsay、Keenan、TLRT） ===
cat("\n--- Tsay test ---\n")
Tsay.test(spread_level, 11)
Tsay.test(spread_diff, 12)

cat("\n--- Keenan test ---\n")
Keenan.test(spread_level, 11)
Keenan.test(spread_diff, 12)

cat("\n--- TLRT test ---\n")
tlrt(spread_level, 11)
tlrt(spread_diff, 12)

# === Step 5. 构建TAR模型 ===
tar_level <- tar(spread_level, p1 = 11, p2 = 11, d = 1)
tar_diff  <- tar(spread_diff,  p1 = 12, p2 = 12, d = 1)

# 输出每个状态下的回归系数
cat("\nTAR模型（原序列）系数：\n")
print(tar_level$qr1$coefficients)
print(tar_level$qr2$coefficients)

cat("\nTAR模型（差分序列）系数：\n")
print(tar_diff$qr1$coefficients)
print(tar_diff$qr2$coefficients)