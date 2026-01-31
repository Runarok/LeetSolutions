import pandas as pd

def fillMissingValues(products: pd.DataFrame) -> pd.DataFrame:
    """
    This function fills missing values in the 'quantity' column
    with 0 in the given products DataFrame.

    Parameters:
    products (pd.DataFrame):
        A DataFrame containing:
        - name
        - quantity (may contain missing values)
        - price

    Returns:
    pd.DataFrame:
        The same DataFrame with missing 'quantity' values replaced by 0.
    """

    # Use fillna to replace NaN/None values in the 'quantity' column with 0
    products["quantity"] = products["quantity"].fillna(0)

    # Return the modified DataFrame
    return products
