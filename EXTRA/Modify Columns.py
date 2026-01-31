import pandas as pd

def modifySalaryColumn(employees: pd.DataFrame) -> pd.DataFrame:
    """
    This function doubles the values in the 'salary' column
    to reflect a pay rise for each employee.

    Parameters:
    employees (pd.DataFrame):
        A DataFrame containing:
        - name (employee's name)
        - salary (current salary)

    Returns:
    pd.DataFrame:
        The same DataFrame with the 'salary' column modified
        to be twice its original value.
    """

    # Multiply the 'salary' column by 2
    # This modifies the DataFrame in-place
    employees["salary"] = employees["salary"] * 2

    # Return the updated DataFrame
    return employees
