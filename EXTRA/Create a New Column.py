import pandas as pd

def createBonusColumn(employees: pd.DataFrame) -> pd.DataFrame:
    """
    This function creates a new column called 'bonus'
    by doubling the values in the 'salary' column.

    Parameters:
    employees (pd.DataFrame):
        A DataFrame containing:
        - name
        - salary

    Returns:
    pd.DataFrame:
        The same DataFrame with an additional column:
        - bonus (salary * 2)
    """

    # Create the 'bonus' column by multiplying
    # the 'salary' column by 2
    employees["bonus"] = employees["salary"] * 2

    # Return the updated DataFrame
    return employees
