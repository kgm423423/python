from flask import Blueprint
from flask import render_template, redirect
from flask import request
from flask import url_for
from .. import data_util

import os
from pathlib import Path

import pandas as pd

data_bp = Blueprint('data', __name__, url_prefix="/data")

@data_bp.route('/titanic', methods=['GET'])
def titanic():
    # 파일에서 데이터 읽기
    # bp_path = data_bp.root_path # 현재 blueprint의 경로 ( 여기서는 views )
    # root_path = Path(bp_path).parent #  부모 경로 (여기서는 demoweb )
    # file_path = os.path.join(root_path, 'data_files', 'titanic-train.csv')
    # df_titanic = pd.read_csv(file_path)

    # 데이터베이스에서 데이터 읽기
    rows = data_util.select_titanic()
    df_titanic = pd.DataFrame(rows, columns=['PassengerId','Survived','Pclass','Name','Sex','Age','SibSp','Parch','Ticket','Fare','Cabin','Embarked'])

    # 템플릿으로 이동 ( 위에서 읽은 데이터 전달 )
    return render_template('data/titanic.html', df=df_titanic)

@data_bp.route('/init-titanic', methods=['GET'])
def init_titanic():
    # 파일에서 데이터 읽기
    bp_path = data_bp.root_path # 현재 blueprint의 경로 ( 여기서는 views )
    root_path = Path(bp_path).parent #  부모 경로 (여기서는 demoweb )
    file_path = os.path.join(root_path, 'data-files', 'titanic-train.csv')
    df_titanic = pd.read_csv(file_path)

    df_titanic['Age'] = df_titanic['Age'].fillna(df_titanic['Age'].mean())
    df_titanic['Cabin'] = df_titanic['Cabin'].fillna('')
    df_titanic['Embarked'] = df_titanic['Embarked'].fillna('')

    # 데이터베이스의 titanic 테이블 초기화
    data_util.create_titanic_table()
    data = df_titanic.values.tolist() # pymysql ... executemany가 list, tuple 만 처리
    data_util.insert_titanic_data(data)

    # 응답컨텐츠 생산 --> home으로 이동
    return redirect(url_for('main.index'))
