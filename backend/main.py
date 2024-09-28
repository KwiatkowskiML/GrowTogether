from contextlib import asynccontextmanager

from fastapi import FastAPI

from Components import Components
from Models import EventModel, CommandResponse, AllEventsResponse, EventPay


def startup():
    Components().init_components()


def cleanup():
    Components().destroy_components()


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Process starting actions
    startup()
    yield

    # Process stopping actions
    cleanup()


app = FastAPI(lifespan=lifespan)


@app.post("/events/add")
async def add_event(model: EventModel) -> CommandResponse:
    try:
        Components().get_event_mgr().add_event(model)
    except Exception as e:
        return CommandResponse(result=f"{e}")
    return CommandResponse(result="SUCCESS")


@app.get("/events/get_all")
async def get_all_events() -> AllEventsResponse:
    return AllEventsResponse(events=Components().get_event_mgr().get_all_events(), result="SUCCESS")


@app.post("/events/pay")
async def pay_for_event(pay: EventPay) -> CommandResponse:
    try:
        Components().get_event_mgr().pay_for_event(pay)
    except Exception as e:
        return CommandResponse(result=f"{e}")
    return CommandResponse(result="SUCCESS")
