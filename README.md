# Blockchain-Based Food and Beverage Allergen Management System

A comprehensive blockchain solution for managing food allergens, ensuring transparency, and protecting consumers with allergies through smart contract automation.

## 🎯 Overview

This system provides a decentralized platform for tracking food ingredients, managing allergen information, preventing cross-contamination, and alerting consumers about potential allergen risks. Built on the Stacks blockchain using Clarity smart contracts.

## 🏗️ Architecture

### Smart Contracts

1. **Business Verification Contract** (`business-verification.clar`)
    - Registers and verifies food businesses
    - Manages business licenses and certifications
    - Tracks verification status and expiry dates

2. **Ingredient Tracking Contract** (`ingredient-tracking.clar`)
    - Tracks individual ingredients and their allergen content
    - Links ingredients to products
    - Calculates combined allergen profiles for products

3. **Cross-Contamination Contract** (`cross-contamination.clar`)
    - Manages equipment and facility allergen exposure
    - Tracks cleaning logs and verification
    - Prevents allergen cross-contamination risks

4. **Labeling Verification Contract** (`labeling-verification.clar`)
    - Verifies accuracy of product allergen labels
    - Maintains verification history
    - Identifies undeclared allergens

5. **Consumer Alert Contract** (`consumer-alert.clar`)
    - Manages consumer allergen subscriptions
    - Issues and tracks allergen alerts
    - Handles alert acknowledgments

## 🔧 Features

### For Food Businesses
- **Business Registration**: Register and verify food business credentials
- **Ingredient Management**: Track ingredients with detailed allergen information
- **Equipment Tracking**: Monitor equipment for allergen contamination
- **Label Verification**: Ensure accurate allergen labeling
- **Compliance Monitoring**: Maintain regulatory compliance records

### For Consumers
- **Allergen Subscriptions**: Subscribe to specific allergen alerts
- **Real-time Notifications**: Receive immediate alerts about allergen risks
- **Product Verification**: Verify product allergen information
- **Alert Management**: Acknowledge and track received alerts

### For Regulators
- **Business Oversight**: Monitor registered businesses and their compliance
- **Verification Management**: Verify business credentials and product labels
- **Alert Issuance**: Issue critical allergen alerts to consumers
- **Audit Trail**: Access complete history of all transactions

## 🚀 Getting Started

### Prerequisites
- Stacks blockchain node or access to testnet
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd allergen-management-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:
\`\`\`bash
# Deploy business verification contract
clarinet deploy --testnet contracts/business-verification.clar

# Deploy other contracts in order
clarinet deploy --testnet contracts/ingredient-tracking.clar
clarinet deploy --testnet contracts/cross-contamination.clar
clarinet deploy --testnet contracts/labeling-verification.clar
clarinet deploy --testnet contracts/consumer-alert.clar
\`\`\`

## 📊 Usage Examples

### Register a Food Business
\`\`\`clarity
(contract-call? .business-verification register-business
"Acme Food Co"
"FL-12345")
\`\`\`

### Add an Ingredient with Allergens
\`\`\`clarity
(contract-call? .ingredient-tracking add-ingredient
"Wheat Flour"
u64  ;; ALLERGEN_WHEAT flag
"BATCH-2024-001"
u1000000)  ;; expiry block height
\`\`\`

### Subscribe to Allergen Alerts
\`\`\`clarity
(contract-call? .consumer-alert subscribe-to-alerts
u96  ;; WHEAT + PEANUTS flags
u1)   ;; notification preferences
\`\`\`

## 🧪 Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test business-verification.test.js

# Run tests with coverage
npm run test:coverage
\`\`\`

## 🔒 Security Features

- **Access Control**: Role-based permissions for different user types
- **Data Integrity**: Immutable blockchain storage ensures data cannot be tampered
- **Verification Chain**: Multi-step verification process for critical operations
- **Audit Trail**: Complete transaction history for compliance and debugging

## 🌟 Allergen Support

The system supports tracking of major allergens:
- Milk (dairy)
- Eggs
- Fish
- Shellfish
- Tree nuts
- Peanuts
- Wheat (gluten)
- Soybeans

## 📈 Roadmap

- [ ] Integration with IoT sensors for real-time contamination detection
- [ ] Mobile app for consumer notifications
- [ ] Integration with existing food safety management systems
- [ ] Multi-language support for international deployment
- [ ] Advanced analytics and reporting dashboard

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation wiki

## 🙏 Acknowledgments

- Stacks blockchain community
- Food safety regulatory bodies
- Open source contributors
- Food allergy advocacy groups
  \`\`\`
