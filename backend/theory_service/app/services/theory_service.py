from app.models import Theory


def get_theories(topic=None, level=None):
    query = Theory.query
    if topic:
        query = query.filter_by(topic=topic)
    if level:
        query = query.filter_by(level=level)
    return query.all()


def get_theory_by_id(theory_id):
    return Theory.query.get(theory_id)
