from pydantic import BaseModel

from .Components import Components
from .Helpers import save_to_db, load_from_db
from .Logger import Logger, LogLevel
from .ModelObject import ModelObject
from .Models import EventModel, EventPay

DB_PATH = "./events.db"
DB_PATH_TMP = "./events.db.tmp"


class EventMgrModel(BaseModel):
    events: dict[str, EventModel]


class EventMgr(ModelObject):
    # ------------------------------
    # Class fields
    # ------------------------------

    _events: dict[str, EventModel]

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self) -> None:
        super().__init__()

        loaded = load_from_db(DB_PATH, DB_PATH_TMP, EventMgrModel)

        if loaded is None:
            self._events = {}
        else:
            self._events = loaded.events

        Logger().log_info("EventMgr created", LogLevel.LOW_FREQ)

    def destroy(self) -> None:
        Logger().log_info("EventMgr destroyed", LogLevel.LOW_FREQ)

    # ------------------------------
    # Class interaction
    # ------------------------------

    def add_event(self, event: EventModel) -> None:
        with self.get_lock():
            if event.eventTitle in self._events:
                raise ValueError(f"Event with title '{event.eventTitle}' already exists")

            self._events[event.eventTitle] = event
            save_to_db(DB_PATH, DB_PATH_TMP, EventMgrModel(events=self._events).model_dump_json(indent=2))
        Logger().log_info(f"Event '{event.eventTitle}' added: {event.model_dump_json()}", LogLevel.LOW_FREQ)

    def get_all_events(self) -> list[EventModel]:
        Logger().log_info("Getting all events", LogLevel.LOW_FREQ)

        with self.get_lock():
            return list(self._events.values())

    def pay_for_event(self, pay: EventPay) -> None:
        Logger().log_info(f"Event '{pay.eventName}' paid: {pay.model_dump_json()}", LogLevel.LOW_FREQ)

        with self.get_lock():
            if pay.eventName not in self._events:
                raise ValueError(f"Event with title '{pay.eventName}' not found")

            Components().get_user_mgr().add_user_pay(pay.userId, pay)

            self._events[pay.eventName].eventCurrentMoney += pay.eventAmount
            self._events[pay.eventName].eventContributionsNumber += 1

            save_to_db(DB_PATH, DB_PATH_TMP, EventMgrModel(events=self._events).model_dump_json(indent=2))

        Logger().log_info("Event correctly paid", LogLevel.LOW_FREQ)

    def get_event(self, name: str) -> EventModel | None:
        with self.get_lock():
            if name not in self._events:
                return None
            return self._events[name]

    # ------------------------------
    # Private methods
    # ------------------------------
