import pandas as pd
from typing import List

def getDataframeSize(players: pd.DataFrame) -> List[int]:
    """
    This function calculates the size of a pandas DataFrame.

    Parameters:
    players (pd.DataFrame):
        A DataFrame containing player information.
        Each row represents one player.
        Each column represents an attribute (e.g., name, age, position).

    Returns:
    List[int]:
        A list containing:
        - Number of rows in the DataFrame
        - Number of columns in the DataFrame
        Format: [rows, columns]
    """

    # Use the DataFrame's shape attribute
    # shape returns a tuple: (number_of_rows, number_of_columns)
    rows, columns = players.shape

    # Return the result as a list, as required
    return [rows, columns]
