from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from pydantic import BaseModel
from typing import Optional

from app.core.config import settings

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


class TokenData(BaseModel):
    """
    Модель данных из JWT:
    - sub: идентификатор пользователя
    - role: роль пользователя ("user" или "admin")
    """
    sub: Optional[str] = None
    role: Optional[str] = None


def verify_token(token: str) -> TokenData:
    """
    Декодирует и проверяет JWT-токен.

    Args:
        token (str): JWT из заголовка Authorization.

    Returns:
        TokenData: данные пользователя из токена.

    Raises:
        HTTPException: если токен некорректен.
    """
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        user_id = payload.get("sub")
        if not user_id:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                detail="Invalid authentication credentials")
        return TokenData(sub=user_id, role=payload.get("role"))
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Could not validate credentials")


async def get_current_user(token: str = Depends(oauth2_scheme)) -> TokenData:
    """
    Зависимость FastAPI: возвращает TokenData текущего пользователя.
    """
    return verify_token(token)


async def get_current_admin(current_user: TokenData = Depends(get_current_user)) -> TokenData:
    """
    Зависимость FastAPI: проверяет, что роль пользователя — "admin".

    Args:
        current_user (TokenData): данные из get_current_user.

    Raises:
        HTTPException: если роль не "admin".
    """
    if current_user.role != "admin":
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail="Not enough privileges")
    return current_user
