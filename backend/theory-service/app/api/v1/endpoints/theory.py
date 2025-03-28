from fastapi import APIRouter, Request, HTTPException, Depends
from typing import List
from app.schemas.models import TheoryMaterial, TheoryMaterialCreate, TheoryMaterialUpdate
from app.core.auth import get_current_user, get_current_admin

router = APIRouter()

@router.get("/theory", response_model=List[TheoryMaterial])
async def get_all_theory_materials(request: Request):
    """
    Возвращает список всех теоретических материалов.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        rows = await conn.fetch("SELECT id, title, content FROM theory_materials ORDER BY id;")
    return [TheoryMaterial(**dict(row)) for row in rows]

@router.get("/theory/{material_id}", response_model=TheoryMaterial)
async def get_theory_material(material_id: int, request: Request):
    """
    Возвращает теоретический материал по его ID.
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        row = await conn.fetchrow(
            "SELECT id, title, content FROM theory_materials WHERE id = $1;",
            material_id
        )
        if not row:
            raise HTTPException(status_code=404, detail="Материал не найден.")
    return TheoryMaterial(**dict(row))

@router.post("/theory", response_model=TheoryMaterial)
async def create_theory_material(
    new_material: TheoryMaterialCreate,
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Создает новый теоретический материал (доступно только администратору).
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        row = await conn.fetchrow(
            """
            INSERT INTO theory_materials (title, content)
            VALUES ($1, $2)
            RETURNING id, title, content;
            """,
            new_material.title, new_material.content
        )
    return TheoryMaterial(**dict(row))

@router.put("/theory/{material_id}", response_model=TheoryMaterial)
async def update_theory_material(
    material_id: int,
    updated_material: TheoryMaterialUpdate,
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Обновляет существующий теоретический материал (доступно только администратору).
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        row = await conn.fetchrow(
            """
            UPDATE theory_materials
            SET title = COALESCE($1, title),
                content = COALESCE($2, content)
            WHERE id = $3
            RETURNING id, title, content;
            """,
            updated_material.title, updated_material.content, material_id
        )
        if not row:
            raise HTTPException(status_code=404, detail="Материал для обновления не найден.")
    return TheoryMaterial(**dict(row))

@router.delete("/theory/{material_id}")
async def delete_theory_material(
    material_id: int,
    request: Request,
    current_admin=Depends(get_current_admin)
):
    """
    Удаляет теоретический материал по ID (доступно только администратору).
    """
    db_pool = request.app.state.db_pool
    async with db_pool.acquire() as conn:
        result = await conn.execute(
            "DELETE FROM theory_materials WHERE id = $1;",
            material_id
        )
    # result возвращает строку формата 'DELETE X', где X – число удалённых строк
    if result == "DELETE 0":
        raise HTTPException(status_code=404, detail="Материал для удаления не найден.")
    return {"status": "ok", "message": f"Материал с ID {material_id} удалён."}
