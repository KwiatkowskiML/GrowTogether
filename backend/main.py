from fastapi import FastAPI
from models import EventModel
app = FastAPI()

@app.get("/events/add")
async def say_hello(model: EventModel):
    return {"message": f"Hello {name}"}
