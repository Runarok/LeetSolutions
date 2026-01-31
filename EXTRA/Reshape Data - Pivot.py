import pandas as pd

def pivotTable(weather: pd.DataFrame) -> pd.DataFrame:
    """
    Pivot the weather DataFrame so that each row corresponds to a month,
    each city becomes a column, and the values are the temperatures.

    Parameters:
    weather (pd.DataFrame): 
        A DataFrame containing:
        - 'city' (object): name of the city
        - 'month' (object): name of the month
        - 'temperature' (int): temperature value

    Returns:
    pd.DataFrame: 
        A pivoted DataFrame with months as rows and cities as columns.
    """

    # Use pandas pivot to reshape the DataFrame:
    # - index="month": each row represents a month
    # - columns="city": each city becomes a separate column
    # - values="temperature": fill the table with temperature values
    return weather.pivot(
        index="month",
        columns="city", 
        values="temperature"
    )
