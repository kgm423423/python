import pymysql

login = ["localhost", "demoweb", "root", "235700"]

def create_titanic_table():
    conn = None
    cursor = None
    try:
        conn = pymysql.connect(host=login[0], 
                               database=login[1], 
                               user=login[2], 
                               password=login[3])
        cursor = conn.cursor()
        cursor.execute("drop table if exists titanic")
        cursor.execute("""
            create table if not exists titanic (
                PassengerId int not null primary key,
                Survived boolean not null,
                Pclass int null,
                Name varchar(100) null,
                Sex varchar(10) null,
                Age float null,
                SibSp int null,
                Parch int null,
                Ticket varchar(50) null,
                Fare float null,
                Cabin varchar(100) null,
                Embarked char(1) null
            )
        """)
    except Exception as e:
        print('테이블 생성 실패:', e)
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def insert_titanic_data(data):
    conn = None
    cursor = None
    try:
        conn = pymysql.connect(host=login[0], 
                               database=login[1], 
                               user=login[2], 
                               password=login[3])
        cursor = conn.cursor()
        sql = "insert into titanic values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        cursor.executemany(sql, data)
        conn.commit()
    except Exception as e:
        print('데이터 저장 실패:', e)
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def select_titanic():
    conn = None
    cursor = None
    rows = None
    try:
        conn = pymysql.connect(host=login[0], 
                               database=login[1], 
                               user=login[2], 
                               password=login[3])
        cursor = conn.cursor()
        cursor.execute("select * from titanic")
        rows = cursor.fetchall()
    except Exception as e:
        print('데이터 조회 실패:', e)
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
    return rows
