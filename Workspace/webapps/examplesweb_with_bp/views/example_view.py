from flask import Blueprint, request, render_template, redirect, url_for

example_bp = Blueprint("example", __name__, url_prefix="/example")

@example_bp.route("/process-data/", methods=['GET']) # /process-data 요청이 발생하면 호출할 함수 설정
def process_get_data():
    data1 = request.args['data1'] # request.args : get 방식으로 전달된 데이터 읽기
    data2 = request.args['data2']
    print(f"-----------------> {data1}, {data2}")
    return "<h2>GET 방식으로 전송된 데이터를 잘 읽었습니다.</h2>"

@example_bp.route("/process-data/", methods=['POST']) # /process-data 요청이 발생하면 호출할 함수 설정
def process_post_data():
    data1 = request.form['data1'] # request.form : post 방식으로 전달된 데이터 읽기
    data2 = request.form['data2']
    print(f"-----------------> {data1}, {data2}")
    return "<h2>POST 방식으로 전송된 데이터를 잘 읽었습니다.</h2>"

@example_bp.route("/path-variable/<name>", methods=['GET'])
def process_path_variable(name):
    print(f"-----------------> {name}")
    return "<h2>Path Variable 데이터를 잘 읽었습니다.</h2>"

@example_bp.route("/redirect/", methods=['GET'])
def process_redirect():
    target = url_for("example.redirect_target")
    return redirect(target)

@example_bp.route("/redirect-target/", methods=['GET'])
def redirect_target():
    return "<h2>redirect의 최종 목적지입니다.</h2>"