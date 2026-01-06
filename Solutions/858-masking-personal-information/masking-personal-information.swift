class Solution {
    func maskPII(_ s: String) -> String {
        // -----------------------------------------
        // Step 1: Check if s is an email
        // Emails contain '@', phone numbers do not
        // -----------------------------------------
        if s.contains("@") {
            // -----------------------------------------
            // Step 1a: Split the email into name and domain
            // -----------------------------------------
            let parts = s.lowercased().split(separator: "@")  // lowercase all letters
            let name = parts[0]  // the part before '@'
            let domain = parts[1]  // the part after '@'
            
            // -----------------------------------------
            // Step 1b: Mask the name
            // Keep first and last character, middle replaced with 5 asterisks
            // Even if name is very short like "AB", still use 5 asterisks
            // -----------------------------------------
            let first = name.first!  // first character of name
            let last = name.last!    // last character of name
            let maskedName = "\(first)*****\(last)"
            
            // -----------------------------------------
            // Step 1c: Reconstruct the email
            // -----------------------------------------
            return maskedName + "@" + domain  // return masked email
        } else {
            // -----------------------------------------
            // Step 2: Mask phone number
            // -----------------------------------------
            
            // Step 2a: Remove all non-digit characters
            let digits = s.filter { $0.isNumber }  // keep only digits
            
            // Step 2b: Separate local number and country code
            // Local number is always last 10 digits
            let localNumber = String(digits.suffix(10))  // last 10 digits
            let countryCodeLength = digits.count - 10    // 0 to 3 digits
            
            // Step 2c: Build country code mask
            // Country code mask is '+' followed by '*' repeated countryCodeLength times
            var countryCodeMask = ""
            if countryCodeLength > 0 {
                countryCodeMask = "+" + String(repeating: "*", count: countryCodeLength) + "-"
            }
            
            // Step 2d: Build the local number mask
            // Format is always "***-***-XXXX" where XXXX is last 4 digits
            let localMask = "***-***-" + String(localNumber.suffix(4))
            
            // Step 2e: Combine country code mask with local number mask
            return countryCodeMask + localMask
        }
    }
}
