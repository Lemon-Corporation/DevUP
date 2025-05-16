import sqlalchemy
from flasgger import swag_from
from flask import Blueprint, abort, current_app, jsonify, request

from app.db import db
from app.schemas.theory import TheorySchema
from app.services.theory_service import get_theories, get_theory_by_id

theory_bp = Blueprint("theory", __name__)

theory_schema = TheorySchema()
theories_schema = TheorySchema(many=True)


@theory_bp.route("/", methods=["GET"])
@swag_from(
    {
        "responses": {
            200: {
                "description": "Список теоретических материалов",
                "examples": {
                    "application/json": [
                        {
                            "id": "uuid",
                            "topic": "algorithms",
                            "level": "junior",
                            "title": "Сортировка пузырьком",
                            "content": "Описание алгоритма...",
                        }
                    ]
                },
            }
        },
        "parameters": [
            {
                "name": "topic",
                "in": "query",
                "type": "string",
                "required": False,
                "description": "Тема (algorithms, databases)",
            },
            {
                "name": "level",
                "in": "query",
                "type": "string",
                "required": False,
                "description": "Уровень (junior, middle)",
            },
            {
                "name": "limit",
                "in": "query",
                "type": "integer",
                "required": False,
                "description": "Максимум записей (по умолчанию 20)",
            },
            {
                "name": "offset",
                "in": "query",
                "type": "integer",
                "required": False,
                "description": "Смещение (по умолчанию 0)",
            },
        ],
    }
)
def get_theories_route():
    topic = request.args.get("topic")
    level = request.args.get("level")
    try:
        limit = int(request.args.get("limit", 20))
        offset = int(request.args.get("offset", 0))
    except ValueError:
        abort(400, description="limit and offset must be integers")
    if limit < 1 or limit > 100:
        abort(400, description="limit must be between 1 and 100")
    if offset < 0:
        abort(400, description="offset must be >= 0")
    theories = get_theories(topic, level)
    paginated = theories[offset : offset + limit]
    return jsonify(theories_schema.dump(paginated)), 200


@theory_bp.route("/<uuid:theory_id>", methods=["GET"])
def get_theory_route(theory_id):
    """
    Получение материала по ID
    ---
    parameters:
      - name: theory_id
        in: path
        type: string
        required: true
        description: ID материала (UUID)
    responses:
      200:
        description: Детали теоретического материала
        examples:
          application/json:
            id: "uuid"
            topic: "algorithms"
            level: "junior"
            title: "Сортировка пузырьком"
            content: "Описание алгоритма..."
      404:
        description: Материал не найден
    """
    theory = get_theory_by_id(theory_id)
    if not theory:
        abort(404, description="Theory not found")
    return jsonify(theory_schema.dump(theory)), 200


@theory_bp.route("/health", methods=["GET"])
def healthcheck():
    try:
        db.session.execute(sqlalchemy.text("SELECT 1"))
        db_status = "up"
    except Exception:
        db_status = "down"
    return jsonify({"status": "ok", "db": db_status}), 200
