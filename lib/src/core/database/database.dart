export 'daos/daos.dart';
export 'tables/tables.dart';
export 'app_database.dart';

/// Database Structure
// - User Table
//  - id
//  - masterPassword (Hash)
//  - createdAt
//  - updatedAt
//
// - Template Table
//  - id
//  - name
//  - createdAt
//  - updatedAt
//
// -- TemplateField Table
//  - id
//  - templateId
//  - type (int)
//  - hintText (optional)
//  - createdAt
//
// - Password Table
//  - id
//  - templateId
//  - title
//  - iconPath
//  - has2fa
//  - authKey
//  - has2fa
//  - hasArchived
//  - createdAt
//  - updatedAt
//
// -- PasswordField Table
//  - id 
//  - passwordId
//  - TemplateFieldId
//  - value
//  - createdAt
//  - updatedAt
//
// - Collection Table
//  - id
//  - name 
//  - iconPath
//  - passwordCount
//  - createdAt
//  - updatedAt
//
// -- CollectionItem Table
//  - id
//  - collectionId 
//  - passwordId
//  - createdAt
//  - updatedAt
//
// - Card Table
//  - id
//  - title
//  - holderName
//  - number
//  - expireDate
//  - cvv
//  - pin
//  - hasArchived
//  - createdAt
//  - updatedAt
// 
// -- CardField Table
//  - id
//  - cardId
//  - type (int)
//  - value
//  - hintText (optional)
//  - createdAt
//
// - Wallet Table
//  - id
//  - title
//  - seedPhrase
//  - note (optional)
//  - hasArchived
//  - createdAt
// 
// -- Field Table
//  - id
//  - iconName
//  - type 
//  - hintText 
//  - createdAt
// 