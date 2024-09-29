from threading import Lock


class ModelObject:
    # ------------------------------
    # Class fields
    # ------------------------------

    _lock: Lock
    _counter: int

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self):
        self._lock = Lock()
        self._counter = 0

    # ------------------------------
    # Class interaction
    # ------------------------------

    def get_and_inc_counter(self) -> int:
        with self.get_lock():
            value = self._counter
            self._counter += 1
        return value

    def get_and_inc_counter_unlocked(self) -> int:
        value = self._counter
        self._counter += 1
        return value

    def get_lock(self) -> Lock:
        return self._lock
