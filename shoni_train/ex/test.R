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

# 산점도
vector3 <- sample(100)
vector4 <- sample(100)
plot(vector3, vector4)

# 공분산
cov(vector3, vector4)

# 상관계수
cor(vector3, vector4)


# 값이 크면 클 수록 두 데이터는 정비례
# vector2가 값이 증가할 때 vector3 역시 값이 증가
vector5 <- 1:100
vector6 <- vector5 + rnorm(100,0,10)
plot(vector5, vector6)
cov(vector5, vector6)
cor(vector5, vector6)

# fBasics 설치
install.packages('fBasics')
library(fBasics)

# 왜도
vector7 <- rnorm(1000)
skewness(vector7)
hist(vector7, breaks = 30)

# 첨도 (첨도값이 3일 경우 정규분포에 근사, 때로는 kurtosis값에서 3을 빼서 0일때 정규분포에 근사하고도 표현)
# R의 kurtosis 합수는 첨도값에서 -3을 뺌
kurtosis(vector7)


# 표본추출

# sample
sample(10)
sample(10, 5)
sample(10, 100)
sample(10, 100, replace = T)

# 균일분포
vector1 <- runif(1000)
vector1
vector2 <- runif(1000, 10, 100)
vector2
hist(vector2, breaks = 30)

# 정규분포
vector3 <- rnorm(1000)
vector3
hist(vector3, breaks = 30)
vector4 <- rnorm(1000,50,10)
vector4
hist(vector4, breaks=30)
?hist

# 데이터 프레임 탐색
math = sample(100, 1000, replace = T)
eng = sample(100, 1000, replace = T)
df1 <- data.frame(math, eng)

head(df1)
head(df1, 10)

tail(df1)
tail(df1, 10)

# 1개의 조건에 맞게 추출 subset(데이터프레임, 조건)
math100 <- subset(df1, df1$math==100)
math100
math10_under <- subset(df1, df1$math<10)
math10_under

# 2개 이상의 조건
one100 <- subset(df1, df1$math==100|df1$eng==100)
one100
math100_eng100 <- subset(df1, df1$math==100&df1$eng==100)
math100_eng100

# 데이터프레임에 함수 적용 apply
# (데이터프레임, 1 또는 2, 함수)
score_sum_by_row <- apply(df1, 1, sum)
score_sum_by_row
score_mean_by_column <- apply(df1, 2, mean)
score_mean_by_column

# 데이터 프레임에 함수 결과 적용
df1$avg_value <- apply(df1, 1, mean)
head(df1)














