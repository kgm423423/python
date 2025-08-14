from flask import Flask
import logging

from .views import main_views
from .views import model_views

def create_app():
    app = Flask(__name__)

    app.register_blueprint(main_views.main_bp)
    app.register_blueprint(model_views.models_bp)

    log = logging.getLogger('werkzeug')
    log.setLevel(logging.ERROR)
    
    return app