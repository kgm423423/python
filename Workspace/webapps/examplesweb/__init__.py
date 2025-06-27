from flask import Flask, render_template,request

def create_app():

    app = Flask(__name__)

    @app.route("/")
    def index():
        # return"""<HTML>
        #             <body>
        #                 <h1 style='color:blue';>플라스크 기반 웹 프로그램입니다.</h1>
        #             </body>
        #         </HTML>"""
        return render_template('index.html')    
    
    @app.route("/process-data/", methods=["GET"])
    def process_get_data():
        data1 = request.args['data1']
        data2 = request.args['data2']
        print(f"\n\n\n{data1} {data2}")
        return f"입력받은 값은 {data1}, {data2} 입니다."
    
    @app.route("/process-data/", methods=["POST"])
    def process_post_data():
        data1 = request.form['data1']
        data2 = request.form['data2']
        print(f"\n\n\n{data1} {data2}")
        return f"입력받은 값은 {data1}, {data2} 입니다."
        
    return app