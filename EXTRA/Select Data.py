import pandas as pd

def selectData(students: pd.DataFrame) -> pd.DataFrame:
    """
    This function selects the name and age of the student
    whose student_id is equal to 101.

    Parameters:
    students (pd.DataFrame):
        A DataFrame containing:
        - student_id
        - name
        - age

    Returns:
    pd.DataFrame:
        A DataFrame with two columns:
        - name
        - age
        containing only the row where student_id == 101.
    """

    # Filter the DataFrame to keep only rows
    # where the student_id is equal to 101
    filtered_students = students[students["student_id"] == 101]

    # Select only the 'name' and 'age' columns
    result = filtered_students[["name", "age"]]

    # Return the final DataFrame
    return result
