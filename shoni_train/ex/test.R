# 벡터 생성
vector1 <- c(1:10)
print(vector1)
vector2 <- c(1:10, NA)
print(vector2)

# 합계
sum(vector1)
sum(vector2)
sum(vector2, na.rm = T)

# 평균
mean(vector1)
mean(vector2, na.rm = T)

# 중앙값
median(vector1)
median(vector2, na.rm = T)

# 표본 분산
var(vector1)
var(vector2, na.rm = T)

# 표본 표준편차
sd(vector1)
sd(vector2, na.rm = T)

# 최댓값
max(vector1)
max(vector2, na.rm = T)

# 최솟값
min(vector1)
min(vector2, na.rm = T)

# 최댓값과 최솟값
range(vector1)
range(vector2, na.rm = T)

# 요약값
summary(vector1)
summary(vector2)

