# https://mp.weixin.qq.com/s/69BPDxvZtCEeoMF7Mevm7g
#挂载R包
library(corrplot)

#使用内置数据集进行测试：
dt <- mtcars
head(dt)

#组内相关性系数计算：
cor <- cor(dt,method = "pearson")
cor[1:6,1:5]

#相关性热图绘制：
#可选图形样式："circle", "square", "ellipse", "number", "shade", "color", "pie"
corrplot(cor, method = c('circle')) #默认样式是circle

#可选布局方式："full", "lower"下三角, "upper"上三角
corrplot(cor, method = c('circle'), type = c('upper')) #默认布局是upper

#参数设置
#渐变色自定义：
mycol <- colorRampPalette(c("#06a7cd", "white", "#e74a32"), alpha = TRUE)
mycol2 <- colorRampPalette(c("#0AA1FF","white", "#F5CC16"), alpha = TRUE)
corrplot(
  cor,
  method = c('square'), type = c('lower'), col = mycol2(100),
  outline = 'grey', #是否为图形添加外轮廓线，默认FLASE，可直接TRUE或指定颜色向量
  order = c('AOE'), #排序/聚类方式选择："original", "AOE", "FPC", "hclust", "alphabet"
  diag = FALSE, #是否展示对角线结果，默认TRUE
  tl.cex = 1.2, #文本标签大小
  tl.col = 'black', #文本标签颜色
  addgrid.col= 'grey' #格子轮廓颜色
)

#叠加相关性系数
corrplot(
  cor,
  method = c('pie'), type = c('upper'), col = mycol(100),
  outline = 'grey',
  order = c('AOE'),
  diag = TRUE,
  tl.cex = 1.2, tl.col = 'black',
  addCoef.col = 'black', #在现有样式中添加相关性系数数字，并指定颜色
  number.cex = 0.8, #相关性系数数字标签大小
)

#上图下系数（对角线显示标签）
#上三角
corrplot(
  cor,
  method = c('pie'), type = c('upper'), col = mycol(100),
  outline = 'grey', order = c('AOE'), diag = TRUE,
  tl.cex = 1, tl.col = 'black',
  tl.pos = 'd' #仅在对角线显示文本标签
)
#下三角
corrplot(
  cor,
  add = TRUE,
  method = c('number'), type = c('lower'), col = mycol(100),
  order = c('AOE'), diag = FALSE, number.cex = 0.9,
  tl.pos = 'n', #不显示文本标签
  cl.pos = 'n' #不显示颜色图例
)

#上图下系数（两侧显示标签）
#上三角
corrplot(
  cor,
  method = c('square'), type = c('upper'), col = mycol(100),
  outline = 'grey', order = c('AOE'), diag = TRUE,
  tl.cex = 1.2, tl.col = "black",
  tl.pos = "tp"
)
#下三角
corrplot(
  cor,
  add = TRUE,
  method = c('number'), type = c('lower'), col = mycol(100),
  order = c('AOE'), diag = FALSE, number.cex = 0.9,
  tl.pos = 'n', cl.pos = 'n'
)

#添加显著性标记
#显著性计算：
res <- cor.mtest(dt, conf.level = .95)
p <- res$p
p[1:6,1:5]
#上三角添加显著性水平星号：
corrplot(
  cor,
  method = c('pie'), type = c('upper'), col = mycol(100),
  outline = 'grey', order = c('AOE'), diag = TRUE,
  tl.cex = 1, tl.col = 'black', tl.pos = 'd',
  p.mat = p,
  sig.level = c(.001, .01, .05),
  insig = "label_sig", #显著性标注样式："pch", "p-value", "blank", "n", "label_sig"
  pch.cex = 1.2, #显著性标记大小
  pch.col = 'black' #显著性标记颜色
)
#下三角给不显著打叉：
corrplot(
  cor,
  add = TRUE,
  method = c('number'), type = c('lower'), col = mycol(100),
  order = c('AOE'), diag = FALSE, number.cex = 0.9,
  tl.pos = 'n', cl.pos = 'n',
  p.mat = p,
  insig = "pch"
)
