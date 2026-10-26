# Financial Time Series Coursework | 金融时间序列课程作业

## 

本仓库整理金融时间序列课程的学生作业，包括 10 份 R 脚本和 4 份 Word 作业报告。

参考教材：Ruey S. Tsay，*Analysis of Financial Time Series*，第三版（Third Edition）。

这些材料仅供学习和参考，不是教材官方答案，可能包含错误或不完整之处。请独立完成自己的课程作业，并遵守所在课程的学术诚信要求。

### 文件

| 作业报告 | 对应 R 脚本 |
| --- | --- |
| [作业1.docx](作业1.docx) | `1.1.R`、`1.4.R` |
| [作业2.docx](作业2.docx) | `2.3.R`、`2.8.R`、`2.13.R` |
| [作业3.docx](作业3.docx) | `3.6.R`、`3.12.R`、`3.13.R` |
| [作业4.docx](作业4.docx) | `4.1.R`、`4.6.R` |

### 数据与运行方法

数据由任课教师提供，因版权原因不上传。请通过课程授权渠道获取数据，并放入仓库根目录下的 `data/` 文件夹。下列名称以 R 脚本实际读取的文件名为准：

| R 脚本 | `data/` 下所需文件 |
| --- | --- |
| `1.1.R`、`1.4.R` | `d-3stocks9908.txt` |
| `2.3.R` | `m-unrate.txt` |
| `2.8.R` | `d-ibm3dxwkdays8008.txt` |
| `2.13.R` | `m-ew6299.txt` |
| `3.6.R` | `m-mrk4608.txt` |
| `3.12.R`、`3.13.R` | `d-gmsp9908.txt` |
| `4.1.R` | `d-jnj9808.txt` |
| `4.6.R` | `w-gs1yr.txt`、`w-gs3yr.txt` |

安装 R，并按需安装脚本使用的扩展包：

```r
install.packages(c("fBasics", "xts", "zoo", "fGarch", "rugarch", "TSA"))
```

将 R 的工作目录设为仓库根目录，再逐个运行脚本，例如：

```r
source("1.1.R", encoding = "UTF-8")
```

脚本的数据路径已改为 `data/文件名`；其余分析代码保留原作业内容，部分脚本仍包含 `install.packages()`。本次整理未重新运行模型或验证作业结论。`.gitignore` 排除数据目录中的数据文件和常见 R 会话文件。

## 

This repository contains student coursework for a financial time series course: 10 R scripts and four Word reports. The course textbook is Ruey S. Tsay's *Analysis of Financial Time Series*, Third Edition.

These are student assignments for learning and reference only, not official textbook solutions. They may contain mistakes or incomplete work. Complete your own assignments independently and follow your course's academic integrity requirements.

The tables above map the reports to the scripts and list the exact data filenames expected by the code. The datasets were provided by the course instructor and are not uploaded because of copyright restrictions. Obtain the data through authorized course channels and place the files in the `data/` directory at the repository root.

Install R and the packages listed above. Set the R working directory to the repository root, then run each script individually, for example with `source("1.1.R", encoding = "UTF-8")`.

Data paths have been changed to relative paths under `data/`. The remaining analysis code is preserved from the coursework, including package installation calls in some scripts. The models and assignment conclusions were not rerun or validated during this upload. The `.gitignore` file excludes datasets under `data/` and common R session files.
