# ByBus
#### An application created for travel lovers.

## Table Of Contents
- [Features](#features)
  - [In app Gifs](#in-app-gifs)
  - [Screens](#screens)
  - [Used Technologies](#used-technologies)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Installation](#installation)
- [Known Issues](#known-issues)
- [Nice to have](#nice-to-have)

# Features
## In app Gifs
| Home, Location & Bus Selection | Seat Selection & Info | Purchased Tickets |
| -------- | -------- | -------- |
| ![1-ByBusOptimized](https://github.com/guraygul/TGY2024-2-Homeworks/assets/58820744/9f1438d2-eb0e-404e-98bb-55d2e4487eba) | ![2-ByBus](https://github.com/guraygul/TGY2024-2-Homeworks/assets/58820744/3847ce23-1fc9-4256-ba29-6844b760b098) | ![3-ByBus](https://github.com/guraygul/TGY2024-2-Homeworks/assets/58820744/587d41e0-6f3d-479a-9572-5e96b6acd265) |

## Screens
#### Search a Province:
- Explore your country
- The data for the provinces comes from a Mock data.

#### Seat Selection
- Select your seat with a beautiful design
- See which seats are selected
- You can choose up to 5 seats

#### Info
- Fill in the contact details to confirm the ticket

#### Tickets
- You can view your purchased tickets on the My Tickets screen

## Used Technologies
- UIKit
- MVC
- CoreData
- Storyboard

## Tech Stack
- Xcode: Version 15.3
- Language: Swift 5.10
- Minimum iOS Version: 17.4
- Dependency Manager: N/A

## Architecture
| MVC Architecture |
| -------- |
| ![Model-View-Controller](https://github.com/guraygul/ByBus/assets/58820744/47a55800-3fbd-4aee-8951-421703c49dd4) |

In developing ByBus App, the storyboard approuch and MVC architecture are being used for these key reasons:
- The storyboard approach is used for its efficiency in designing user interfaces.
- The MVC architecture is used for effectively managing code structure.

## Getting Started
### Requirements
Before you begin, ensure you have the following:
- Xcode installed

### Installation
1. Clone the repository:
```
git clone https://github.com/guraygul/ByBus.git
```
2. Open the project in Xcode::
```bash
cd ByBus
open ByBus.xcodeproj
```
4. Build and run the project.

## Known Issues
- When you buy 1 ticket, Core Data sometimes shows 2 tickets.

## Nice to have
- It would be better if we used authenticaton
