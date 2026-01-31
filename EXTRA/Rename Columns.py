import pandas as pd

def renameColumns(students: pd.DataFrame) -> pd.DataFrame:
    """
    This function renames the columns of the students DataFrame
    according to the specified mapping.

    Parameters:
    students (pd.DataFrame):
        A DataFrame containing columns:
        - id
        - first
        - last
        - age

    Returns:
    pd.DataFrame:
        The same DataFrame with columns renamed to:
        - id -> student_id
        - first -> first_name
        - last -> last_name
        - age -> age_in_years
    """

    # Use the rename method with a dictionary mapping old column names to new ones
    renamed_students = students.rename(
        columns={
            "id": "student_id",
            "first": "first_name",
            "last": "last_name",
            "age": "age_in_years"
        }
    )

    # Return the DataFrame with renamed columns
    return renamed_students
