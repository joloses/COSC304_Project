<!DOCTYPE html>
<html>
<head>
    <title>AJ SPORTS Checkout Line</title>
    <script>
        function validateForm() {
           
            var ccNumber = document.getElementById("creditCardNumber").value;
            if (ccNumber.length !== 16 || isNaN(ccNumber)) {
                alert("Please enter a valid 16-digit credit card number.");
                return false;
            }

            
            var securityCode = document.getElementById("securityCode").value;
            if (securityCode.length !== 3 || isNaN(securityCode)) {
                alert("Please enter a valid 3-digit security code.");
                return false;
            }

           
            var expiryDate = document.getElementById("expiryDate").value;
            
            if (!isValidExpiryDate(expiryDate)) {
                alert("Please enter a valid expiry date.");
                return false;
            }

            return true;
        }

        function isValidExpiryDate(expiryDate) {
            var regex = /^(0[1-9]|1[0-2])\/\d{4}$/;
            return regex.test(expiryDate);
        }
    </script>
</head>
<body>

    <h1>Enter your information to complete the transaction:</h1>

    <form method="post" action="confirmation.jsp" onsubmit="return validateForm()">
        
        <label for="customerId">Customer ID:</label>
        <input type="text" name="customerId" id="customerId" size="50" required>
        <br>
    
        
        <label for="paymentMethod">Payment Method:</label>
        <select name="paymentMethod" id="paymentMethod" required>
            <option value="creditCard">Credit Card</option>
            <option value="paypal">PayPal</option>
            
        </select>
        <br>
    
        
        <label for="creditCardNumber">Credit Card Number:</label>
        <input type="text" name="creditCardNumber" id="creditCardNumber" size="20" maxlength="16" required>
        <br>
    
        <label for="securityCode">Security Code:</label>
        <input type="text" name="securityCode" id="securityCode" size="3" maxlength="3" required>
        <br>
    
        <label for="expiryDate">Expiry Date (MM/YYYY):</label>
        <input type="text" name="expiryDate" id="expiryDate" size="7" maxlength="7" required>
        <br>
    
        
        <label for="shipmentAddress">Shipment Address:</label>
        <input type="text" name="shipmentAddress" id="shipmentAddress" size="50" required>
        <br>
    
        <label for="shipmentCity">Shipment City:</label>
        <input type="text" name="shipmentCity" id="shipmentCity" size="50" required>
        <br>
    
        
        <input type="submit" value="Review Order">
        <input type="reset" value="Reset">
    </form>
    
    <style>
        body {
            background-color: #8F9779; 
            color: #5D5348; 
            font-family: Arial, sans-serif;
        }
    </style>
    
    </body>
    </html>