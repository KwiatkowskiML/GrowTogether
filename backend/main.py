from contextlib import asynccontextmanager

import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.Components import Components
from src.Models import EventModel, CommandResponse, AllEventsResponse, EventPay, UserLoginResponse, \
    UserLogin, UserEventsResponse, UserRequest, UserEventPaysResponse


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

origins = [
    '*'
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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


@app.post("/users/register")
async def register_user(model: UserLogin) -> UserLoginResponse:
    try:
        ident = Components().get_user_mgr().add_user(model)
        return UserLoginResponse(result="SUCCESS", userId=ident)
    except Exception as e:
        return UserLoginResponse(result=f"{e}", userId=-1)


@app.post("/users/login")
async def login_user(model: UserLogin) -> UserLoginResponse:
    try:
        ident = Components().get_user_mgr().login_user(model)
        return UserLoginResponse(result="SUCCESS", userId=ident)
    except Exception as e:
        return UserLoginResponse(result=f"{e}", userId=-1)


@app.post("/users/get_events")
async def get_user_events(model: UserRequest) -> UserEventsResponse:
    try:
        events = Components().get_user_mgr().get_user_events(model.userId)
        return UserEventsResponse(result="SUCCESS", userEvents=events)
    except Exception as e:
        return UserEventsResponse(result=f"{e}", userEvents=[])


@app.post("/users/get_pays")
async def get_user_pays(model: UserRequest) -> UserEventPaysResponse:
    try:
        pays = Components().get_user_mgr().get_user_pays(model.userId)
        return UserEventPaysResponse(result="SUCCESS", userEventPays=pays)
    except Exception as e:
        return UserEventPaysResponse(result=f"{e}", userEventPays=[])


if __name__ == '__main__':
    # Run the FastAPI app using Uvicorn, setting host and port
    uvicorn.run(app, host="0.0.0.0", port=80)
