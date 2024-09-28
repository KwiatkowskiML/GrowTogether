from typing import TYPE_CHECKING, Union

from GlobalObj import GlobalObj
from Logger import Logger, LogLevel

if TYPE_CHECKING:
    from .EventMgr import EventMgr

LOGGER_PATH = "log.txt"


class Components(metaclass=GlobalObj):
    # ------------------------------
    # Class fields
    # ------------------------------

    _event_mgr: Union['EventMgr', None]

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self):
        self._event_mgr = None

    # ------------------------------
    # Class interaction
    # ------------------------------

    def init_components(self) -> None:
        from .EventMgr import EventMgr

        Logger(LOGGER_PATH, True, LogLevel.MEDIUM_FREQ)
        self._event_mgr = EventMgr()

    def destroy_components(self) -> None:
        if self._event_mgr:
            self._event_mgr.destroy()

        Logger().destroy()

    def is_inited(self) -> bool:
        return self._event_mgr is not None

    def get_event_mgr(self) -> Union['EventMgr', None]:
        return self._event_mgr
