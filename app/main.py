from fastapi import FastAPI
from app.api.routes import router

app = FastAPI(title="Atlas Toy")
app.include_router(router)

@app.get("/health")
async def health():
    return {"ok": True}