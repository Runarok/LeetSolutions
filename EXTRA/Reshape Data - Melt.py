import pandas as pd

def meltTable(report: pd.DataFrame) -> pd.DataFrame:
    """
    Reshape the sales report from wide format to long format.
    Each row will represent the sales of a product in a specific quarter.

    Parameters:
    report (pd.DataFrame):
        A DataFrame with columns:
        - 'product'
        - 'quarter_1', 'quarter_2', 'quarter_3', 'quarter_4'

    Returns:
    pd.DataFrame:
        A long-format DataFrame with columns:
        - 'product': name of the product
        - 'quarter': which quarter (quarter_1, quarter_2, etc.)
        - 'sales': sales amount
    """

    # Use pandas melt to reshape the DataFrame
    # id_vars=['product']: keep 'product' as identifier column
    # var_name='quarter': new column name for the quarter labels
    # value_name='sales': new column name for the sales values
    long_format = pd.melt(
        report,
        id_vars=['product'],
        var_name='quarter',
        value_name='sales'
    )

    return long_format
