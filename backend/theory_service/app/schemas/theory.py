from marshmallow import Schema, fields


class TheorySchema(Schema):
    id = fields.UUID(required=True)
    topic = fields.Str(required=True)
    level = fields.Str(required=True)
    title = fields.Str(required=True)
    content = fields.Str(required=True)
