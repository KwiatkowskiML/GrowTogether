from datetime import datetime
from typing import Optional

from pydantic import BaseModel, EmailStr


class EventModel(BaseModel):
    eventTitle: str
    eventOwnerName: str
    eventOwnerId: int
    eventGoal: float
    eventCurrentMoney: float
    eventContributionsNumber: int
    eventLat: float
    eventLon: float
    eventDesc: str
    eventStartDate: datetime
    eventEndDate: datetime
    eventOwnerContactMail: EmailStr
    eventBenefitDesc: Optional[str] = None


class CommandResponse(BaseModel):
    result: str


class EventPay(BaseModel):
    eventName: str
    eventAmount: float
    userId: int


class AllEventsResponse(BaseModel):
    events: list[EventModel]
    result: str


class UserModel(BaseModel):
    userMail: EmailStr
    userPassword: str
    userId: int
    userEventPays: list[EventPay]
    userEvents: list[str]


class UserLogin(BaseModel):
    userMail: EmailStr
    userPassword: str


class UserLoginResponse(BaseModel):
    userId: int
    result: str


class UserRequest(BaseModel):
    userId: int


class UserEventsResponse(BaseModel):
    userEvents: list[EventModel]
    result: str


class UserEventPaysResponse(BaseModel):
    userEventPays: list[EventPay]
    result: str
