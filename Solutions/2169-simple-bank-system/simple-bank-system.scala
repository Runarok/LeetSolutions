/**
 * A class representing a simple banking system.
 * Each account has an initial balance and supports basic operations:
 * - transfer between two accounts
 * - deposit into an account
 * - withdraw from an account
 *
 * All operations must validate account numbers and ensure sufficient funds.
 */
class Bank(_balance: Array[Long]) {

  // Store balances as a mutable array.
  // Account i corresponds to index i - 1 in the array.
  private val balance = _balance

  /**
   * Transfers money from one account to another.
   *
   * @param account1 The source account number (1-indexed)
   * @param account2 The destination account number (1-indexed)
   * @param money The amount to transfer
   * @return true if the transfer is successful, false otherwise
   */
  def transfer(account1: Int, account2: Int, money: Long): Boolean = {
    // Validate both account numbers are within range
    if (!isValidAccount(account1) || !isValidAccount(account2)) return false

    // Check if the source account has enough funds
    if (balance(account1 - 1) < money) return false

    // Deduct money from account1 and add to account2
    balance(account1 - 1) -= money
    balance(account2 - 1) += money

    true // Operation successful
  }

  /**
   * Deposits money into an account.
   *
   * @param account The account number (1-indexed)
   * @param money The amount to deposit
   * @return true if the deposit is successful, false otherwise
   */
  def deposit(account: Int, money: Long): Boolean = {
    // Validate account number
    if (!isValidAccount(account)) return false

    // Add money to the account
    balance(account - 1) += money
    true
  }

  /**
   * Withdraws money from an account.
   *
   * @param account The account number (1-indexed)
   * @param money The amount to withdraw
   * @return true if the withdrawal is successful, false otherwise
   */
  def withdraw(account: Int, money: Long): Boolean = {
    // Validate account number
    if (!isValidAccount(account)) return false

    // Ensure sufficient balance
    if (balance(account - 1) < money) return false

    // Deduct the amount
    balance(account - 1) -= money
    true
  }

  /**
   * Helper method to check if an account number is valid.
   *
   * @param account The account number (1-indexed)
   * @return true if account number is within valid range, false otherwise
   */
  private def isValidAccount(account: Int): Boolean = {
    account >= 1 && account <= balance.length
  }
}

/**
 * Example usage:
 *
 * val obj = new Bank(Array(10L, 100L, 20L, 50L, 30L))
 * println(obj.withdraw(3, 10))   // true  -> balance[2] = 10
 * println(obj.transfer(5, 1, 20)) // true -> balance[4]=10, balance[0]=30
 * println(obj.deposit(5, 20))     // true -> balance[4]=30
 * println(obj.transfer(3, 4, 15)) // false (not enough money)
 * println(obj.withdraw(10, 50))   // false (invalid account)
 */