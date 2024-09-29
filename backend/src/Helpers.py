import os

from .Logger import Logger, LogLevel


def save_to_db(db_path: str, db_temp_path: str, model: str) -> None:
    Logger().log_info(f"Saving objects to DB: {db_path}", LogLevel.LOW_FREQ)

    # if db file exists - move it to backup
    if os.path.exists(db_path):
        if os.path.exists(db_temp_path):
            os.remove(db_temp_path)
        os.rename(db_path, db_temp_path)

    with open(db_path, "w") as f:
        f.write(model)

    Logger().log_info(f"Saved objects to db: {db_temp_path}", LogLevel.LOW_FREQ)


def load_from_db(db_path: str, db_temp_path: str, base_model_class) -> any:
    Logger().log_info("Loading objects from DB", LogLevel.LOW_FREQ)

    try:
        if os.path.exists(db_path):
            with open(db_path, "r") as f:
                result = base_model_class.model_validate_json(f.read())
                Logger().log_info(f"Loaded objects from db: {db_path}", LogLevel.LOW_FREQ)
                return result
    except Exception as e:
        Logger().log_error(f"Failed to load objects from DB ({db_path}): {e}", LogLevel.LOW_FREQ)

    # Try to load from backup
    Logger().log_error("Loading from backup", LogLevel.LOW_FREQ)
    try:
        if os.path.exists(db_temp_path):
            with open(db_temp_path, "r") as f:
                result = base_model_class.model_validate_json(f.read())
                Logger().log_info(f"Loaded objects from backup: {db_temp_path}", LogLevel.LOW_FREQ)
                return result
    except Exception as e:
        Logger().log_error(f"Failed to load objects from backup ({db_temp_path}): {e}", LogLevel.LOW_FREQ)

    return None
