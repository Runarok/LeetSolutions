import pandas as pd

def selectFirstRows(employees: pd.DataFrame) -> pd.DataFrame:
    """
    This function returns the first 3 rows of the employees DataFrame.

    Parameters:
    employees (pd.DataFrame):
        A DataFrame containing employee information such as:
        - employee_id
        - name
        - department
        - salary

    Returns:
    pd.DataFrame:
        A DataFrame containing only the first 3 rows
        of the original employees DataFrame.
    """

    # Use the DataFrame.head() method
    # head(3) selects the first 3 rows
    first_three_rows = employees.head(3)

    # Return the resulting DataFrame
    return first_three_rows
