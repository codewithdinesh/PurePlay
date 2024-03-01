# OTT Platform

## App Overview

This document provides a comprehensive overview of the Online OTT (Over-The-Top) Platform. The platform caters to three primary user roles: Admin, Creator, and Viewer. Each user type has distinct functionalities and access levels.

## User Types

### 1. Admin

- **Sign In/Sign Up**: Admins can sign in or sign up to access the platform.
- **Video Approval**: Admins have the authority to approve or reject videos uploaded by Creators.
- **Process Oversight**: Admins can monitor and manage all processes within the platform.

### 2. Creator (User A)

- **Sign In/Sign Up**: Creators can sign in or sign up to access the platform.
- **Collaboration**: Creators can collaborate with other Creators.
- **Video Upload**: Creators require approval from Admin before uploading videos.
- **Interactive Features**: Creators can like/comment on videos, view total viewership, and propose rates for subscription plans.
- **Wallet Options**: Creators have wallets for financial transactions.

### 3. Viewer (V1)

- **Sign In/Sign Up**: Viewers can sign in or sign up to access the platform.
- **Subscription**: Viewers can subscribe to individual Creators or the entire OTT Platform.
- **Interactive Features**: Viewers can like/comment on videos and view total viewership.
- **Wallet Options**: Viewers have wallets with virtual coins.
- **Top-Up**: Viewers can top up coins via payment.

## Completed Features

- All Users sign-up/login using JSON Web Tokens
- Video Uploading Backend
- Video Uploading Frontend
- Collaboration
- Video Viewing
- Video Player and video listing
- Video Like

## Pending Tasks

- **Wallet System**:
  - Add wallet options for all users.
  - Implement a coin-based system for viewers, allowing top-up via payment.
- **Subscription Management**:
  - Set up monthly/yearly subscription plans for Viewers.
  - Define initial free plans and allow Creators to propose rates for their content.
- **Video Comment**
- **Admin Dashboard**:
  - Process Oversight


To install the OTT Platform, which consists of a Flutter frontend app and a Node.js backend server, follow these installation steps:

### Prerequisites

- Flutter SDK installed on your development machine. You can follow the installation instructions from the [official Flutter website](https://flutter.dev/docs/get-started/install).
- Node.js installed on your development machine. You can download and install Node.js from the [official Node.js website](https://nodejs.org/).

### Installation Steps

#### Backend Server (/server)

1. Clone the backend server repository from the provided source.
   ```bash
   git clone <repository_url>
   ```

2. Navigate to the server directory.
   ```bash
   cd server
   ```

3. Install dependencies using npm.
   ```bash
   npm install
   ```

4. Start the backend server.
   ```bash
   npm run dev
   ```

5. Ensure that the backend server is running and accessible at the specified endpoint (e.g., `http://localhost:3000`).

#### Frontend Flutter App (ott_platform)

1. Clone the frontend Flutter app repository from the provided source.
   ```bash
   git clone <repository_url>
   ```

2. Navigate to the ott_platform directory.
   ```bash
   cd ott_platform
   ```

3. Update dependencies by running:
   ```bash
   flutter pub get
   ```

4. Start the Flutter app in your preferred development environment (e.g., Android Studio, VS Code).
   
5. Run the app using the following command:
   ```bash
   flutter run
   ```

6. Ensure that the frontend app is running and accessible on your emulator or physical device.

### Note:

- Make sure to configure the frontend app to communicate with the backend server by providing the appropriate endpoint URLs.
- If there are any environment-specific configurations required, please refer to the documentation provided with the source code or contact the development team for assistance.
- Make sure your development environment meets the system requirements for Flutter and Node.js as specified in their official documentation.
- For production deployment, make sure to follow best practices for securing your backend server and configuring your frontend app for optimal performance and user experience.