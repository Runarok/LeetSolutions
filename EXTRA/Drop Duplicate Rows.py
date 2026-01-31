import pandas as pd

def dropDuplicateEmails(customers: pd.DataFrame) -> pd.DataFrame:
    """
    This function removes duplicate rows from the customers DataFrame
    based on the 'email' column, keeping only the first occurrence.

    Parameters:
    customers (pd.DataFrame):
        A DataFrame containing:
        - customer_id
        - name
        - email

    Returns:
    pd.DataFrame:
        A DataFrame with duplicate emails removed,
        keeping the first occurrence of each email.
    """

    # Use drop_duplicates to remove duplicate rows
    # subset="email" specifies that duplicates are identified by email
    # keep="first" keeps the first occurrence (this is the default behavior)
    result = customers.drop_duplicates(subset="email", keep="first")

    # Return the cleaned DataFrame
    return result

