# TRU Task - E-commerce App

## Overview
This is an iOS e-commerce application built using SwiftUI, following the MVVM (Model-View-ViewModel) architectural pattern. The app demonstrates modern iOS development practices and efficient state management.

## Technical Stack
- **SwiftUI**: Modern declarative UI framework for iOS
- **MVVM Architecture**: For better separation of concerns and maintainability
- **CoreData**: For local data persistence
- **Alamofire**: For network requests
- **SkeletonUI**: For loading state animations

## Project Structure

### Views
- **AllProductsCV**: Main view displaying the product list
- **Components**:
  - `TopView`: Header component with user greeting
  - `SearchBarView`: Reusable search bar component
  - `ProductCardView`: Reusable product card component

### ViewModels
- **AllProductsVM**: Manages product data and business logic
  - Handles data fetching from API and local storage
  - Manages loading states
  - Implements pagination

### Models
- **Product**: Data model for product information
- **Rating**: Nested model for product ratings

### Services
- **CachingServices**: Manages local data persistence using CoreData
- **ConnectionManager**: Handles network connectivity

## Features
1. **Product Listing**
   - Grid/List view toggle
   - Infinite scrolling
   - Loading states with skeleton views
   - Smooth animations

2. **Offline Support**
   - Local data caching
   - Seamless offline/online experience

3. **UI/UX**
   - Modern and clean design
   - Responsive layout
   - Smooth transitions
   - Loading indicators

## Architecture Benefits
1. **SwiftUI + MVVM**
   - Better performance through declarative UI
   - Automatic state management
   - Easier testing and maintenance
   - Better code organization

2. **Component-Based Architecture**
   - Reusable UI components
   - Consistent design system
   - Easier maintenance
   - Better code reusability

3. **Data Management**
   - Efficient local caching
   - Optimized network requests
   - Better user experience

## Getting Started
1. Clone the repository
2. Open the project in Xcode
3. Build and run the project

## Requirements
- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Dependencies
- Alamofire
- SkeletonUI

## Author
Mohamed Dorgham 
