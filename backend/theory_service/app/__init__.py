from flasgger import Swagger, swag_from
from flask import Flask, jsonify

from .db import db, migrate


def create_app():
    app = Flask(__name__)
    app.config.from_object("config.Config")

    db.init_app(app)
    migrate.init_app(app, db)

    from .models import Theory  # Для миграций
    from .routes import theory_bp

    app.register_blueprint(theory_bp, url_prefix="/api/v1/theory")

    Swagger(
        app,
        config={
            "headers": [],
            "specs": [
                {
                    "endpoint": "apispec_1",
                    "route": "/docs/apispec_1.json",
                    "rule_filter": lambda rule: True,  # все маршруты
                    "model_filter": lambda tag: True,  # все модели
                }
            ],
            "static_url_path": "/flasgger_static",
            "swagger_ui": True,
            "specs_route": "/docs/",
        },
    )

    @app.errorhandler(400)
    def bad_request(error):
        return jsonify({"error": "Bad request", "message": str(error)}), 400

    @app.errorhandler(404)
    def not_found(error):
        return jsonify({"error": "Not found", "message": str(error)}), 404

    @app.errorhandler(500)
    def server_error(error):
        return jsonify({"error": "Internal server error", "message": str(error)}), 500

    return app
