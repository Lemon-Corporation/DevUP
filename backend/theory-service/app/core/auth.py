from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from pydantic import BaseModel
from typing import Optional

from app.core.config import settings

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

class TokenData(BaseModel):
    """
    Модель данных токена, содержащая идентификатор пользователя и его роль.
    """
    sub: Optional[str] = None
    role: Optional[str] = None

def verify_token(token: str) -> TokenData:
    """
    Проверяет и декодирует JWT-токен.
    """
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        user_id: Optional[str] = payload.get("sub")
        if user_id is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid authentication credentials",
            )
        token_data = TokenData(sub=user_id, role=payload.get("role"))
        return token_data
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
        )

async def get_current_user(token: str = Depends(oauth2_scheme)) -> TokenData:
    """
    Проверяет токен и возвращает данные пользователя.
    """
    return verify_token(token)

async def get_current_admin(current_user: TokenData = Depends(get_current_user)) -> TokenData:
    """
    Убеждается, что пользователь имеет роль "admin".
    """
    if current_user.role != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough privileges",
        )
    return current_user
