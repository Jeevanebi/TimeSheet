# TimeSheet

![TimeSheet Screenshot]([path/to/your/screenshot.png](https://www.behance.net/gallery/153272217/Timesheet-Dashboard-Live-Project-Video-Tour/modules/995077333))

## Overview

TimeSheet is a comprehensive application designed to help manage and track time spent on various tasks and projects. It provides functionalities for logging work hours, generating reports, and managing project details effectively.

## Features

- User authentication and authorization
- Single Sign-On (SSO) with Google and Microsoft login
- Create, read, update, and delete (CRUD) operations for timesheets
- Project and task management (in progress)
- Reporting and analytics (in progress)
- Integration with sample database

## Technologies Used

- ASP.NET Framework (WebForms)
- Entity Framework
- SQL Server
- JavaScript, HTML, CSS
- Bootstrap

## Getting Started

### Prerequisites

- .NET Framework
- SQL Server
- Visual Studio

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Jeevanebi/TimeSheet.git
   ```
2. Navigate to the project directory:
   ```bash
   cd TimeSheet
   ```
3. Open the project in Visual Studio.
4. Update the connection string in `Web.config` to point to your SQL Server instance:
   ```xml
   <connectionStrings>
     <add name="DefaultConnection" connectionString="Server=your_server_name;Database=TimeSheetDb;User Id=your_user_id;Password=your_password;" providerName="System.Data.SqlClient"/>
   </connectionStrings>
   ```
   Note: Kindly Restore the test DB nameed Timesheet_DB(Attached)
5. Apply migrations and seed the database.
6. Run the application by pressing `F5` in Visual Studio.

### Usage

1. Open a web browser and navigate to `http://localhost:your_port`.
2. Register a new account or log in with existing credentials.
3. Use SSO with Google or Microsoft to log in.
4. Start creating and managing your timesheets, projects, and tasks.

## Screenshots

![Login Page]([View](https://www.behance.net/gallery/153318455/TimeSheet-UI-(Dashboard)/modules/865259387))
*Login Page*

![Dashboard]([View](https://www.behance.net/gallery/153318455/TimeSheet-UI-(Dashboard)/modules/865259391))
*Dashboard*

![Timesheet Entry]([View](https://www.behance.net/gallery/153318455/TimeSheet-UI-(Dashboard)/modules/865259393))
*Timesheet Entry*

## Current Status

The CRUD operations for timesheets are fully implemented. SSO with Google and Microsoft login is integrated. Some functionalities, such as project and task management, as well as reporting and analytics, are still in progress and will be completed in future updates.

## Sample Database

A sample database is included in the project to help you get started quickly. The database file can be found in the `SampleDb` directory.

## Demo Video

Watch the demo video of the working application on LinkedIn:
[![Video Preview]([Video](https://www.behance.net/gallery/153272217/Timesheet-Dashboard-Live-Project-Video-Tour))]([https://www.linkedin.com/embed/feed/update/urn:li:ugcPost:12345678901234567890](https://www.behance.net/gallery/153272217/Timesheet-Dashboard-Live-Project-Video-Tour))

## Contributing

Contributions are welcome! Please fork this repository and submit pull requests with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or inquiries, please contact me at [work.jeevanebi@gmail.com](mailto:work.jeevanebi@gmail.com).
```

