from flask import Flask, render_template, request, redirect
from .views import example_view, index_view

def create_app():
    app = Flask(__name__)

    app.register_blueprint(index_view.index_bp)
    app.register_blueprint(example_view.example_bp)

    return app