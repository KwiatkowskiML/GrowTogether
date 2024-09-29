from typing import TYPE_CHECKING, Union

from .GlobalObj import GlobalObj
from .Logger import Logger, LogLevel

if TYPE_CHECKING:
    from .EventMgr import EventMgr
    from .UserMgr import UserMgr

LOGGER_PATH = "log.txt"


class Components(metaclass=GlobalObj):
    # ------------------------------
    # Class fields
    # ------------------------------

    _event_mgr: Union['EventMgr', None]
    _user_mgr: Union['UserMgr', None]

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self):
        self._event_mgr = None
        self._user_mgrs = None

    # ------------------------------
    # Class interaction
    # ------------------------------

    def init_components(self) -> None:
        from .EventMgr import EventMgr
        from .UserMgr import UserMgr

        Logger(LOGGER_PATH, True, LogLevel.MEDIUM_FREQ)
        self._event_mgr = EventMgr()
        self._user_mgr = UserMgr()

    def destroy_components(self) -> None:
        if self._event_mgr:
            self._event_mgr.destroy()

        if self._user_mgr:
            self._user_mgr.destroy()

        Logger().destroy()

    def is_inited(self) -> bool:
        return self._event_mgr is not None and self._user_mgr is not None

    def get_event_mgr(self) -> Union['EventMgr', None]:
        return self._event_mgr

    def get_user_mgr(self) -> Union['UserMgr', None]:
        return self._user_mgr
