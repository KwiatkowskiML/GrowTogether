from Logger import Logger, LogLevel
from ModelObject import ModelObject
from Models import EventModel, EventPay


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
        Logger().log_info(f"Event '{event.eventTitle}' added: {event.model_dump_json()}", LogLevel.LOW_FREQ)

    def get_all_events(self) -> list[EventModel]:
        Logger().log_info("Getting all events", LogLevel.LOW_FREQ)

        with self.get_lock():
            return list(self._events.values())

    def pay_for_event(self, pay: EventPay) -> None:
        Logger().log_info(f"Event '{pay.eventTitle}' paid: {pay.model_dump_json()}", LogLevel.LOW_FREQ)

        with self.get_lock():
            if pay.eventTitle not in self._events:
                raise ValueError(f"Event with title '{pay.eventTitle}' not found")

            self._events[pay.eventTitle].eventCurrentMoney += pay.payAmount
            self._events[pay.eventTitle].eventContributionsNumber += 1

        Logger().log_info("Event correctly paid", LogLevel.LOW_FREQ)
