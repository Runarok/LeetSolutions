import pandas as pd

def concatenateTables(df1: pd.DataFrame, df2: pd.DataFrame) -> pd.DataFrame:
    """
    This function vertically concatenates two DataFrames
    with the same columns into a single DataFrame.

    Parameters:
    df1 (pd.DataFrame): First DataFrame
    df2 (pd.DataFrame): Second DataFrame

    Returns:
    pd.DataFrame: A new DataFrame containing all rows from df1 and df2
                  stacked vertically, with the same columns.
    """

    # Use pd.concat to stack the DataFrames vertically
    # axis=0 means concatenate along rows
    # ignore_index=True resets the row index in the new DataFrame
    combined_df = pd.concat([df1, df2], axis=0, ignore_index=True)

    # Return the combined DataFrame
    return combined_df

