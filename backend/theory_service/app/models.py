import uuid

from app.db import db


class Theory(db.Model):
    __tablename__ = "theories"

    id = db.Column(db.UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    topic = db.Column(db.String(64), nullable=False)
    level = db.Column(db.String(32), nullable=False)
    title = db.Column(db.String(256), nullable=False)
    content = db.Column(db.Text, nullable=False)

    def to_dict(self):
        return {
            "id": str(self.id),
            "topic": self.topic,
            "level": self.level,
            "title": self.title,
            "content": self.content,
        }
