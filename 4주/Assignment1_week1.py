'''
Assignment #1 _ 3주차 실습 코드 개선

    - 헤더 레코드 추가되는 문제 해결
        -> transform에 적용
    - Idempotent하게 잡을 만들기
        -> load에 적용
    - Transaction 사용해보기
        -> load에 적용
'''

import requests


def extract(url):
    f = requests.get(url)
    return f.text


def transform(text):
    lines = text.split("\n")[1:]
    return lines


def load(lines):
    cur = get_Redshift_connection()  # 생략
    sql = """
    BEGIN;
    TRUNCATE plerin152.name_gender;
    """
    for r in lines:
        if r != '':
        (name, gender) = r.split(",")
        sql += "\nINSERT INTO plerin152.name_gender VALUES ('{n}', '{g}');".format(
            n=name, g=gender)

    sql += "\nCOMMIT;"
    cur.execute(sql)
