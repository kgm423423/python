from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "this is home"

if __name__ == "__main__":
    # app.debug = Ture
    app.run(debug = True)
