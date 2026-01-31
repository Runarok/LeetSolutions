import pandas as pd

def changeDatatype(students: pd.DataFrame) -> pd.DataFrame:
    """
    This function converts the 'grade' column from float to int
    in the given students DataFrame.

    Parameters:
    students (pd.DataFrame):
        A DataFrame containing:
        - student_id
        - name
        - age
        - grade (currently float)

    Returns:
    pd.DataFrame:
        The same DataFrame with the 'grade' column converted to int.
    """

    # Convert the 'grade' column to integer using astype(int)
    students["grade"] = students["grade"].astype(int)

    # Return the modified DataFrame
    return students
