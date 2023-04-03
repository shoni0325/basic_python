# 평균값 함수
def custom_mean(*_list) :
    # while문
    # 초기값 지정
    i = 0
    # 합계 변수 생성, 0을 대입
    sum = 0
    while i < len(_list) :
        #print(_list[i])
        sum += _list[i]
        # i 값을 증가
        i += 1
    # print(sum)
    result = sum / len(_list)
    return result

def custom_max(*_list) :
    result = _list[0]       # 인자가 한 개더라도 결과가 나오게 하기 위해

# max 함수
    # 첫 번째 원소를 출력?
    # 첫 번째 원소와 두 번째 원소의 값을 비교하여 큰 값을 result에 대입
    # if result > _list[1] :
       # result = _list[0]
    # else :
        # result = _list[1]
    
    # result와 세 번째 원소를 비교
    # if result > _list[2] :
        # result = result
    # else :
        # result = _list[2]

# -------------------------------------------- 계속 반복의 형태
    # if result < _list[1] :        
    #     result = _list[1]

    # if result < _list[2] :
    #     result = _list[2]

#--------------------------------------------- 깔끔하게 정리하면?
#     
    # case1. 위치로 계산
    # for i in range(1, len(_list), 1) :
    #     if result < _list[i] :
    #         result = _list[i]    
    # return result
    #------------------
    # case2. i값으로 계산
    for i in _list :
        if result < i :
            result = i
    return result