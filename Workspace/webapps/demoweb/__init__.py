from flask import Flask, render_template

from .views import main_view
from .views import data_view

def create_app():
    app = Flask(__name__)

    app.register_blueprint(main_view.main_bp)
    app.register_blueprint(data_view.data_bp)

    return app