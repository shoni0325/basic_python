import pandas as pd
import numpy as np
from datetime import datetime


# 첫 번째 함수 생성
def first(df, col = 'Close', start = '20100101', end = '20230101') :

    # 인덱스가 'Date'가 아니면? Date 컬럼을 인덱스로 변경해준다.
    if 'Date' in df.columns :
        df = df.set_index('Date')

    # start, end 시계열로 변경
    start = datetime.strptime(start, '%Y%m%d').isoformat()
    end = datetime.strptime(end, '%Y%m%d').isoformat()

    # 결측치, 이상치 제거
    df = df.loc[~df.isin([np.nan, np.inf, -np.inf]).any(axis = 'columns')]

    # 수정종가를 제외한 나머지 컬럼 삭제
    df = df[[col]]

    # 인덱스를 시계열로 변경
    df.index = pd.to_datetime(df.index, format = '%Y-%m-%d')
    df = df.loc[start:end]

    # 'STD_YM' 컬럼을 생성
    df['STD_YM'] = list(map(lambda x : datetime.strftime(x, '%Y-%m'), df.index))
    
    return df


# 두 번째 함수 생성
def second(df) :
    col = df.columns[0]
    # # 새로운 데이터프레임 생성 (월의 가장 마지막 날을 집어넣어주기 위해)
    # df2 = pd.DataFrame()
    
    # # 인자값으로 받아온 데이터프레임에서 년-월별 마지막 데이터들을 새로운 데이터프레임에 대입
    # _list = df['STD_YM'].unique()

    # for i in _list :
    #     last_df = df.loc[df['STD_YM'] == i].tail(1)
    #     df2 = pd.concat([df2, last_df])
    
    # 월별 마지막날의 데이터만 추출 
    df2 = df.loc[df['STD_YM'] != df.shift(-1)['STD_YM']]

    # df2에 전월, 전년도 종가 파생변수 2개 생성
    df2['BF_1M'] = df2[col].shift(1).fillna(0)
    df2['BF_12M'] = df2[col].shift(12).fillna(0)

    return df2


# 세 번째 함수 생성
def third(df1, df2) :
    
    # df1에 trade 컬럼 생성
    df1['trade'] = ""
    # df1에 return 컬럼 생성
    df1['return'] = 1
    col = df1.columns[0]

    # momentum_index 구해서 d1에 거래내역 삽입
    for i in df2.index :

        signal = ''
        
        # df2 값을 이용하여 momentum_index 구하기
        momentum_index = df2.loc[i, 'BF_1M'] / df2.loc[i, 'BF_12M'] - 1

        # 조건식 생성
        flag = True if ((momentum_index > 0) and (momentum_index != -np.inf) and (momentum_index != np.inf)) else False

        if flag :
            signal = 'buy'
        
        # df1에 거래내역 삽입
        df1.loc[i, 'trade'] = signal

    rtn = 1.0
    buy = 0
    sell = 0

    # 수익률 계산
    for i in df1.index :
        if (df1.loc[i, 'trade'] == 'buy') and (df1.shift(1).loc[i, 'trade'] == '') :
            buy = df1.loc[i, col]
            print('구입일 :', i, '구입 가격 :', buy)
        elif (df1.loc[i, 'trade'] == '') and (df1.shift(1).loc[i, 'trade'] == 'buy') :
            sell = df1.loc[i, col]
            print('판매일 :', i, '판매 가격', sell)
            rtn = (sell - buy) / buy + 1
            df1.loc[i, 'return'] = rtn

    acc_rtn = 1.0

    # 누적 수익률 계산
    for i in df1.index :
        acc_rtn *= df1.loc[i, 'return']
        df1.loc[i, 'acc_rtn'] = acc_rtn
    print(acc_rtn)

    return df1