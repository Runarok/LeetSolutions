import pandas as pd

def findHeavyAnimals(animals: pd.DataFrame) -> pd.DataFrame:
    """
    Find animals that weigh strictly more than 100 kilograms,
    sort them by weight in descending order, and return only the 'name' column.

    Parameters:
    animals (pd.DataFrame): DataFrame containing columns:
        - 'name' (object): animal's name
        - 'species' (object)
        - 'age' (int)
        - 'weight' (int)

    Returns:
    pd.DataFrame: DataFrame with only the 'name' column of animals
                  sorted by descending weight and filtered for weight > 100.
    """

    # Filter animals with weight > 100, sort by weight descending, and select only 'name'
    return animals.loc[animals['weight'] > 100] \
                  .sort_values('weight', ascending=False)[['name']]

# Example usage:
if __name__ == "__main__":
    # Sample data
    data = {
        "name": ["Tatiana", "Khaled", "Alex", "Jonathan", "Stefan", "Tommy"],
        "species": ["Snake", "Giraffe", "Leopard", "Monkey", "Bear", "Panda"],
        "age": [98, 50, 6, 45, 100, 26],
        "weight": [464, 41, 328, 463, 50, 349]
    }

    animals_df = pd.DataFrame(data)

    # Find heavy animals
    heavy_animals = findHeavyAnimals(animals_df)
    print(heavy_animals)
