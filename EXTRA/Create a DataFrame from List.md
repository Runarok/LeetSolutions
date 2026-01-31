```python
import pandas as pd
from typing import List

def createDataframe(student_data: List[List[int]]) -> pd.DataFrame:
    """
    This function takes a 2D list containing student IDs and ages
    and converts it into a pandas DataFrame.

    Parameters:
    student_data (List[List[int]]): 
        A 2D list where:
        - Each inner list represents one student
        - The first value is the student ID
        - The second value is the student's age

    Returns:
    pd.DataFrame:
        A DataFrame with two columns:
        - 'student_id'
        - 'age'
        The rows appear in the same order as in student_data
    """

    # Create a pandas DataFrame from the 2D list
    # - student_data provides the actual row values
    # - columns specifies the column names and their order
    df = pd.DataFrame(
        student_data,              # The raw 2D list data
        columns=["student_id", "age"]  # Column names for the DataFrame
    )

    # Return the created DataFrame
    return df
```
