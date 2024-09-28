import os

from pydantic import BaseModel

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

        self._events = {}
        self._load_events_from_db()

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
            self._save_events_to_db_unlocked()
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

            self._events[pay.eventName].eventCurrentMoney += pay.eventAmount
            self._events[pay.eventName].eventContributionsNumber += 1
            self._save_events_to_db_unlocked()

        Logger().log_info("Event correctly paid", LogLevel.LOW_FREQ)

    # ------------------------------
    # Private methods
    # ------------------------------

    def _save_events_to_db_unlocked(self) -> None:
        Logger().log_info("Saving events to DB", LogLevel.LOW_FREQ)

        # if db file exists - move it to backup
        if os.path.exists(DB_PATH):
            if os.path.exists(DB_PATH_TMP):
                os.remove(DB_PATH_TMP)
            os.rename(DB_PATH, DB_PATH_TMP)

        with open(DB_PATH, "w") as f:
            f.write(EventMgrModel(events=self._events).model_dump_json(indent=2))

        Logger().log_info(f"Saved {len(self._events)} events to db", LogLevel.LOW_FREQ)

    def _load_events_from_db(self) -> None:
        Logger().log_info("Loading events from DB", LogLevel.LOW_FREQ)

        with self.get_lock():
            try:
                if os.path.exists(DB_PATH):
                    with open(DB_PATH, "r") as f:
                        self._events = EventMgrModel.model_validate_json(f.read()).events
                        Logger().log_info(f"Loaded {len(self._events)} events from db", LogLevel.LOW_FREQ)
                        return
            except Exception as e:
                Logger().log_error(f"Failed to load events from DB: {e}", LogLevel.LOW_FREQ)

            # Try to load from backup
            Logger().log_error("Loading from backup", LogLevel.LOW_FREQ)
            try:
                if os.path.exists(DB_PATH_TMP):
                    with open(DB_PATH_TMP, "r") as f:
                        self._events = EventMgrModel.model_validate_json(f.read()).events
                        Logger().log_info(f"Loaded {len(self._events)} events from backup", LogLevel.LOW_FREQ)
                        return
            except Exception as e:
                Logger().log_error(f"Failed to load events from backup: {e}", LogLevel.LOW_FREQ)

            self._events = {}
