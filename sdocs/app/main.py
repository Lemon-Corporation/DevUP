import os
from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import markdown
import pathlib

app = FastAPI(
    title="DevUP Documentation",
    description="Документация проекта DevUP",
    version="1.0.0",
)

# Настраиваем директории для статических файлов и шаблонов
base_dir = pathlib.Path(__file__).parent.parent
templates = Jinja2Templates(directory=str(base_dir / "app" / "templates"))
docs_dir = base_dir / "docs"

# Монтируем статические файлы
app.mount("/static", StaticFiles(directory=str(base_dir / "app" / "static")), name="static")

@app.get("/", response_class=HTMLResponse)
async def root(request: Request):
    """Главная страница с индексом документации"""
    # Индекс документации
    index_path = docs_dir / "index.md"
    if not index_path.exists():
        return templates.TemplateResponse(
            "error.html", 
            {"request": request, "message": "Индекс документации не найден"}
        )
    
    content = index_path.read_text(encoding="utf-8")
    html_content = markdown.markdown(content, extensions=['fenced_code', 'tables'])
    
    # Получаем список всех доступных документов
    docs = []
    for path in docs_dir.glob("**/*.md"):
        if path.name != "index.md":
            rel_path = path.relative_to(docs_dir)
            docs.append({
                "name": path.stem.title().replace('-', ' '),
                "path": f"/docs/{rel_path.as_posix().replace('.md', '')}"
            })
    
    return templates.TemplateResponse(
        "doc.html", 
        {
            "request": request, 
            "title": "DevUP Документация", 
            "content": html_content,
            "docs": docs
        }
    )

@app.get("/docs/{path:path}", response_class=HTMLResponse)
async def get_doc(request: Request, path: str):
    """Страница с документацией по указанному пути"""
    file_path = docs_dir / f"{path}.md"
    if not file_path.exists() and not file_path.is_file():
        raise HTTPException(status_code=404, detail="Документ не найден")
    
    content = file_path.read_text(encoding="utf-8")
    html_content = markdown.markdown(content, extensions=['fenced_code', 'tables'])
    
    # Получаем список всех доступных документов
    docs = []
    for doc_path in docs_dir.glob("**/*.md"):
        if doc_path.name != "index.md":
            rel_path = doc_path.relative_to(docs_dir)
            docs.append({
                "name": doc_path.stem.title().replace('-', ' '),
                "path": f"/docs/{rel_path.as_posix().replace('.md', '')}"
            })
    
    return templates.TemplateResponse(
        "doc.html", 
        {
            "request": request, 
            "title": path.split('/')[-1].title().replace('-', ' '), 
            "content": html_content,
            "docs": docs
        }
    )

@app.get("/health")
async def health():
    """Эндпоинт для проверки работоспособности сервиса"""
    return {"status": "ok"} 