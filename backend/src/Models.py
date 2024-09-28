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


class AllEventsResponse(BaseModel):
    events: list[EventModel]
    result: str
