from pydantic import BaseModel

class TheoryMaterial(BaseModel):
    """
    Модель для представления теоретического материала.
    """
    id: int
    title: str
    content: str

class TheoryMaterialCreate(BaseModel):
    """
    Модель для создания нового теоретического материала.
    """
    title: str
    content: str

class TheoryMaterialUpdate(BaseModel):
    """
    Модель для обновления существующего теоретического материала.
    """
    title: str | None = None
    content: str | None = None
