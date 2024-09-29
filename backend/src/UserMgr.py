import re

from pydantic import BaseModel

from .Components import Components
from .Helpers import load_from_db, save_to_db
from .Logger import Logger, LogLevel
from .ModelObject import ModelObject
from .Models import UserModel, UserLogin, EventPay, EventModel

DB_PATH = "./users.db"
DB_PATH_TMP = "./users.db.tmp"


class UserMgrModel(BaseModel):
    users: dict[str, UserModel]


class UserMgr(ModelObject):
    # ------------------------------
    # Class fields
    # ------------------------------

    _users: dict[str, UserModel]
    _users_id: dict[int, UserModel]

    # ------------------------------
    # Class creation
    # ------------------------------

    def __init__(self) -> None:
        super().__init__()

        loaded = load_from_db(DB_PATH, DB_PATH_TMP, UserMgrModel)

        if loaded is None:
            self._users = {}
        else:
            self._users = loaded.users
        self._users_id = {}

        for user in self._users.values():
            self._users_id[user.userId] = user

        Logger().log_info("UserMgr created", LogLevel.LOW_FREQ)

    def destroy(self) -> None:
        Logger().log_info("UserMgr destroyed", LogLevel.LOW_FREQ)

    # ------------------------------
    # Class interaction
    # ------------------------------

    def add_user(self, request: UserLogin) -> int:
        Logger().log_info(f"Adding user: {request.model_dump_json()}", LogLevel.LOW_FREQ)

        with self.get_lock():
            # Email validation
            if not re.match(r"[^@]+@[^@]+\.[^@]+", request.userMail):
                raise ValueError("Invalid email format")

            if request.userMail in self._users:
                raise ValueError(f"User with mail '{request.userMail}' already exists")

            user_id = self.get_and_inc_counter_unlocked()
            user = UserModel(userMail=request.userMail, userPassword=request.userPassword, userId=user_id,
                             userEventPays=[], userEvents=[])

            self._users[request.userMail] = user
            self._users_id[user_id] = user

            Logger().log_info(f"User '{request.userMail}' added: {user.model_dump_json()}", LogLevel.LOW_FREQ)

            save_to_db(DB_PATH, DB_PATH_TMP, UserMgrModel(users=self._users).model_dump_json(indent=2))

            return user_id

    def get_user_pays(self, user_id: int) -> list[EventPay]:
        with self.get_lock():
            if user_id not in self._users_id:
                raise ValueError(f"User not found")

            return self._users_id[user_id].userEventPays

    def get_user_events(self, user_id: int) -> list[EventModel]:
        with self.get_lock():
            if user_id not in self._users_id:
                raise ValueError(f"User not found")

            rv = []
            for event in self._users_id[user_id].userEvents:
                model = Components().get_event_mgr().get_event(event)
                if model:
                    rv.append(model)

            return rv

    def add_user_event(self, user_id: int, event_name: str) -> None:
        if user_id not in self._users_id:
            raise ValueError(f"User not found")

        with self.get_lock():
            self._users_id[user_id].userEvents.append(event_name)
            save_to_db(DB_PATH, DB_PATH_TMP, UserMgrModel(users=self._users).model_dump_json(indent=2))

    def add_user_pay(self, user_id: int, pay: EventPay) -> None:
        if user_id not in self._users_id:
            raise ValueError(f"User not found")

        with self.get_lock():
            self._users_id[user_id].userEventPays.append(pay)
            save_to_db(DB_PATH, DB_PATH_TMP, UserMgrModel(users=self._users).model_dump_json(indent=2))

    def login_user(self, request: UserLogin) -> int:
        with self.get_lock():
            if not re.match(r"[^@]+@[^@]+\.[^@]+", request.userMail):
                raise ValueError("Invalid email format")

            if request.userMail not in self._users:
                raise ValueError(f"User with mail '{request.userMail}' not found")

            if self._users[request.userMail].userPassword != request.userPassword:
                raise ValueError("Wrong password")

            return self._users[request.userMail].userId

    # ------------------------------
    # Private methods
    # ------------------------------
