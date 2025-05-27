FROM python:3.11 AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
FROM python:3.11
WORKDIR /app
COPY --from=build /usr/local /usr/local
ENV PATH="/usr/local/bin:$PATH"
COPY . .
USER nobody
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
