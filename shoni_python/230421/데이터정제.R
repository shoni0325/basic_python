library(dplyr)
library(ggplot2)

# 극단치

View(mpg)

# 극단치를 확인 (시각화)
boxplot(mpg$cty)
# 극단치를 수치로 표현
boxplot(mpg$cty)$stats

mpg = ggplot2::mpg

# 이상치는 26 초과 이거나 9 미만인 경우
# 이상치를 결측치로 변환
# 결측치의 개수를 확인
ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty) -> mpg$cty
table(is.na(mpg$cty))

# dplyr 패키지를 이용하여
# 결측치를 제거하고
# 제조사별(manufacturer)로 그룹화
# 도심 연비(cty)의 평균
# 도심 연비가 좋은 상위 5개의 제조사를 확인
mpg %>% 
  filter(!is.na(cty)) %>% 
  group_by(manufacturer) %>% 
  summarise(cty_mean = mean(cty)) %>% 
  arrange(desc(cty_mean)) %>% 
  head(5)

#초기화
mpg = ggplot2::mpg

# total 파생변수 생성
# total은 (cty + hwy) / 2

# test 파생변수 생성
# total이 30 이상이면 'A'
# 20 이상이고 30 미만이면 'B'
# 20 미만이면 'C'

# 소연풀이
mpg$total = (mpg$cty + mpg$hwy) / 2
mpg


ifelse(mpg$total >= 30, 'A',
       ifelse(mpg$total >= 20 & mpg$total < 30, 'B', 'C')) -> mpg$test
mpg

# 교수님 풀이
total = (mpg$cty + mpg$hwy) / 2
  # total 만드는 4가지 방법
mpg$total = total
data.frame(mpg, total)
cbind(mpg, total)
mpg %>% mutate(total = (cty+hwy) / 2) -> mpg
  # test
ifelse(mpg$total >= 30, 'A',
       ifelse(mpg$total >= 20, 'B', 'C')) -> mpg$test


# 시각화화
qplot(mpg$test)    # 개수가 막대그래프로 표현된다

# midwest 데이터
midwest = ggplot2::midwest
View(midwest)

# 소연 풀이이
# 컬럼의 이름을 변경
# rename(데이터프레임명, 새 컬럼의 이름 = 변경이 될 컬럼의 이름)
# popasian 컬럼을 asian, poptotal 컬럼을 total 변경
rename(midwest, asian = popasian) -> midwest
rename(midwest, total = poptotal) -> midwest

# ratio 파생변수 생성 -> 전체 인구수 대비 아시아의 인구수 (백분율)
midwest %>% mutate(ratio = asian / total * 100 ) -> midwest
midwest

# group 파생변수 생성 -> ratio 평균보다 ratio의 값이 크면 'large' 아니면 'small'
mean(midwest$ratio) -> mean_ratio

ifelse(midwest$ratio > mean_ratio, 'large', 'small') -> midwest$group
midwest



# 교수님 풀이
rename(midwest, asian = popasian, total = poptotal) -> midwest
View(midwest)

midwest %>% mutate(ratio = asian / total * 100) -> midwest

ifelse(midwest$ratio > mean(midwest$ratio), 'large', 'small') -> midwest$group

qplot(midwest$group)
table(midwest$group)













