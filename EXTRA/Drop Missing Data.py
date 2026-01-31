import pandas as pd

def dropMissingData(students: pd.DataFrame) -> pd.DataFrame:
    """
    This function removes rows from the students DataFrame
    where the 'name' column has missing (None/NaN) values.

    Parameters:
    students (pd.DataFrame):
        A DataFrame containing:
        - student_id
        - name
        - age

    Returns:
    pd.DataFrame:
        A DataFrame with rows having missing 'name' values removed.
    """

    # dropna removes rows with missing values
    # subset=["name"] ensures we only check the 'name' column
    cleaned_students = students.dropna(subset=["name"])

    # Return the cleaned DataFrame
    return cleaned_students
