/**
 * @param {string[]} recipes
 * @param {string[][]} ingredients
 * @param {string[]} supplies
 * @return {string[]}
 */
 
 var findAllRecipes = function(recipes, ingredients, supplies) {
    // Track available ingredients using a set
    let available = new Set(supplies);
    let result = [];
    
    // Process each recipe in a loop until no new recipes can be made
    let madeProgress = true;
    
    while (madeProgress) {
        madeProgress = false;
        
        for (let i = 0; i < recipes.length; i++) {
            // If the recipe is already in available, skip it
            if (available.has(recipes[i])) {
                continue;
            }
            
            // Check if all ingredients for the recipe are available
            let canMake = true;
            for (let ingredient of ingredients[i]) {
                if (!available.has(ingredient)) {
                    canMake = false;
                    break;
                }
            }
            
            // If we can make the recipe, add it to available and result
            if (canMake) {
                available.add(recipes[i]);
                result.push(recipes[i]);
                madeProgress = true; // Mark progress so we re-check recipes
            }
        }
    }
    
    return result;
};
