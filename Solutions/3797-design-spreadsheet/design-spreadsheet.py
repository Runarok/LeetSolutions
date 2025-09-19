# Your Spreadsheet object will be instantiated and called as such:
# obj = Spreadsheet(rows)
# obj.setCell(cell,value)
# obj.resetCell(cell)
# param_3 = obj.getValue(formula)

class Spreadsheet(object):

    def __init__(self, rows):
        """
        Initialize the spreadsheet.
        :param rows: int - Number of rows in the spreadsheet.
        
        The spreadsheet has 26 columns (labeled 'A' to 'Z') and `rows` rows (1-indexed).
        We use a dictionary to store only non-zero values that have been explicitly set.
        """
        self.rows = rows
        self.columns = 26  # Fixed: 'A' to 'Z'
        
        # Dictionary to store the values of explicitly set cells.
        # Key: cell string like "A1", Value: integer value of the cell.
        self.cells = {}

    def setCell(self, cell, value):
        """
        Sets the value of a specified cell.
        :param cell: str - Cell reference like 'A1'
        :param value: int - Value to set (0 <= value <= 10^5)
        
        Time Complexity: O(1)
        """
        self.cells[cell] = value

    def resetCell(self, cell):
        """
        Resets the specified cell to 0.
        :param cell: str - Cell reference like 'A1'
        
        If the cell is not in the dictionary, it's already considered 0.
        Time Complexity: O(1)
        """
        if cell in self.cells:
            del self.cells[cell]

    def getValue(self, formula):
        """
        Evaluates a formula of the form "=X+Y", where X and Y are either:
            - Non-negative integers (e.g., "5")
            - Cell references like "A1", "B10"
        
        :param formula: str - Formula like "=A1+B2" or "=5+7"
        :return: int - Computed sum
        
        Time Complexity: O(1) since parsing is constant-time.
        """
        # Strip the leading '='
        formula = formula[1:]

        # Split by '+'
        x_str, y_str = formula.split('+')

        # Get value of x: either an integer literal or a cell reference
        x_val = self._get_operand_value(x_str)

        # Get value of y: either an integer literal or a cell reference
        y_val = self._get_operand_value(y_str)

        return x_val + y_val

    def _get_operand_value(self, operand):
        """
        Helper method to return the integer value of an operand.
        If it's a digit, parse it as int. If it's a cell reference, get the value from self.cells.
        :param operand: str
        :return: int
        """
        if operand.isdigit():
            # It's a literal integer (e.g., "5")
            return int(operand)
        else:
            # It's a cell reference (e.g., "A1", "B10")
            # If the cell has not been set, it's considered 0
            return self.cells.get(operand, 0)
