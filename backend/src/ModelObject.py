from threading import Lock


class ModelObject:
    # ------------------------------
    # Class fields
    # ------------------------------

    _lock: Lock

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self):
        self._lock = Lock()

    # ------------------------------
    # Class interaction
    # ------------------------------

    def get_lock(self) -> Lock:
        return self._lock
